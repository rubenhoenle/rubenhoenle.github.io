[![CI/CD](https://github.com/rubenhoenle/rubenhoenle.github.io/actions/workflows/build.yaml/badge.svg?branch=main)](https://github.com/rubenhoenle/rubenhoenle.github.io/actions/workflows/build.yaml)

# GitHub Pages

This repository contains the sources for [my homepage](https://hoenle.xyz).

The main part is my homepage which basically just static html.
The other part is some [asciidoc](https://asciidoc.org/) which is rendered using [asciidoctor](https://asciidoctor.org/).

## Build using NixOS

It is possible to generate the static HTML sites using the NixOS flake.
After the generation is complete, a webserver will start and serve the page under `http://localhost:8000`.
`nix run .#`
