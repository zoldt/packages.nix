{inputs, ...}: {
  overlayPackages.bkt = final: inputs.bkt.packages.${final.stdenv.hostPlatform.system}.bkt;
}
