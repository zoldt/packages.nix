{inputs, ...}: let
  keeper = final: final.callPackage ./_package.nix {inherit (inputs) uv2nix pyproject-nix pyproject-build-systems;};
in {
  overlayPackages = {
    keeper-commander = final: (keeper final).keeper-commander;
    keeper-secrets-manager-cli = final: (keeper final).keeper-secrets-manager-cli;
  };
}
