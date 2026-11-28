{
  # nixpkgs' Citrix Workspace client with the Zoom VDI plugin linked in (Zoom's
  # audio and video run locally instead of through the remote desktop).
  overlayPackages.citrix-workspace-vdi = final:
    final.citrix-workspace.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or []) ++ [final.python3];
      postInstall =
        (old.postInstall or "")
        + ''
          root="$out/opt/citrix-icaclient"
          ln -s ${final.zoom-vdi}/lib/libZoomPlugin.so "$root/ZoomMedia.so"
          chmod u+w "$root/config/module.ini"
          python3 ${./configure.py} "$root/config/module.ini"
        '';
    });
}
