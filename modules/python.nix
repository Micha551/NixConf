{
  pkgs,
  ...
}:

{
  environment.systemPackages =
    (with pkgs.python313Packages; [
      python
      pip
      notebook
    ])
    ++ (with pkgs; [
      jupyter
    ]);
}
