#!/usr/bin/env node
import fs from "fs";
import path from "path";
import glob from "glob";
import { createRequire } from "module";
import semver from "semver";

const root = process.cwd();
const rootPkgPath = path.join(root, "package.json");
const rootPkg = JSON.parse(fs.readFileSync(rootPkgPath, "utf-8"));

const workspaces = rootPkg.workspaces || [];

/**
 * Picks the newest / highest semantic version.
 * If versions are not valid semver (e.g., "*", "latest"), fall back to replacing.
 */
function pickNewest(existing, incoming) {
  if (!existing) return incoming;

  // If both valid semver ranges
  if (semver.validRange(existing) && semver.validRange(incoming)) {
    return semver.intersects(incoming, existing)
      ? semver.maxSatisfying(
          [existing.replace(/^\^|~/, ""), incoming.replace(/^\^|~/, "")],
          incoming.replace(/^\^|~/, "")
        ) || incoming
      : incoming;
  }

  // Fallback: replace if incoming looks newer or is a tag
  return incoming;
}

function safeAdd(obj, key, version) {
  obj[key] = pickNewest(obj[key], version);
}

const mergedDeps = {};
const mergedDevDeps = {};

console.log("🔍 Scanning workspaces:", workspaces);

const workspacePaths = workspaces.flatMap((pattern) => glob.sync(pattern));

for (const wsPath of workspacePaths) {
  const pkgJsonPath = path.join(root, wsPath, "package.json");

  if (!fs.existsSync(pkgJsonPath)) continue;

  // Use ESM-friendly context require
  const localRequire = createRequire(path.join(root, wsPath) + "/");
  const pkg = localRequire("./package.json");

  console.log("📦 Loaded workspace:", pkgJsonPath);

  if (pkg.dependencies) {
    for (const [name, ver] of Object.entries(pkg.dependencies)) {
      safeAdd(mergedDeps, name, ver);
    }
  }

  if (pkg.devDependencies) {
    for (const [name, ver] of Object.entries(pkg.devDependencies)) {
      safeAdd(mergedDevDeps, name, ver);
    }
  }
}

// Merge into root
rootPkg.dependencies = { ...(rootPkg.dependencies || {}), ...mergedDeps };
rootPkg.devDependencies = { ...(rootPkg.devDependencies || {}), ...mergedDevDeps };

// Write updated root package.json
fs.writeFileSync(rootPkgPath, JSON.stringify(rootPkg, null, 2));

console.log("✅ Dependencies merged with version dedupe.");
console.log("👉 Run npm install to apply changes.");
