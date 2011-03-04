;; possibly controversial as a global default, but shipping a lisp
;; that dies trying to talk to slime is stupid, so:
(set-language-environment "UTF-8")
(setq slime-net-coding-system 'utf-8-unix)

;; load slime:
;; (add-to-list 'load-path "/opt/local/share/emacs/site-lisp/slime")
;; (add-to-list 'load-path "/opt/local/share/emacs/site-lisp/slime/contrib")
(setq load-path (cons "/opt/local/share/emacs/site-lisp/slime" load-path))
(setq load-path (cons "/opt/local/share/emacs/site-lisp/slime/contrib" load-path))

(setq slime-backend "/opt/local/share/emacs/site-lisp/slime/swank-loader.lisp")
(setq inhibit-splash-screen t)
(require 'slime-autoloads)
(load "/opt/local/share/emacs/site-lisp/slime/slime.el")
(setq inferior-lisp-program "/opt/local/bin/sbcl")
(slime-setup '(slime-fancy slime-tramp slime-asdf))
(slime-require :swank-listener-hooks)
(slime)

;; (require 'slime-autoloads)
;; (setq slime-lisp-implementations
;;      `((sbcl ("/opt/local/bin/sbcl"))
;;        (abcl ("/opt/local/bin/abcl"))
;;        (clisp ("/opt/local/bin/clisp"))))
;; (add-hook 'lisp-mode-hook
;;            (lambda ()
;;              (cond ((not (featurep 'slime))
;;                     (require 'slime) 
;;                     (normal-mode)))))
;; 
;; (eval-after-load "slime"
;;    '(slime-setup '(slime-fancy slime-tramp slime-asdf slime-banner)))
