#!/bin/bash
set -e

echo "🚀 Setting up GitHub Pages for Helm Charts Repository"
echo ""

# Check if we're on main branch
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "❌ Error: You must be on the 'main' branch"
    echo "   Current branch: $CURRENT_BRANCH"
    exit 1
fi

# Check if there are uncommitted changes
if ! git diff-index --quiet HEAD --; then
    echo "❌ Error: You have uncommitted changes"
    echo "   Please commit or stash your changes first"
    exit 1
fi

echo "✅ On main branch with clean working directory"
echo ""

# Create gh-pages branch
echo "📝 Creating gh-pages branch..."
git checkout --orphan gh-pages
git rm -rf .

# Create initial README
cat > README.md << 'EOF'
# Helm Charts Repository

This branch contains the Helm charts index for the repository.

Charts are automatically published here by GitHub Actions.

## Usage

```bash
helm repo add sakowicz https://helm.sakowi.cz
helm repo update
```

For more information, see the [main branch](https://github.com/sakowicz/charts).
EOF

# Create CNAME file for custom domain
echo "helm.sakowi.cz" > CNAME

git add README.md CNAME
git commit -m "Initialize gh-pages branch with custom domain"

echo "✅ Created gh-pages branch with CNAME"
echo ""

# Push gh-pages
echo "📤 Pushing gh-pages branch to origin..."
git push origin gh-pages

echo "✅ Pushed gh-pages branch"
echo ""

# Return to main
echo "🔄 Returning to main branch..."
git checkout main

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo ""
echo "   1. Configure DNS for helm.sakowi.cz:"
echo "      Add a CNAME record pointing to: sakowicz.github.io"
echo ""
echo "   2. Go to https://github.com/sakowicz/charts/settings/pages"
echo "      - Set Source to 'Deploy from a branch'"
echo "      - Select branch 'gh-pages' and folder '/ (root)'"
echo "      - Custom domain should show: helm.sakowi.cz"
echo "      - Click Save"
echo "      - Wait for DNS check to complete"
echo "      - Enable 'Enforce HTTPS' (after DNS propagates)"
echo ""
echo "   3. Go to https://github.com/sakowicz/charts/settings/actions"
echo "      Under 'Workflow permissions', select:"
echo "      - Read and write permissions"
echo "      - Allow GitHub Actions to create and approve pull requests"
echo "      - Click Save"
echo ""
echo "   4. Push your changes to trigger the first release:"
echo "      git push origin main"
echo ""
echo "   Your charts will be available at:"
echo "   - OCI: oci://ghcr.io/sakowicz/charts/<chart-name>"
echo "   - Traditional: https://helm.sakowi.cz"
echo ""

