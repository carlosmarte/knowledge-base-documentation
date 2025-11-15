#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const root = process.cwd();
const rootPkg = require(path.join(root, 'package.json'));
const workspaces = rootPkg.workspaces || [];

const glob = require('glob');

function safeAdd(obj, key, version) {
  if (!obj[key]) obj[key] = version;
}

const mergedDeps = {};
const mergedDevDeps = {};

console.log("🔍 Scanning workspaces:", workspaces);

const workspacePaths = workspaces.flatMap((pattern) => glob.sync(pattern));

workspacePaths.forEach((wsPath) => {
  const pkgPath = path.join(root, wsPath, 'package.json');

  if (!fs.existsSync(pkgPath)) return;

  const pkg = require(pkgPath);
  console.log("📦 Found workspace pkg:", pkgPath);

  if (pkg.dependencies) {
    Object.entries(pkg.dependencies).forEach(([k, v]) => {
      safeAdd(mergedDeps, k, v);
    });
  }

  if (pkg.devDependencies) {
    Object.entries(pkg.devDependencies).forEach(([k, v]) => {
      safeAdd(mergedDevDeps, k, v);
    });
  }
});

// Merge into root package.json
rootPkg.dependencies = { ...(rootPkg.dependencies || {}), ...mergedDeps };
rootPkg.devDependencies = { ...(rootPkg.devDependencies || {}), ...mergedDevDeps };

fs.writeFileSync(
  path.join(root, 'package.json'),
  JSON.stringify(rootPkg, null, 2)
);

console.log("✅ Root dependencies merged successfully.");
console.log("👉 Now run: npm install");
