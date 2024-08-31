name: Documentation

on:
  push:
    branches:
      - main  # or master or your main branch
    tags: '*'
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      
      - name: Set up Julia
        uses: julia-actions/setup-julia@v1
        with:
          version: '1.6'
      
      - name: Install dependencies
        run: julia --project=docs/ -e 'using Pkg; Pkg.develop(PackageSpec(path=pwd())); Pkg.instantiate()'
      
      - name: Build and deploy documentation
        env:
          DOCUMENTER_KEY: ${{ secrets.DOCUMENTER_KEY }}
        run: julia --project=docs/ docs/make.jl
