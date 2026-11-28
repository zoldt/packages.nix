{
  perSystem = {pkgs, ...}: {
    # Update every input of the local checkout, committing flake.lock, then
    # switch. Args go to nh.
    apps.switch = {
      type = "app";
      program = pkgs.lib.getExe (pkgs.writeShellApplication {
        name = "switch";
        runtimeInputs = [pkgs.nh];
        text = ''NH_OS_FLAKE=. exec nh os switch --update --commit-lock-file "$@"'';
      });
      meta.description = "Update flake inputs, then nh os switch";
    };
  };
}
