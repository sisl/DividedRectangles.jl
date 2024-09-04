name: Build and Deploy Documentation

on:
  push:
    branches:
      - add-test-only  # Change to your default branch if it's not 'main'

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Check out the repository
      uses: actions/checkout@v3

    - name: Set up Julia
      uses: julia-actions/setup-julia@v1
      with:
        version: '1.10'  # Ensure this matches your Julia version

    - name: Install dependencies
      run: julia --project=. -e 'using Pkg; Pkg.instantiate()'

    - name: Build documentation
      run: julia --project=docs -e 'include("docs/make.jl")'

    - name: Deploy to GitHub Pages
      if: github.ref == 'refs/heads/main'  # Deploy only on the main branch
      uses: JamesIves/github-pages-deploy-action@v4
      with:
        branch: gh-pages  # Deploy to the 'gh-pages' branch
        folder: docs/build  # Location of the generated documentation
