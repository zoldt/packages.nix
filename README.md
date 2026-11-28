# packages.nix

Packages that aren't in nixpkgs, as one overlay:

```nix
nixpkgs.overlays = [inputs.zoldt-pkgs.overlays.default];
```

Then use them as `pkgs.<name>`. Packages that build as-is are also exported as
`packages`, and `nix run github:zoldt/packages.nix#<app>` runs the `switch` and
`import-win-ca` apps.

`headscale-remote` needs to know which server to reach:

```nix
pkgs.headscale-remote.override {sshDestination = "user@headscale-host";}
```

To add a package, put it in `modules/pkgs/<name>/` with a module that sets
`overlayPackages.<name> = final: final.callPackage ./_package.nix {};`.
