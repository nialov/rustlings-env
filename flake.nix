{
  description = "Description for the project";

  inputs = {
    nix-extra = { url = "github:nialov/nix-extra"; };
    nixpkgs.url =
      "github:nixos/nixpkgs/bc9cbcde0ec2d8086422c46e7904537270c39d50";
    flake-parts.follows = "nix-extra/flake-parts";
  };

  outputs = inputs:
    let
      flakePart = inputs.flake-parts.lib.mkFlake { inherit inputs; }
        ({ inputs, ... }: {
          systems = [ "x86_64-linux" ];
          imports = [
            inputs.nix-extra.flakeModules.custom-pre-commit-hooks
            ./per-system.nix
          ];
        });

    in flakePart;

}
