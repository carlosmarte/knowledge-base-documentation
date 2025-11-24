pip-install() {
  if [ -z "$1" ]; then
    echo "❌ Usage: pip-install <package-name>"
    return 1
  fi

  package="$1"

  echo "📦 Installing $package..."
  pip install "$package" || { echo "❌ pip install failed"; return 1; }

  if [ -f requirements.txt ]; then
    echo "🧹 Removing any existing entry for $package from requirements.txt..."
    sed -i '' "/^$package[=<>!~]/d" requirements.txt
  else
    touch requirements.txt
  fi

  echo "📄 Adding frozen version of $package to requirements.txt..."
  pip freeze | grep -i "^$package==" >> requirements.txt

  echo "✅ $package installed and updated in requirements.txt"
}
