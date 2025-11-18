(use-package projectile
	:ensure t
	:init
	(setq projectile-project-search-path '("~/Documents/Projetos/" "~/.config/"))
	:config
	(projectile-mode +1))
