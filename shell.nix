{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/c81c2414155adffb06d68b894f791dc243ecf2ae.tar.gz") { config = { allowUnfree = true; }; } }:

pkgs.mkShellNoCC {
  packages = with pkgs; [
    docker
    git
    cowsay
  ];

  shellHook = ''
    echo "Welcome to the Shell! May your pipelines be green." | cowsay -f dragon
  '';
}
