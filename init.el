;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(require 'package)

(add-to-list 'package-archives
             '("melpa stable" . "https://stable.melpa.org/packages/") t)
;             '("melpa" . "https://melpa.milkbox.net/packages/") t)
;             '("melpa" . "https://melpa.org/packages/") t)

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))

;(package-refresh-contents)
(package-initialize)

;;(require 'go-mode-autoloads)

;; company mode
;; (add-hook 'after-init-hook 'global-company-mode)
;; (require 'company)
(use-package company
  :config
  (setq company-tooltip-limit 20) ;; bigger popup
  (setq company-idle-delay 0.3)
  (setq company-echo-delay 0) ;; blinking
  (setq company-minimum-prefix-length 2)
  (setq company-begin-commands '(self-insert-command))  ;  start autocompletion after typing
  (global-company-mode 1)
  )
  
;; electric
(electric-pair-mode t)

;; comment
;;
(global-set-key (kbd "C-c C-c") 'comment-region)
(global-set-key (kbd "C-c C-u") 'uncomment-region)

;; lisp
(add-to-list 'load-path "~/.emacs.d/ess/lisp")

;; go
(require 'company-go)
(add-hook 'go-mode-hook (lambda ()
                          (set (make-local-variable 'company-backends) '(company-go))
                          (go-eldoc-setup)
                          (add-hook 'before-save-hook 'gofmt-before-save)
                          (setq gofmt-command "goimports")
                          (local-set-key (kbd "M-.") 'godef-jump)
;;                          (local-set-key (kbd "M-*") 'pop-tag-mark)
                          (company-mode)))

;; key
(global-set-key "\M-g" 'goto-line)


;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; '(package-selected-packages
;;   (quote
;;    (go-eldoc flycheck company-go company-irony-c-headers go-mode company-irony irony company))))
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
;; )

;; c++
(setq c-default-style "stroustrup")
;;(require 'cc-mode)
(setq-default c-basic-offset 4
	      tab-width 4
	      indent-tabs-mode nil)

(global-set-key (kbd "C-c o") 'ff-find-other-file)
(global-set-key (kbd "RET") 'newline-and-indent)


(add-hook 'c-initialization-hook
          (lambda()

            ))

(add-hook 'c-mode-common-hook
          (lambda()
                     ))

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; =============
;; irony-mode
;; =============
(use-package irony
  :ensure t
  )
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
;; =============
;; company mode
;; =============
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function

;(defun my-irony-mode-hook ()
;(define-key irony-mode-map [remap completion-at-point] 'irony-completion-at-point-async)
;  (define-key irony-mode-map [remap complete-symbol] 'irony-completion-at-point-async))
;(add-hook 'irony-mode-hook 'my-irony-mode-hook)
;(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options) (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))

;; (optional) adds CC special commands to `company-begin-commands' in order to
;; trigger completion at interesting places, such as after scope operator
;; std::|

;;(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

;; =============
;; flycheck-mode
;; =============
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))
(add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

(use-package flycheck-irony
  :ensure t
  )
(eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
;; =============
;; eldoc-mode
;; =============
(add-hook 'irony-mode-hook 'irony-eldoc)
;; ==========================================
;; (optional) bind TAB for indent-or-complete
;; ========================================== (defun irony--check-expansion () (save-excursion (if (looking-at "\\_>") t (backward-char 1) (if (looking-at "\\.") t (backward-char 1) (if (looking-at "->") t nil))))) (defun irony--indent-or-complete () "Indent or Complete" (interactive) (cond ((and (not (use-region-p)) (irony--check-expansion)) (message "complete") (company-complete-common)) (t (message "indent") (call-interactively 'c-indent-line-or-region)))) (defun irony-mode-keys () "Modify keymaps used by `irony-mode'." (local-set-key (kbd "TAB") 'irony--indent-or-complete) (local-set-key [tab] 'irony--indent-or-complete)) (add-hook 'c-mode-common-hook 'irony-mode-keys)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck-irony use-package go-eldoc flycheck company-irony-c-headers company-irony company-go))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
