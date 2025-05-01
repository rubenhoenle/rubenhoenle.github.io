{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-23.05";
  };

  outputs = { nixpkgs, ... }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in
    {
      packages.x86_64-linux =
        let
          homepage = pkgs.stdenv.mkDerivation {
            name = "homepage";
            src = ./homepage;
            installPhase = ''
              mkdir -p $out/docs
              cp index.html $out
              cp main.css $out
            '';
          };
          asciidoc = pkgs.stdenv.mkDerivation {
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
          merge = pkgs.symlinkJoin {
            name = "merge homepage and asciidoc";
            paths = [
              homepage
              asciidoc
            ];
          };
          deploy-html = pkgs.writeShellApplication {
            name = "deploy-html";
            text = ''
              ${pkgs.openssh}/bin/scp -r ${merge}/* www-deploy@vps:/var/www/homepage
            '';
          };
        in
        {
          default = pkgs.writeScriptBin "serve" ''
            ${pkgs.devd}/bin/devd ${merge}
          '';
          html = merge;
          deploy = deploy-html;
        };
    };
}
