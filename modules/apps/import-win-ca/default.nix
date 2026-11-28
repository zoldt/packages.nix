{
  perSystem = {pkgs, ...}: {
    # The Windows half (windows-cas.py) runs under uv.exe, so the whole folder goes
    # to the store to keep it beside the script. wslpath and uv.exe come from
    # WSL/Windows, not Nix, so they can't be runtimeInputs.
    apps.import-win-ca = {
      type = "app";
      program = pkgs.lib.getExe (pkgs.writeShellApplication {
        name = "import-win-ca";
        runtimeInputs = [pkgs.uv];
        text = ''exec ${./.}/import-win-ca.py "$@"'';
      });
      meta.description = "Export the Windows CAs (WSL) to a PEM bundle";
    };
  };
}
