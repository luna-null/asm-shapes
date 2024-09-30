{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    pkg-config
    openssl
    nasm
    qemu
    libstdcxx5
    asm-lsp
  ];

  # Set the PKG_CONFIG_PATH environment variable
  shellHook = ''
    export PKG_CONFIG_PATH=${pkgs.openssl}/lib/pkgconfig:$PKG_CONFIG_PATH
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
  '';
}


