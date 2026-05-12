
{config, pkgs, ...}:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
  extraPackages = epkgs: with epkgs; [
    nix-mode
    nixfmt
    evil
    base16-theme
    magit
    git-gutter
    git-gutter-fringe
    vterm
  ];
  extraConfig = ''
    (setq standard-indent 2)
    (setq indent-tabs-mode nil)
    (setq tab-width 2)
    (setq evil-want-C-u-scroll t)

    (load-theme 'base16-vesper t)

    (setq use-package-always-ensure t)

    (use-package git-gutter
      :hook (prog-mode . git-gutter-mode)
      :config
      (setq git-gutter:update-interval 0.02))

    (use-package git-gutter-fringe
        :config
        (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
        (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
        (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

    (use-package vterm)
    (use-package nixfmt)
    (use-package nix-mode
  :mode "\\.nix\\'")

    (require 'evil)
    (evil-mode 1)
  '';
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
  };
}

