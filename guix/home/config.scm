(use-modules   (gnu home)
    (gnu home services desktop)
    (gnu home services shells)
    (gnu home services media)
    (gnu services)
    (gnu packages)
    (guix gexp)
    (gnu packages admin))

(home-environment
 (packages (specifications->packages (list  "btop" "brightnessctl"
                                            "python" "picom"
                                            "ninja" "clang"
                                            "xinput" "unzip"
                                            "git" "j4-dmenu-desktop"
                                            "libreoffice" "pamixer"
                                            "love" "vlc"
                                            "cmus" "cava"
                                            "chez-scheme"
                                            "xclip" "sqlite"
                                            "jmtpfs" "ripgrep"
                                            "qutebrowser" "dmenu"
                                            "zsh-syntax-highlighting"
                                            "jp2a" "jq" "curl"
                                            "neofetch" "imagemagick"
                                            "xdg-utils" "scrot" "zathura"
                                            "zathura-pdf-poppler" "zathura-cb"
                                            "zathura-djvu" "zathura-ps"
                                            "zathura-pdf-mupdf" "qutebrowser"
                                            "moc" "mit-scheme"
                                            "ruby" "python-ipython"
					    "calibre"
					    )))
 (services (list
            (service home-zsh-service-type
             (home-zsh-configuration
              (zshrc (list (local-file "zshrc" "zshrc")))))
            (service home-redshift-service-type))))
           ;; (service home-dbus-service-type)
            
      ;; (service home-unclutter-service-type
         ;; (home-unclutter-configuration
          ;; (idle-timeout 15
           ;; ))) 
           ;; (service home-kodi-service-type)
           ;; (service home-xmodmap-service-type
           ;; (home-xmodmap-configuration (key-map '(("" . "")))))
      
