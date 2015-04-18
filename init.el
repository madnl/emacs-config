
;; Packages

(require 'package)

(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

;(add-to-list 'package-archives
;             '("melpa" . "http://melpa.org/packages/") t)

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(defvar my-packages
  '(;; Generic
    paredit
    exec-path-from-shell
    smex
    projectile
    expand-region
    auto-complete
    multiple-cursors
    ido-ubiquitous
    idle-highlight-mode
    find-file-in-project
    
    ;; Clojure
    clojure-mode
    clojure-mode-extra-font-locking
    cider
    clojure-cheatsheet

    ;; Scala
    scala-mode2

    ;; Rust
    rust-mode

    ;; HTML
    tagedit

    ;; Markdown
    markdown-mode
    
    ;; Themes
    solarized-theme
))

(defun install-my-packages ()
  (interactive)
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; Environment init

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; ido

(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(setq smex-save-file (concat user-emacs-directory ".smex-items"))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)

;; uniquify

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; VC

; disabling VC since it is often too slow to load
(setq vc-handled-backends ())

;; Auto-complete
(setq ac-ignore-case nil)

(global-auto-complete-mode t)

;; Editing

(electric-pair-mode t)
(setq-default indent-tabs-mode nil)
(define-key global-map (kbd "RET") 'newline-and-indent)

(tool-bar-mode -1)

(setq x-select-enable-clipboard t
      x-select-enable-primary t
      visible-bell t)


;; Keyboard shortcuts

(setq scroll-error-top-bottom t)

(global-set-key (kbd "s-<left>") 'move-beginning-of-line)
(global-set-key (kbd "s-<right>") 'move-end-of-line)
(define-key global-map [home] 'beginning-of-line)
(define-key global-map [end] 'end-of-line)

(global-set-key (kbd "s-<up>") 'scroll-down-command)
(global-set-key (kbd "s-<down>") 'scroll-up-command)

(global-set-key (kbd "s-{") 'previous-buffer)
(global-set-key (kbd "s-}") 'next-buffer)

(require 'expand-region)
(global-set-key (kbd "s-=") 'er/expand-region)

(require 'multiple-cursors)
(global-set-key (kbd "s-D") 'mc/edit-lines)
(global-set-key (kbd "s-d") 'mc/mark-next-like-this)

(global-set-key (kbd "C-x C-b") 'ibuffer)

(global-set-key (kbd "s-p") 'find-file-in-project)

;; Hooks

(add-hook 'clojure-mode-hook #'paredit-mode)

;; Backup stuff

(setq backup-directory-alist `(("." . "~/.emacs.backup")))

;; Multi-term

(setq multi-term-program "/opt/twitter/bin/zsh")

(let ((theme (if (display-graphic-p)
                 'solarized-dark
               'wombat)))
  (load-theme theme t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 150 :width normal :foundry "apple" :family "Source Code Pro")))))
