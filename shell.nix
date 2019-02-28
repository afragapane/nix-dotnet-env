let
  pkgs = import ./nixpkgs.nix {};
in 
  if pkgs.lib.inNixShell
  then pkgs.mkShell {
      buildInputs = [
          pkgs.vim
          pkgs.git
          pkgs.nix
          pkgs.curl
          pkgs.dotnet-sdk
      ];
    }
  else pkgs