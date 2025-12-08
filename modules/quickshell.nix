{ pkgs-unstable, inputs, ... }:
{
  # install package
  environment.systemPackages = with pkgs-unstable; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    # ... maybe other stuff
  ];
}
