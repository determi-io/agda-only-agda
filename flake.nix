{
  description = "A very basic flake";

  inputs =
  {
    nixpkgs.url = "github:NixOS/nixpkgs/038b2922be3fc096e1d456f93f7d0f4090628729";
    flake-utils.url = "github:numtide/flake-utils";
    agda =
    {
      type = "github";
      owner = "determi-io";
      repo = "agda";
      ref = "freeze-2023-10-25";
    };
  };

  outputs = { self, nixpkgs, flake-utils, agda }:

    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          name = "determi-io-agda-only-agda";
          builder = ./builder.sh;
          buildInputs = [ pkgs.coreutils pkgs.findutils pkgs.makeWrapper ];
          # builder = "${pkgs.bash}/bin/bash";
          # args = [ ./builder.sh ];
          # STDLIB_ROOT = ./.;
          # CP = "${pkgs.coreutils}/bin/cp";
          # MKDIR = "${pkgs.coreutils}/bin/mkdir";
          # LS = "${pkgs.coreutils}/bin/ls";
          # ECHO = "${pkgs.coreutils}/bin/echo";
          # PWD = "${pkgs.coreutils}/bin/pwd";
          # CHMOD = "${pkgs.coreutils}/bin/chmod";
          # DIRNAME = "${pkgs.coreutils}/bin/dirname";
          # FIND = "${pkgs.findutils}/bin/find";
          # STACK = "${pkgs.stack}/bin/stack";
          AGDA = "${agda.outputs.packages.x86_64-linux.agda}";
          # WRAPPROGRAM = "${pkgs.makeWrapper}";
          LOCALE_ARCHIVE = "${pkgs.glibcLocalesUtf8}/lib/locale/locale-archive";
          LOCALE = "${pkgs.locale}/bin/locale";
          LC_ALL= "en_US.utf8";
          inherit system;
          src = ./.;
        };



        # packages.default = derivation {
        #   name = "agda-only-agda";
        #   builder = agda-driver-bin;
        #   args = [ ./src ];
        #   inherit system;

        #   # AGDA_INCLUDES = "${agda-stdlib.packages.${system}.default}/src";
        #   BLA = "";
        # };
      }
    )
;
}
