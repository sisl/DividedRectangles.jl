name: Documentation

on:
  push:
    branches:
      - main  # Use your primary branch
    tags: '*'
  pull_request:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout the repository
        uses: actions/checkout@v4
      
      - name: Set up Julia
        uses: julia-actions/setup-julia@v1
        with:
          version: '1.6'  # Specify the Julia version you need

      - name: Install dependencies
        run: julia --project=docs/ -e 'using Pkg; Pkg.develop(PackageSpec(path=pwd())); Pkg.instantiate()'

      - name: Build and deploy documentation
        env:
          DOCUMENTER_KEY: ${{ secrets.DOCUMENTER_KEY }}
        run: julia --project=docs/ docs/make.jl
