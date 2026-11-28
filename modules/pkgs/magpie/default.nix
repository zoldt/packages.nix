{
  overlayPackages = {
    magpie-cli = final: final.callPackage ./_package-cli.nix {};
    magpie-desktop = final: final.callPackage ./_package-desktop.nix {};
  };
}
