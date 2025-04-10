{
  description = "R and LaTex";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      rEnv = pkgs.rWrapper.override {
        packages = with pkgs.rPackages; [
          bookdown
          svglite
          knitr
          rmarkdown
          htmlwidgets
          webshot
          DT
          remotes
          commonmark
          ggplot2
          leaflet
          miniUI
          shiny
          httr
          RefManageR
        ];
      };
    in
    {
      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = [
          rEnv
          pkgs.gnumake
          pkgs.curl
          pkgs.xml2
          pkgs.openssl
          pkgs.ghostscript
        ];
      };
      shellHook = ''
          export R_LIBS_SITE=${rEnv}/R/library
        '';
    };
}
