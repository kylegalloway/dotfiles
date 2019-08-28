;; -*- mode: elisp -*-
; Emacs init file
; by Kyle Galloway
; Remove menu bar
(menu-bar-mode -1)
; Remove tool bar
(tool-bar-mode -1)
; Remove scroll bar
(scroll-bar-mode -1)
; Add line numbers globally
(global-linum-mode 1)

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

; set ido mode on and allow it to match on C-c C-f
(ido-mode 1)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)

;; Enable transient mark mode
(transient-mark-mode 1)

;;;;Org mode configuration
;; Enable Org mode
(require 'org)
;; Make Org mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

; Global auto-indent
(define-key global-map (kbd "RET") 'newline-and-indent)

; Cua mode (normal copy/paste/cut/undo keys
;; C-x for cut
;; C-c for copy
;; C-v for paste
;; C-z for undo
(cua-mode 1)

;;;;;;; Install use-package
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

; SpaceMacs theme
(use-package spacemacs-common
    :ensure spacemacs-theme
    :config (load-theme 'spacemacs-dark t))

; Install Evil mode
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
  
  ;; example how to map a command in normal mode (called 'normal state' in evil)
  ;(define-key evil-normal-state-map (kbd ", w") 'evil-window-vsplit))
  ;; example how to map a command in insert mode (called 'insert state' in evil)
  ;; (define-key evil-insert-state-map (kbd "jj") 'evil-normal-state)
)

; Install Evil Commentary (like Vim Commentary)
(use-package evil-commentary
  :ensure t
  :config
  (progn (evil-commentary-mode))
  (define-key evil-motion-state-map "," nil)
  (evil-define-key 'normal evil-commentary-mode-map ",/" 'evil-commentary-line)
  ;; (define-key evil-commentary-mode-map (kbd "M-;") 'evil-commentary-line)
)

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (projectile evil-commentary evil spacemacs-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
