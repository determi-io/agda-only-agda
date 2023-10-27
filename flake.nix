{
  description = "A very basic flake";

  inputs =
  {
    nixpkgs.url = "github:NixOS/nixpkgs/038b2922be3fc096e1d456f93f7d0f4090628729";
    flake-utils.url = "github:numtide/flake-utils";
    agda = "github:determi-io/agda";
  };

  outputs = { self, nixpkgs, flake-utils, agda }:

    flake-utils.lib.eachDefaultSystem (system:
      let a = "a";
      in
      {
        packages.default = derivation {
          name = "determi-io-agda-only-agda";
          builder = "${pkgs.bash}/bin/bash";
          args = [ ./builder.sh ];
          STDLIB_ROOT = ./.;
          CP = "${pkgs.coreutils}/bin/cp";
          MKDIR = "${pkgs.coreutils}/bin/mkdir";
          LS = "${pkgs.coreutils}/bin/ls";
          ECHO = "${pkgs.coreutils}/bin/echo";
          PWD = "${pkgs.coreutils}/bin/pwd";
          CHMOD = "${pkgs.coreutils}/bin/chmod";
          STACK = "${pkgs.stack}/bin/stack";
          AGDA = "${agda.outputs.packages.x86_64-linux.Agda}/bin/agda";
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
