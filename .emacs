;; Red Hat Linux default .emacs initialization file

;; Are we running XEmacs or Emacs?
(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))

;; Set up the keyboard so the delete key on both the regular keyboard
;; and the keypad delete the character under the cursor and to the right
;; under X, instead of the default, backspace behavior.
(global-set-key [delete] 'delete-char)
(global-set-key [kp-delete] 'delete-char)
(global-set-key "\C-h" 'delete-backward-char)

;; Turn on font-lock mode for Emacs
(cond ((not running-xemacs)
	(global-font-lock-mode t)
))

;; Show ^M's
;(setq-default inhibit-eol-conversion t)

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop at the end of the file, not just add lines
(setq next-line-add-newlines nil)

(if (eq window-system 'ns)
    (set-default-font "inconsolata 14")
    (set-default-font "inconsolata 10")
)



(if (or (eq window-system 'x) (eq window-system 'ns))
    (if (x-display-color-p)
        (progn
               (set-foreground-color "grey90")
               (set-background-color "black")
        )))

;(setq default-frame-alist
;   (append
;  '(
;	 (background-color  . "black")
;	 (foreground-color  . "grey90")
;	 ) default-frame-alist))
;
;(setq pop-up-frame-alist
; '(
;	(background-color  . "black")
;	(foreground-color  . "grey90")
;	))
;
;; Enable wheelmouse support by default

(setq load-path (cons "~/.emacs.d" load-path))

(require 'mwheel)
(require 'ps-print)
(require 'tabbar)
(require 'mercurial)
(require 'xs-mode)
(require 'js2-mode)
(require 'tpl-mode)
(require 'tt-mode)
(require 'enscript)
(require 'taskpaper)
(require 'protobuf-mode)
(require 'jade-mode)
(require 'coffee-mode)
(require 'glsl-mode)
(require 'google-c-style)
(add-to-list 'auto-mode-alist '("\\.xsi$" . xs-mode))
(add-to-list 'auto-mode-alist '("\\.tpl$" . tpl-mode))
(add-to-list 'auto-mode-alist '("\\.tt$" . tt-mode))
(add-to-list 'auto-mode-alist '("\\.dpl$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.t$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.pod$" . perl-mode))
(add-to-list 'auto-mode-alist '("\\.proto$" . protobuf-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.vert$" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.frag$" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.geom$" . glsl-mode))
(add-to-list 'auto-mode-alist '("\\.glsl$" . glsl-mode))

(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; Printing
;; 2 column landscape size 7 prints column 0-78, lines 1 to 70
(setq ps-paper-type 'letter
      ps-font-size 7.0
      ps-print-header nil
      ps-landscape-mode t
      ps-number-of-columns 2)


(defalias 'perl-mode 'cperl-mode)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cperl-continued-statement-offset 0)
 '(cperl-brace-offset 0)
 '(cperl-indent-level 4)
 '(cperl-label-offset 0)
 '(cperl-close-paren-offset -4)
 '(cperl-tab-always-indent t)
 '(cperl-indent-parens-as-block t)
 '(inhibit-startup-screen t)
 '(js2-basic-offset 4)  
 '(js2-bounce-indent-p nil)
 '(indent-tabs-mode nil)
 '(c-basic-offset 4)
 '(js-indent-level 4)
 )

(setq compilation-scroll-output 'first-error)

(setq c-default-style '((cmode . "stroustrup")))

(defun untabify-buffer ()
    (interactive)
    (untabify (point-min) (point-max)))

(add-hook 'cperl-mode-hook 
  (lambda ()
    (interactive)
    (set-face-background 'cperl-array-face "black")
    (set-face-background 'cperl-hash-face "black")
    (add-hook 'local-write-file-hooks 'delete-trailing-whitespace)
    (add-hook 'local-write-file-hooks 'untabify-buffer)
    (setq indent-tabs-mode nil)
  ))

(add-hook 'xs-mode-hook 
  (lambda ()
    (interactive)
    (add-hook 'local-write-file-hooks 'delete-trailing-whitespace)
    (add-hook 'local-write-file-hooks 'untabify-buffer)
    (setq indent-tabs-mode nil)
  ))

(add-hook 'c-mode-hook 
  (lambda ()
    (interactive)
    (add-hook 'local-write-file-hooks 'delete-trailing-whitespace)
    (add-hook 'local-write-file-hooks 'untabify-buffer)
    (setq indent-tabs-mode nil)
  ))

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'gnuserv-start) (gnuserv-start))

; turn off that damn overwrite mode
(global-set-key [insert] 'nil)
(global-set-key [kp_insert] 'nil)

(global-set-key "\C-j" 'goto-line)
(global-set-key [S-left] 'tabbar-backward)
(global-set-key [S-right] 'tabbar-forward)
;;(global-set-key [f5] 'compile)
(global-set-key [f5] (lambda () (interactive)(compile compile-command)))
(global-set-key [S-f5] 'kill-compilation)
(global-set-key [f6] (lambda () (interactive)(shell-command "/bin/bash -c \"source ~/.bashrc; d1 -q push\"")))
(global-set-key [f1] 'man)

(if (eq window-system 'x)
    (if (x-display-color-p)
        (progn
	  (require 'ide-skel)
    	(global-set-key [f10] 'ide-skel-toggle-left-view-window)
  	(global-set-key [f11] 'ide-skel-toggle-bottom-view-window)
	  (global-set-key [f12] 'ide-skel-toggle-right-view-window)
	  )
      )
  )

(setq compile-command "cd ~/b; make")

(define-key minibuffer-local-map
  [f3] (lambda () (interactive) 
       (insert (buffer-name (current-buffer-not-mini)))))

(defun current-buffer-not-mini ()
  "Return current-buffer if current buffer is not the *mini-buffer*
  else return buffer before minibuf is activated."
  (if (not (window-minibuffer-p)) (current-buffer)
      (if (eq (get-lru-window) (next-window))
          (window-buffer (previous-window)) (window-buffer (next-window)))))

(server-start)

(defun ask-before-closing ()
  "Ask whether or not to close, and then close if y was pressed"
  (interactive)
  (if (y-or-n-p (format "Are you sure you want to exit Emacs? "))
      (if (< emacs-major-version 22)
          (save-buffers-kill-terminal)
        (save-buffers-kill-emacs))
    (message "Canceled exit")))

(when window-system
  (global-set-key (kbd "C-x C-c") 'ask-before-closing))

(add-to-list 'load-path "~/emacs/tramp/lisp/")
(require 'tramp)
(setq tramp-copy-size-limit 1)
