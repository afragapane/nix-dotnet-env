{}:
let
  pkgs = builtins.fetchTarball {
    # Descriptive name to make the store path easier to identify
    name = "nixos-unstable-2019-02-01";
    # Commit hash for nixos-unstable as of 2019-02-01
    url = https://github.com/nixos/nixpkgs/archive/0b34de031e304c45c403983258b744b962609339.tar.gz;
    # Hash obtained using `nix-prefetch-url --unpack <url>`
    sha256 = "0njba3hsllb0kvhpnmarx721kzy9ds18mrbj4mq8hnkhk9sb88mg";
  };

  dotnet-sdk = self: super: {
      dotnet-sdk = 
      if self.stdenv.hostPlatform.isDarwin
      then super.dotnet-sdk.overrideAttrs (old:
        rec {
            version = "2.2.103";
            netCoreVersion = "2.2.1";
            name = "dotnet-sdk-${version}";

            src = self.fetchurl {
              url = https://download.visualstudio.microsoft.com/download/pr/7315b6a5-b535-4349-892a-7ec82b573724/f44f5f852f0ef4364cff9d00035a3987/dotnet-sdk-2.2.103-osx-x64.tar.gz;
              sha256 = "1p2c89kj5jwa9pziq3i3bhdss1pznnzk9l3mdipybk0mj0jp64iq";
            };

            buildPhase = ''
              runHook preBuild
              echo -n "dotnet-sdk version: "
              ./dotnet --version
              runHook postBuild
            '';

            meta = with self.stdenv.lib; old.meta // {
              platforms = platforms.linux ++ platforms.darwin;
            };
        }
      )
      else super.dotnet-sdk;
  };
in
  import pkgs {
      overlays = [
          dotnet-sdk
      ];
  }
