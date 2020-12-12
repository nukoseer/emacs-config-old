;;; nano-theme.el

;;; Code:

(unless (>= emacs-major-version 24)
  (error "The nano theme requires Emacs 24 or later!"))

(deftheme nano "Nano")

(setq nano-color-foreground "#ECEFF4") ;; Snow Storm 3  / nord  6
(setq nano-color-background "#2E3440") ;; Polar Night 0 / nord  0
(setq nano-color-highlight  "#3B4252") ;; Polar Night 1 / nord  1
(setq nano-color-critical   "#EBCB8B") ;; Aurora        / nord 11
(setq nano-color-salient    "#81A1C1") ;; Frost         / nord  9
(setq nano-color-strong     "#ECEFF4") ;; Snow Storm 3  / nord  6
(setq nano-color-popout     "#D08770") ;; Aurora        / nord 12
(setq nano-color-subtle     "#434C5E") ;; Polar Night 2 / nord  2
(setq nano-color-faded      "#616E87") ;;

(let ((background 	nano-color-background)
      (gutters    	nano-color-background)
      (gutter-fg  	nano-color-background)
      (gutters-active 	nano-color-background)
      (builtin      	nano-color-salient)
      (selection  	nano-color-subtle)
      (text       	nano-color-foreground)
      (comments   	nano-color-faded)
      (punctuation 	nano-color-salient)
      (keywords 	nano-color-salient)
      (variables 	nano-color-foreground)
      (functions 	nano-color-foreground)
      (methods    	nano-color-foreground) ;; #c1d1e3
      (strings    	nano-color-popout)
      (constants 	nano-color-salient)
      (macros 		nano-color-salient)
      (numbers 		nano-color-salient)
      (white     	nano-color-foreground)
      (error 		nano-color-critical)
      (warning 		nano-color-critical)
      (highlight-line 	nano-color-highlight)
      (line-fg 		nano-color-subtle))

  (custom-theme-set-faces
   'nano

   ;; Default colors
   ;; *****************************************************************************

   `(default                          ((t (:foreground ,nano-color-foreground :background ,nano-color-background :weight normal))))
   `(region                           ((t (:foreground nil :background ,selection))))
   `(cursor                           ((t (:background ,nano-color-foreground))))
   `(linum                            ((t (:background ,nano-color-background :foreground ,nano-color-background))))
   `(highlight                        ((t (:foreground nil :background ,nano-color-subtle))))
   `(link                             ((t (:foreground ,nano-color-salient :weight light))))
   `(lazy-highlight                   ((t (:background ,nano-color-subtle :weight light))))
   `(isearch                          ((t (:foreground ,nano-color-foreground :family "Roboto Mono" :weight medium))))
   `(isearch-fail                     ((t (:foreground ,nano-color-faded))))
   `(minibuffer-prompt                ((t (:foreground ,nano-color-foreground :family "Roboto Mono" :weight medium))))
   `(ido-subdir                       ((t (:foreground ,nano-color-foreground)))) ;; Face used by ido for highlighting subdirs in the alternatives.
   `(ido-first-match                  ((t (:foreground ,nano-color-salient :weight bold)))) ;; Face used by ido for highlighting first match.
   `(ido-only-match                   ((t (:foreground ,nano-color-faded :weight bold))))
   `(compilation-mode-line-exit       ((t (:foreground ,nano-color-salient :weight bold))))
   `(compilation-mode-line-fail       ((t (:foreground ,nano-color-critical :weight bold))))
   `(success                          ((t (:foreground ,nano-color-salient :weight bold))))
   `(warning                          ((t (:foreground ,nano-color-popout :weight bold))))
   `(error                            ((t (:foreground ,nano-color-critical :weight bold))))
   `(match                            ((t (:foreground ,nano-color-popout :weight bold))))
   `(window-divider                   ((t (:foreground ,nano-color-background))))
   `(window-divider-first-pixel       ((t (:foreground ,nano-color-highlight))))
   `(window-divider-last-pixel        ((t (:foreground ,nano-color-highlight))))
   `(fringe                           ((t (:foreground ,nano-color-faded  :weight light))))

   ;; Font lock faces
   ;; *****************************************************************************

   `(font-lock-keyword-face           ((t (:foreground ,keywords))))
   `(font-lock-type-face              ((t (:foreground ,punctuation))))
   `(font-lock-constant-face          ((t (:foreground ,constants))))
   `(font-lock-variable-name-face     ((t (:foreground ,variables))))
   `(font-lock-builtin-face           ((t (:foreground ,builtin))))
   `(font-lock-string-face            ((t (:foreground ,strings))))
   `(font-lock-comment-face           ((t (:foreground ,comments))))
   `(font-lock-comment-delimiter-face ((t (:foreground ,comments))))
   `(font-lock-doc-face               ((t (:foreground ,comments))))
   `(font-lock-function-name-face     ((t (:foreground ,functions))))
   `(font-lock-doc-string-face        ((t (:foreground ,strings))))
   `(font-lock-preprocessor-face      ((t (:foreground ,macros))))
   `(font-lock-warning-face           ((t (:foreground ,warning))))

   ;; Plugins
   ;; *****************************************************************************
   `(trailing-whitespace ((t (:foreground nil :background ,nano-color-critical))))
   `(whitespace-trailing ((t (:background nil :foreground ,nano-color-critical :inverse-video t))))

   `(linum                           ((t (:foreground ,nano-color-subtle :background ,background))))
   `(linum-relative-current-face     ((t (:foreground ,nano-color-foreground :background ,nano-color-background))))
   `(line-number                     ((t (:foreground ,nano-color-subtle :background ,nano-color-background))))
   `(line-number-current-line        ((t (:foreground ,nano-color-foreground :background ,nano-color-background))))

   ;; hl-line-mode
   `(hl-line      ((t (:background ,nano-color-highlight))))
   `(hl-line-face ((t (:background ,nano-color-highlight))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,nano-color-foreground))))
   `(rainbow-delimiters-unmatched-face ((t (:foreground ,nano-color-critical))))
   `(show-paren-match ((t (:foreground ,nano-color-popout))))
   `(show-paren-mismatch ((t (:foreground ,nano-color-critical))))
   
      ;; mode-line and powerline
   `(mode-line-buffer-id ((t (:foreground ,nano-color-background :distant-foreground ,nano-color-foreground :text ,nano-color-foreground :family "Roboto Mono" :weight bold))))
   `(mode-line ((t (:foreground ,nano-color-faded
                    :background ,nano-color-highlight
 		    :overline nil
		    :underline nil
                    :box nil))))
   ;; buttons on mode-line
   `(mode-line-highlight ((t (:foreground ,nano-color-faded
                              :background ,nano-color-background
 		              :overline nil
		              :underline nil
                              :box `(:line-width 1
                                       :color ,nano-color-background
                                       :style nil)
))))

   ;;`(powerline-active1 ((t (:background ,nano-color-subtle :foreground ,nano-color-foreground))))
   ;;`(powerline-active2 ((t (:background ,nano-color-subtle :foreground ,nano-color-foreground))))

   `(mode-line-inactive ((t (:foreground ,nano-color-faded
                             :background ,nano-color-background
 		             :overline nil
		             :underline nil
                             :box nil))))

   `(header-line ((t (:weight light
                    :foreground ,nano-color-foreground
                    :background ,nano-color-background
                    :overline nil
                    :underline nil
                    :box nil
                    :box `(:line-width 1
                                       :color ,nano-color-background
                                       :style nil)
                    :inherit nil))))

   `(internal-border ((t (:background ,nano-color-background))))

   ;;`(powerline-inactive1 ((t (:background ,background :foreground ,nano-color-foreground))))
   ;;`(powerline-inactive2 ((t (:background ,background :foreground ,nano-color-foreground))))


   `(custom-button ((t (:foreground ,nano-color-faded
                        :background ,nano-color-background
                         :box `(:line-width 1
                                            :color ,nano-color-faded
                                            :style nil)))))
                         
   `(custom-button-mouse ((t (;;:inherit 'custom-button
                                :foreground ,nano-color-faded
                                :background ,nano-color-subtle
                                :box `(:line-width 1
                                            :color ,nano-color-faded
                                            :style nil)))))
                                 
   `(custom-button-pressed ((t (:foreground ,nano-color-background
                                :background ,nano-color-salient
                                ;;:inherit `(:foreground ,nano-color-salient :weight light)
                                :box `(:line-width 1
                                       :color ,nano-color-salient
                                       :style nil)
                                :inverse-video nil))))

    ;; for example state field in customize face settings
    `(custom-state ((t (:foreground ,nano-color-salient :weight light))))
    `(custom-modified ((t (:foreground ,nano-color-salient :weight light))))
    `(custom-changed ((t (:foreground ,nano-color-salient :weight light))))

    ;; for example search field in customize-face settings
    `(widget-field ((t (:background ,nano-color-subtle))))

   ;; highlight numbers
   `(highlight-numbers-number ((t (:foreground ,nano-color-salient))))
   )

  (custom-theme-set-variables
   'nano
   '(linum-format " %5i ")
   )
  )

;;;###autoload
(when (and (boundp 'custom-theme-load-path) load-file-name)
  (add-to-list 'custom-theme-load-path
               (file-name-as-directory (file-name-directory load-file-name))))

;; *****************************************************************************

(provide-theme 'nano)

;; Local Variables:
;; no-byte-compile: t
;; End:

(provide 'nano-theme)

;;; nano-theme.el ends here
