;; -*- mode: elisp -*-
;; Emacs init file
;; by Kyle Galloway
;; Remove menu bar
(menu-bar-mode -1)
;; Remove tool bar
(tool-bar-mode -1)
;; Remove scroll bar
(scroll-bar-mode -1)
;; Add line numbers globally
(global-linum-mode 1)
;; Remove line numbers in the terminal
(add-hook 'term-mode-hook (lambda () (linum-mode -1)))
;; We don't want to type yes and no all the time so, do y and n
(defalias 'yes-or-no-p 'y-or-n-p)

(setq delete-old-versions -1 )		; delete excess backup versions silently
(setq version-control t )		; use version control
(setq vc-make-backup-files t )		; make backups file even when in version controlled dir
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
(setq vc-follow-symlinks t )				       ; don't ask for confirmation when opening symlinked file
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name
(setq inhibit-startup-screen t )	; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore )	; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8 )	; use utf-8 by default
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)	; sentence SHOULD end with only a point.
(setq default-fill-column 80)		; toggle wrapping text at the 80th character

;; set ido mode on and allow it to match on C-c C-f
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; "Activate" org mode by making keybindings available
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file (concat org-directory "~/Repos/todo/notes.org"))
(setq org-agenda-files (list "~/Repos/todo/notes.org"))
(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%F>" . "<%b %e %Y %H:%M>"))

;; Global auto-indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Shortcut to get to init.el
(global-set-key (kbd "<f5>") (lambda() (interactive)(find-file "~/.emacs.d/init.el")))

;; Shortcut to get to todo.org
(global-set-key (kbd "<f6>") (lambda() (interactive)(find-file "~/Repos/todo/todo.org")))

;; Cua mode (normal copy/paste/cut/undo keys
;; C-x for cut
;; C-c for copy
;; C-v for paste
;; C-z for undo
(cua-mode 1)

;; Add windmove keybindings for meta key
(windmove-default-keybindings 'meta)

;; Remove line nubmers in terminal
(add-hook 'term-mode-hook 'my-inhibit-global-linum-mode)

(defun my-inhibit-global-linum-mode ()
  "Counter-act `global-linum-mode'."
  (add-hook 'after-change-major-mode-hook
            (lambda () (linum-mode 0))
            :append :local))

;;;;;; Install use-package
;; Update package-archive lists
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Install 'use-package' if necessary
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Enable use-package
(eval-when-compile
  (require 'use-package))

;; SpaceMacs theme
(use-package spacemacs-common
    :ensure spacemacs-theme
    :config (load-theme 'spacemacs-dark t))

;; Install Evil mode
;; load evil
(use-package evil
  :ensure t ;; install the evil package if not installed
  :init ;; tweak evil's configuration before loading it
  (setq evil-search-module 'evil-search)
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-shift-round nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-Y-yank-to-eol t)
  :config ;; tweak evil after loading it
  (evil-mode)

  ;; Change initial states for certain modes
  (evil-set-initial-state 'inferior-emacs-lisp-mode 'emacs)
  (evil-set-initial-state 'shell-mode 'emacs)
  (evil-set-initial-state 'term-mode 'emacs)
  (evil-set-initial-state 'help-mode 'emacs)
  (evil-set-initial-state 'dired-mode 'emacs)
  (evil-set-initial-state 'org-mode 'emacs)
  ;; example how to map a command in normal mode (called 'normal state' in evil)
  ;; (define-key evil-normal-state-map (kbd ", w") 'evil-window-vsplit))
  ;; example how to map a command in insert mode (called 'insert state' in evil)
  ;; (define-key evil-insert-state-map (kbd "jj") 'evil-normal-state)
)
  

;; Install Evil Commentary (like Vim Commentary)
(use-package evil-commentary
  :ensure t
  :config
  (progn (evil-commentary-mode))
  (define-key evil-motion-state-map "," nil)
  (evil-define-key 'normal evil-commentary-mode-map ",/" 'evil-commentary-line)
  ;; (define-key evil-commentary-mode-map (kbd "M-;") 'evil-commentary-line)
)

;; Install projectile for project management
(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
)

;; Install a better terminal emulator
(use-package multi-term
  :ensure t
  :init
  (setq multi-term-program "/bin/zsh")
  (setq multi-term-dedicated-select t)
  ;; :config
  ;; (global-set-key (kbd "<f2>") 'multi-term-dedicated-toggle)
)

; Open multi-term in project root
(global-set-key (kbd "<f2>") 'projectile-multi-term-in-root)
(defun projectile-multi-term-in-root ()
  "Invoke `multi-term' in the project's root."
  (interactive)
  (projectile-with-default-dir (projectile-project-root) (multi-term-dedicated-toggle))
  (multi-term-dedicated-select)
)

;; Fix terminal colors inside emacs
(use-package eterm-256color
  :ensure t
  :config
  (add-hook 'term-mode-hook #'eterm-256color-mode)
)

;; Add syntax support for CMake
(use-package cmake-mode :ensure t)

;; Add syntax support for Dockerfiles
(use-package dockerfile-mode :ensure t)
(add-to-list 'auto-mode-alist '("Dockerfile" . dockerfile-mode))

;; Add syntax support for Dockerfiles
(use-package yaml-mode :ensure t)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))

;; Try to make evil mode treat _ as part of words
(add-hook 'after-change-major-mode-hook (lambda () (modify-syntax-entry ?_ "w")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/Repos/todo/todo.org")))
 '(package-selected-packages
   (quote
    (yaml-mode dockerfile-mode cmake-mode eterm-256color multi-term projectile evil-commentary evil spacemacs-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
