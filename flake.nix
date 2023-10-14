{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
  };

  outputs = { self, nixpkgs, ... }:
  let
    pkgs = import nixpkgs { system = "x86_64-linux"; };
  in
  {
    packages.x86_64-linux = 
    let
      asciidoc-blog = pkgs.stdenv.mkDerivation {
        name = "blog-asciidoc";
        src = ./asciidoc;
        buildInputs = with pkgs; [
          asciidoctor
        ];
        installPhase = ''
          mkdir -p $out/docs
          asciidoctor -D $out/docs -R . ./**/*.adoc
        '';
      };

      jekyll-blog = pkgs.stdenv.mkDerivation {
        name = "blog-jekyll";
        src = ./blog;
        buildInputs = with pkgs; [
          jekyll
          rubyPackages.jekyll-paginate
          rubyPackages.jekyll-feed 
        ];
        buildPhase = '' 
          jekyll build
        '';
        installPhase = ''
          mkdir -p $out/
          cp -r _site/* $out/
        '';
      };
      merge = pkgs.symlinkJoin {
        name = "merge jekyll and asciidoc";
        paths = [
          jekyll-blog
          asciidoc-blog
        ];
      };
    in
    {
      default = pkgs.writeScriptBin "serve" ''
        ${pkgs.devd}/bin/devd ${merge}
      '';
    };
  };
}
