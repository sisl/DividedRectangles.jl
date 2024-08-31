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
      - uses: actions/checkout@v4
      - uses: julia-actions/setup-julia@v1
        with:
          version: '1.6'
      - run: julia --project=docs/ -e 'using Pkg; Pkg.develop(PackageSpec(path=pwd())); Pkg.instantiate()'
      - run: julia --project=docs/ docs/make.jl

