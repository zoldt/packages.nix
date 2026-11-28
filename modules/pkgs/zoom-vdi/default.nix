{
  # Zoom's VDI plugin, linked into citrix-workspace-vdi.
  overlayPackages.zoom-vdi = final: final.callPackage ./_package.nix {};
}
