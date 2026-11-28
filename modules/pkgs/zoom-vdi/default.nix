{
  # Zoom's VDI plugin, for the Citrix Workspace client below.
  overlayPackages.zoom-vdi = final: import ./_package.nix {pkgs = final;};
}
