(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")
     ("melpa" . "https://melpa.org/packages/")))
 '(package-selected-packages
   '(quiz org-inline-anim neotree projectile auto-complete cargo autotetris-mode steam 2048-game ox-pandoc org-download org nyan-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Init the package facility
(require 'package)
(package-initialize)

;; Iterate on packages and install missing ones
(dolist (pkg package-selected-packages)
  (unless (package-installed-p pkg)
    (package-install pkg)))

;;; Games

;; Steam
(setq steam-username "nozzato") ; Set Steam username

;;; General

;; Buffer
(delete-selection-mode 1)   ; Enable selection overwriting
(global-visual-line-mode t) ; Enable line wrapping

;; Files
(setq backup-directory-alist '(("." . "~/.emacs.d/backups/")))    ; Set backup directory
(savehist-mode t)                                                 ; Save minibuffer history
(setq use-file-dialog nil)                                        ; Disable GUI file manager
(add-to-list 'load-path "~/.emacs.d/elpa/neotree-20200324.1946/") ; Enable NeoTree
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; Font

(set-face-attribute 'default nil :height 120) ; Set font size. 120 for desktop, 100 for laptop

;; Line numbers
(global-linum-mode)                                ; Enable line numbers
(defun my/neotree-hook (_unused)                   ; Disable line numbers in neotree
  (linum-mode -1))
(add-hook 'neo-after-create-hook 'my/neotree-hook)

;; Mode line
(column-number-mode t) ; Enable column number
(nyan-mode t)          ; Enable Nyan Cat scroll bar

;; Scroll
(setq mouse-wheel-progressive-speed nil) ; Disable scroll acceleration
(setq mouse-wheel-scroll-amount '(3))    ; Set scroll distance
(scroll-bar-mode -1)                     ; Disable GUI scroll bar

;; Search
(setq isearch-repeat-on-direction-change t) ; Repeat search when search direction changes

;; Sound
(setq ring-bell-function 'ignore) ; Disable audio bell
(setq visible-bell nil)           ; Disable visual bell

;; Startup
(setq inhibit-startup-screen t) ; Disable startup screen

;; Theme
(add-to-list 'default-frame-alist '(tty-color-mode . -1)) ; Ignore theme if not in X
(setq custom-theme-directory "~/.emacs.d/themes/")        ; Set theme directory
(load-theme 'monokai t)                                   ; Load theme

;; Toolbars
(menu-bar-mode -1) ; Disable GUI menu bar
(tool-bar-mode -1) ; Disable GUI tool bar

;; Window
(setq frame-resize-pixelwise t) ; Resize window to any pixel size

;;; GPG

;; epa
(require 'epa-file)
(epa-file-enable)             ; Enable automatic GPG encryption and decryption
(setq epa-file-select-keys 1) ; Enable symmetric encryption

;;; Org

;; Buffer
(setq org-support-shift-select t) ; Select text and execute Org commands

;; Export
(setq-default org-display-custom-times t)  ; Enable custom timestamp format
(setq org-time-stamp-custom-formats '("<%a %b %e %Y>" . "<%a %b %e %Y %H:%M>"))
                                           ; Format date as day-month-year hour:minute:second period
(setq org-export-with-section-numbers nil) ; Disable section numbers in export
(setq org-export-with-toc nil)             ; Disable table of contents in export
(setq org-html-validation-link nil)        ; Disable validation link in export

;; Images
(setq org-image-actual-width '(400))      ; Set width of inline images with keyword or default to 400px
(setq org-startup-with-inline-images nil) ; Hide inline images

;; Commands
(global-set-key (kbd "C-c l") #'org-store-link)
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

;;; Rust

;; Binaries
(setq cargo-process--custom-path-to-bin "/usr/bin/cargo")
(setq cargo-process--rustc-cmd "/usr/bin/rustc")
