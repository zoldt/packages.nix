# The flake's one overlay. Each package module adds `overlayPackages.<name> =
# final: <derivation>`; this collects them into `modules.overlays.default`, and
# the free ones into `packages`.
{
  config,
  lib,
  ...
}: let
  overlay = final: _prev: builtins.mapAttrs (_: package: package final) config.overlayPackages;
in {
  options.overlayPackages = lib.mkOption {
    type = lib.types.lazyAttrsOf (lib.types.functionTo lib.types.raw);
    default = {};
    description = "Packages added by the overlay, each a function of the final package set.";
  };

  config = {
    flake.modules.overlays.default = overlay;

    perSystem = {pkgs, ...}: let
      final = pkgs.extend overlay;
    in {
      packages = lib.filterAttrs (_: package: !(package.meta.unfree or false)) (
        builtins.mapAttrs (name: _: final.${name}) config.overlayPackages
      );
    };
  };
}
