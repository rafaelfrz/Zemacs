(use-package company
  :hook (after-init . global-company-mode)
  :bind (:map company-active-map
              ("<tab>" . company-complete-selection)
              ("C-n"   . company-select-next)
              ("C-p"   . company-select-previous))
  :config
  (setq company-idle-delay 0.2
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t
        company-selection-wrap-around t))

(use-package company-box
  :hook (company-mode . company-box-mode))
