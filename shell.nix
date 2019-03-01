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

      shellHook = ''
        export GIT_SSL_CAINFO="${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
      '';
    }
  else pkgs