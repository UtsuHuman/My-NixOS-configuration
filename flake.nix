{
  inputs = {
    freesm.url = "github:FreesmTeam/FreesmLauncher/develop";
  };

  outputs = { self, nixpkgs, freesm }: {
    packages.x86_64-linux.default = freesm.packages.x86_64-linux.default;

    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ({ pkgs, ... }: {
          environment.systemPackages = [
            freesm.packages.${pkgs.system}.default
          ];
        })
      ];
    };
  };
}
