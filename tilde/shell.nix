let
  pkgs = import (builtins.fetchTarball {
    name = "nixos-unstable-2024-06-05";
    url = "https://github.com/nixos/nixpkgs/archive/57610d2f8f0937f39dbd72251e9614b1561942d8.tar.gz";
    sha256 = "0k8az8vmfdk1n8xlza252sqk0hm1hfc7g67adin6jxqaab2s34n9";
  }) { };
in
pkgs.mkShell {
  packages = [
    pkgs.bashInteractive
    pkgs.cacert
    pkgs.check-jsonschema
    pkgs.deadnix
    pkgs.editorconfig-checker
    pkgs.gitFull
    pkgs.gitlint
    pkgs.nixfmt-rfc-style
    pkgs.nodePackages.prettier
    pkgs.pre-commit
    pkgs.shellcheck
    pkgs.shfmt
    pkgs.statix
    pkgs.yq-go
  ];
  env.LOCALE_ARCHIVE = "${pkgs.glibcLocales}/lib/locale/locale-archive";
}
