;; package --- Bane, emacs, config, n+1 th iteration
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Melpa - where all new cool package versions live
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

;; [ANNOY] disable backup files and autosave files
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files

;; [ANNOY] Do not create temporary symbolic link named '#foo'
(setq create-lockfiles nil)

;; [UI] font
(add-to-list 'default-frame-alist '(font . "Source Code Pro-11:slant=normal:weight=regular:width=normal:height=110"))
;;(add-to-list 'default-frame-alist '(font . "Hack-11"))
;;(add-to-list 'default-frame-alist '(font . "FiraCode 11"))

;; [UI] init window size
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; [UI] Bez sples ekrana na startovanju.
(setq inhibit-startup-message t)

;; [UI] Isklucivanje toolbara.
(tool-bar-mode -1)

;; [UI] Ukljucivanje bojenja sintakse.
(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)

;; [UI] Visible bell umesto spikera.
(setq visible-bell t)

;; [UI] Ukljucivanje vidljivog markiranje teksta.
(setq-default transient-mark-mode t)

;; [UI] Ukljucivanje line-number-mode -a i column-number-mode -a.
(global-display-line-numbers-mode 1)
(setq column-number-mode t)

;; [UI] yes/no -> y/n.
(fset 'yes-or-no-p 'y-or-n-p)

;; [UI] Bez blinkanja kursora.
(blink-cursor-mode -1)

;; [FUNC] Useless whitespace - http://www.gnu.org/s/libtool/manual/emacs/Useless-Whitespace.html
(setq-default show-trailing-whitespace t)

;; [FUNC] Show paren mode.
(show-paren-mode)
(setq show-paren-delay 0)
(setq show-paren-style 'expression)

;; [UI] Skrolovanje u prozoru, za po 1 liniju.
(setq-default scroll-step 1)

;; [UI] Skrolovanje.
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; [FUNC] Fajl se zavrsava sa newline
(setq require-final-newline t)

;; [FUNC] Windmove default podesavanja
(use-package windmove
  :ensure
  :config
  (windmove-default-keybindings))

;; [FUNC] POmeranje selekcije gore-dole za po liniju
(use-package move-text
  :ensure
  :config
  (move-text-default-bindings))

;; [KEYS] keybinds
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "s-<f12>") (lambda() (interactive) (find-file "~/.emacs")))
(global-set-key [f9] 'ibuffer)
(global-set-key [f8] (lambda() (interactive) (kill-buffer (current-buffer))))
(global-set-key [f5] (lambda() (interactive) (revert-buffer t t)))
;;(global-set-key (kbd "C-<f9>") 'ibuffer-quit)
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
(global-set-key "\M-Y" 'yank-pop-forwards) ; M-Y (Meta-Shift-Y)

;; [ASSOC]
;; Associate web-mode for HTML and VUE file types:
(use-package web-mode
  :ensure
  :config
  (setq web-mode-markup-indent-offset 4)
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.vue?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode)))

;; -----------
;; Color theme
;; -----------
(load-theme 'tango-dark t)

;; which key
(use-package which-key
  :ensure
  :config (which-key-mode))

;; [PHP]
(use-package php-mode
  :ensure
  :hook ((php-mode . php-enable-psr2-coding-style)))

;; [Clojure]
(use-package clojure-mode
  :ensure
  :hook ((clojure-mode . lsp)
         (clojurec-mode . lsp)
         (clojurescript-mode . lsp)))

;; https://emacs-lsp.github.io/lsp-mode/tutorials/how-to-turn-off/
;; [Rust] - from https://robert.kra.hn/posts/2021-02-07_rust-with-emacs/
(use-package rustic
  :ensure
  :bind (:map rustic-mode-map
              ("M-j" . lsp-ui-imenu)
              ("M-?" . lsp-find-references)
              ("C-c C-c l" . flycheck-list-errors)
              ("C-c C-c a" . lsp-execute-code-action)
              ("C-c C-c r" . lsp-rename)
              ("C-c C-c q" . lsp-workspace-restart)
              ("C-c C-c Q" . lsp-workspace-shutdown)
              ("C-c C-c s" . lsp-rust-analyzer-status))
  :config
  ;; uncomment for less flashiness
  ;;(setq lsp-eldoc-hook nil)
  ;;(setq lsp-enable-symbol-highlighting nil)
  ;;(setq lsp-signature-auto-activate nil)
  ;;(setq rustic-lsp-client 'lsp) ;; dve opcije: 'lsp i 'eglot
  ;; comment to disable rustfmt on save
  (setq rustic-format-on-save t)
  )

(use-package lsp-mode
  :ensure
  :commands lsp
  :custom
  ;; Code lenses for LSP - idu na zivce, jer kvare layout.
  (lsp-lens-enable nil)
  ;; Ako mora da se prikazu - ovo je bolje - vertikalno
  ;;(lsp-lens-place-position 'above-line)

  (lsp-headerline-breadcrumb-enable t)
  (lsp-eldoc-enable-hover nil)

  (lsp-rust-analyzer-cargo-watch-command "clippy")
  (lsp-eldoc-render-all t)
  (lsp-idle-delay 0.6)
  ;; enable / disable the hints as you prefer:
  (lsp-inlay-hint-enable nil)
  ;; These are optional configurations. See https://emacs-lsp.github.io/lsp-mode/page/lsp-rust-analyzer/#lsp-rust-analyzer-display-chaining-hints for a full list
  ;; (lsp-rust-analyzer-display-lifetime-elision-hints-enable "skip_trivial")
  ;; (lsp-rust-analyzer-display-chaining-hints t)
  ;; (lsp-rust-analyzer-display-lifetime-elision-hints-use-parameter-names nil)
  ;; (lsp-rust-analyzer-display-closure-return-type-hints t)
  ;; (lsp-rust-analyzer-display-parameter-hints nil)
  ;; (lsp-rust-analyzer-display-reborrow-hints nil)
  ;; :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  )

(use-package lsp-ui
  :ensure
  :commands lsp-ui-mode
  :custom
  (lsp-ui-peek-always-show t)
  (lsp-ui-sideline-show-hover t)
  (lsp-ui-doc-enable t))

;; ---------
;; Dart mode
;; ---------
(use-package lsp-dart
  :ensure t
  :config
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  :hook (dart-mode . lsp))

;;
;; Python?
;;
(use-package elpy
  :ensure
  :init
  (elpy-enable))

(use-package emojify
  :ensure
  :hook (after-init . global-emojify-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
