{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraPackages =
      epkgs: with epkgs; [
        nix-mode
        nixfmt
        base16-theme
        magit
        git-gutter
        git-gutter-fringe
        vterm
        nerd-icons
        doom-modeline
        vundo
        nerd-icons-corfu
        corfu
        cape
        rg
        pdf-tools
        nixpkgs-fmt
      ];
    extraConfig = ''
        (setq standard-indent 2)
        (setq indent-tabs-mode nil)
        (setq use-package-always-ensure t)
        (setq tab-width 2)
        (load-theme 'base16-vesper t)

        (global-set-key (kbd "C-c l") #'org-store-link)
        (global-set-key (kbd "C-c a") #'org-agenda)
        (global-set-key (kbd "C-c c") #'org-capture)        
        
        (use-package git-gutter
          :hook (prog-mode . git-gutter-mode)
          :config
          (setq git-gutter:update-interval 0.02))

        (use-package git-gutter-fringe
            :config
            (define-fringe-bitmap 'git-gutter-fr:added [224] nil nil '(center repeated))
            (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
            (define-fringe-bitmap 'git-gutter-fr:deleted [128 192 224 240] nil nil 'bottom))

        (use-package doom-modeline
          :init (doom-modeline-mode 1))

        (use-package nerd-icons)
        (use-package corfu)
        (use-package cape)
        (use-package rg)
        (use-package vundo) 
        (use-package vterm)
        (use-package nixfmt)
        (use-package nix-mode
      :mode "\\.nix\\'")
        (pdf-tools-install)
    '';
  };

  services.emacs = {
    enable = true;
    defaultEditor = true;
  };
}
