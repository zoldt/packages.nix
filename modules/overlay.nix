# The flake's one overlay. Each package module adds `overlayPackages.<name> =
# final: <derivation>`; this collects them into `overlays.default`, applies it to
# this flake's own `pkgs`, and exports the packages that build as-is as `packages`.
{
  config,
  inputs,
  lib,
  ...
}: {
  options.overlayPackages = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.functionTo lib.types.raw);
    default = {};
    description = "Packages added by the overlay, each a function of the final package set.";
  };

  config = {
    flake.overlays.default = final: _prev: builtins.mapAttrs (_: package: package final) config.overlayPackages;

    perSystem = {
      pkgs,
      system,
      ...
    }: {
      _module.args.pkgs = inputs.nixpkgs.legacyPackages.${system}.extend config.flake.overlays.default;

      # Like Hydra: skip unfree packages and those with `meta.hydraPlatforms = []`
      # (they need an override before they build).
      packages = lib.filterAttrs (_: package: !(package.meta.unfree or false) && package.meta.hydraPlatforms or null != []) (
        builtins.mapAttrs (name: _: pkgs.${name}) config.overlayPackages
      );
    };
  };
}
