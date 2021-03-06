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
;; I don't want any backups
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
;; Fix scrolling to stop centering when scrolling past visible portion
(setq scroll-conservatively 1)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Org mode configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
(setq org-log-done 'time)
(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/Repos/todo/todo.org" "New")
         "* TODO [#A] %?\nCREATED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org-mode agenda options                                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; open agenda in current window
(setq org-agenda-window-setup (quote current-window))
;; warn me of any deadlines in next 7 days
(setq org-deadline-warning-days 7)
;; show me tasks scheduled or due in next fortnight
(setq org-agenda-span (quote fortnight))
;; don't show tasks as scheduled if they are already shown as a deadline
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)
;; don't give awarning colour to tasks with impending deadlines
;; if they are scheduled to be done
(setq org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled))
;; don't show tasks that are scheduled or have deadlines in the
;; normal todo list
(setq org-agenda-todo-ignore-deadlines (quote all))
(setq org-agenda-todo-ignore-scheduled (quote all))
;; sort tasks in order of when they are due and then by priority
(setq org-agenda-sorting-strategy
  (quote
   ((agenda deadline-up priority-down)
    (todo priority-down category-keep)
    (tags priority-down category-keep)
    (search category-keep))))
;; Removes "DONE" tasks from agenda view
(setq org-agenda-skip-scheduled-if-done t)

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
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
;; (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
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
;; Base 16 themes
;; (use-ackage base16-theme
;;   :ensure t
;;   :config
;;   (load-theme 'base16-default-dark t))
;;   (load-theme 'base16-woodland t))
;;   (load-theme 'base16-atelier-dune t))
;;   (load-theme 'base16-atelier-forest t))
;;   (load-theme 'base16-darktooth t))
;;   (load-theme 'base16-default-dark t))
;;   (load-theme 'base16-eighties t))
;;   (load-theme 'base16-google-dark t))
;;   (load-theme 'base16-hopscotch t))
;;   (load-theme 'base16-ir-black t))
;;   (load-theme 'base16-isotope t))
;;   (load-theme 'base16-london-tube t))
;;   (load-theme 'base16-macintosh t))
;;   (load-theme 'base16-materia t))
;;   (load-theme 'base16-monokai t))
;;   (load-theme 'base16-pop t))
;;   (load-theme 'base16-railscasts t))
;;   (load-theme 'base16-seti-ui t))
;;   (load-theme 'base16-solar-flare t))
;;   (load-theme 'base16-solarized-dark t))
;;   (load-theme 'base16-spacemacs t))
;;   (load-theme 'base16-summerfruit-dark t))
;;   (load-theme 'base16-tomorrow-night t))
;;   (load-theme 'base16-twilight t))
;;   (load-theme 'base16-unikitty-dark t))
;; Set the cursor color based on the evil state
;; (defvar my/base16-colors base16-default-dark-colors)
;; (setq evil-emacs-state-cursor   `(,(plist-get my/base16-colors :base0D) box)
;;       evil-insert-state-cursor  `(,(plist-get my/base16-colors :base0D) bar)
;;       evil-motion-state-cursor  `(,(plist-get my/base16-colors :base0E) box)
;;       evil-normal-state-cursor  `(,(plist-get my/base16-colors :base0B) box)
;;       evil-replace-state-cursor `(,(plist-get my/base16-colors :base08) bar)
;;       evil-visual-state-cursor  `(,(plist-get my/base16-colors :base09) box))

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

;; Add markdown support
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (
	 ("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
	)
  :init (setq markdown-command "multimarkdown")
)

;; Add json support
(use-package json-mode :ensure t)

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
    (markdown-mode git-gutter base16-theme yaml-mode dockerfile-mode cmake-mode eterm-256color multi-term projectile evil-commentary evil spacemacs-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
