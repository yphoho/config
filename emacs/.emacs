;; no menubar
(menu-bar-mode -1)

;; no toolbar
(tool-bar-mode 0)

;; ;; unset mark set on "ctrl + space"
;; (global-unset-key [?\C- ])

;; default frame size
(setq default-frame-alist
      '((width . 80) (height . 40)))


(add-hook 'before-save-hook 'delete-trailing-whitespace)


;; switch off the auto return, doesn't work
(setq auto-fill-mode -1)
(setq fill-column 99999)
(setq-default fill-column 99999)


;; font setup
;; (set-default-font "Monaco-11")
(set-default-font "Monaco-10")
(set-fontset-font (frame-parameter nil 'font)
                  'han '("SimSun"  . "unicode-bmp"))
(set-fontset-font (frame-parameter nil 'font)
                  'cjk-misc '("WenQuanYi Zen Hei"  . "unicode-bmp"))


;; c language style
;;(setq-default c-set-style "K&R")
(setq c-default-style "k&r")
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil)  ;; yes, no tabs



(add-to-list 'load-path "~/.emacs.d/packages")
(add-to-list 'load-path "~/.emacs.d/plugins")
(add-to-list 'load-path "~/.emacs.d/packages/yasnippet")

(add-to-list 'load-path "~/.emacs.d/packages/multi-mode")



;; ;; https://github.com/austin-----/weibo.emacs.git
;; (add-to-list 'load-path "~/.emacs.d/packages/weibo")
;; (require 'weibo)




;; make emacsclient to work
;; http://www.gnu.org/software/emacs/emacs-faq.html#Using-an-already-running-Emacs-process
(server-start)


(load-library "color-theme")
;;(color-theme-blue-mood)
;;(color-theme-classic)
;;(color-theme-resolve)
;;(color-theme-bharadwaj-slate)


(require 'color-theme-tango)
(color-theme-tango)

;;(require 'color-theme-subdued)
;;(color-theme-subdued)

;;(add-to-list 'load-path "~/.emacs.d/packages/emacs-themes")
;;(require 'lunar-fruity-theme)
;;(lunar-fruity-theme)



;; ;; Lisp (SLIME) interaction
;; ;; The SBCL binary and command-line arguments
;; (setq inferior-lisp-program "/usr/bin/sbcl --noinform")
;; ;; (setq inferior-lisp-program "clisp")
;; ;; (add-to-list 'load-path "~/.slime")
;; (require 'slime)
;; (slime-setup)


;; http://ess.r-project.org/
(require 'ess-site)


;; keep the bookmakr when exit
(setq bookmark-save-flag 1)


(setq default-directory "~/code/")


;; no emacs welcome splash
(setq inhibit-startup-message t)

(setq debug-on-error nil)




;; highlight syntax
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; show the last opend windows
;;(desktop-save-mode 1)


;; show line num
(global-linum-mode 1)

;; slim curser
(setq-default cursor-type 'bar)

;; no backup file
(setq make-backup-files nil)

;; matching bracket
(show-paren-mode t)

(set-scroll-bar-mode 'right)

;; kill-ring
(when (require 'browse-kill-ring nil t)
  (browse-kill-ring-default-keybindings)
  (setq kill-ring-max 200))
;;(mouse-avoidance-mode 'animate)


;; (require 'multi-tornado)


;; for auctex
;; (load "auctex.el" nil t t)



;; yasnippet
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "~/.emacs.d/packages/yasnippet")

(require 'auto-complete)
(global-auto-complete-mode t)

(require 'smart-operator)

;; ;; cperl-mode is preferred to perl-mode
;; (defalias 'perl-mode 'cperl-mode)

;; no trailing whitespace show
;; see http://www.emacswiki.org/emacs/CPerlMode
(setq cperl-invalid-face nil)


;; For rst mode
(require 'rst)
(setq auto-mode-alist
      (append '(;("\\.txt$" . rst-mode)
                ("\\.rst$" . rst-mode)
                ("\\.rest$" . rst-mode)) auto-mode-alist))

(require 'clips-mode)
(add-to-list 'auto-mode-alist '("\\.hlp$" . clips-mode))

;; about copywrite information
(load-library "~/.emacs.d/plugins/license.el")
(setq comment-style 'extra-line)
(add-hook 'scheme-mode-hook
          (lambda ()
            (set (make-local-variable 'comment-add) 1)))

;; set xetex mode in tex/latex
(add-hook 'LaTeX-mode-hook (lambda()
                             (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
                             (setq TeX-command-default "XeLaTeX")
                             (setq TeX-save-query nil)
                             (setq TeX-show-compilation t)
                             ))

(delete-selection-mode 1) ; make typing override text selection
(global-visual-line-mode 1) ; 1 for on, 0 for off.

;;(require 'dired+)


;; to view source
(require 'xcscope)


;; (require 'trac-wiki)
;; (autoload 'trac-wiki "trac-wiki" "Trac wiki editing entry-point." t)
;; (trac-wiki-define-project "wiki"
;;                           "http://localhost/projects/wiki" t)

;; (require 'shell-pop)
;; (shell-pop-set-internal-mode "terminal")
;; (shell-pop-set-internal-mode-shell "/bin/bash")
;; (shell-pop-set-window-height 60) ;the number for the percentage of the selected window. if 100, shell-pop use the whole of selected window, not spliting.
;; (shell-pop-set-window-position "bottom") ;shell-pop-up position. You can choose "top" or "bottom".
;; (global-set-key [f8] 'shell-pop)


(require 'remember)

(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-CUA-compatible t)
(setq org-log-done t)
(setq org-agenda-files (file-expand-wildcards "~/workspace/org/*.org"))

;; --------- begin org-mode custom -------------
(defvar count-words-buffer
  nil
  "*Number of words in the buffer.")

(defun wicked/update-wc ()
  (interactive)
  (setq count-words-buffer (number-to-string (count-words-buffer)))
  (force-mode-line-update))

                                        ; only setup timer once
(unless count-words-buffer
  ;; seed count-words-paragraph
  ;; create timer to keep count-words-paragraph updated
  (run-with-idle-timer 1 t 'wicked/update-wc))

;; add count words paragraph the mode line
(unless (memq 'count-words-buffer global-mode-string)
  (add-to-list 'global-mode-string "words: " t)
  (add-to-list 'global-mode-string 'count-words-buffer t))

;; count number of words in current paragraph
(defun count-words-buffer ()
  "Count the number of words in the current paragraph."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((count 0))
      (while (not (eobp))
        (forward-word 1)
        (setq count (1+ count)))
      count)))
;; ------- end org-mode custom -------------------


(require 'recentf)
(recentf-mode 1)




;; You can customize the variable x-select-enable-clipboard
;; to make the Emacs yank functions consult the clipboard
;; before the primary selection, and to make the kill
;; functions to store in the clipboard as well as the
;; primary selection. Otherwise, these commands do not
;; access the clipboard at all. Using the clipboard
;; is the default on MS-Windows and Mac OS, but not on other systems.
(setq x-select-enable-clipboard t)
(transient-mark-mode 1)
(setq shift-select-mode t)
(setq mouse-drag-copy-region nil)
(setq x-select-enable-primary nil)





;; ;; fullscreen when start
;; (defun toggle-fullscreen ()
;;   (interactive)
;;   (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;;                          '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
;;   (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;;                          '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
;;   )
;; Emacs will be overlaped by a pane under the desktop
;; when fullscreened.
;; let me check out x-window to resolve it.
;;(toggle-fullscreen)









;; (require 'semantic-tag-folding)
;; (global-semantic-tag-folding-mode 1)


(custom-set-variables
 ;; ;; custom-set-variables was added by Custom.
 ;; ;; If you edit it by hand, you could mess it up, so be careful.
 ;; ;; Your init file should contain only one such instance.
 ;; ;; If there is more than one, they won't work right.
 ;; '(org-agenda-files (quote ("~/workspace/org/personal.org")))
 ;; '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify)))
 )




(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
