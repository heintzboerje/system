;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services shells))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list "btop"
                                            "zathura-pdf-poppler"
                                            "zathura"
                                            "cmake"
                                            "picom"
                                            "python"
                                            "libjpeg"
                                            "libffi"
                                            "openssl"
                                            "sqlite"
                                            "make"
                                            "chez-scheme"
                                            "valgrind"
                                            "mit-scheme"
                                            "jed"
                                            "mle"
                                            "info-reader"
                                            "sicp"
                                            "gcc"
                                            "gnome-boxes"
                                            "kakoune"
                                            "gcc-toolchain"
                                            "ripgrep"
                                            "python-pyxdg"
                                            "blueman"
                                            "xsel"
                                            "bluez"
                                            "weechat"
                                            "wget"
                                            "python-iwlib"
                                            "imagemagick"
                                            "curl"
                                            "psutils"
                                            "luakit"
                                            "cmus"
                                            "brightnessctl"
                                            "neofetch"
                                            "qemu"
                                            "love"
                                            "pulsemixer"
                                            "mgba"
                                            "bsd-games"
                                            "python-black"
                                            "xinput"
                                            "binutils"
                                            "clang@15.0.6"
                                            "git"
                                            "pamixer"
                                            "nyxt"
                                            "neovim"
                                            "links"
                                            "python-hy"
                                            "unzip"
                                            "lugaru")))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (list (service home-bash-service-type
                  (home-bash-configuration
                   (aliases '(("grep" . "grep --color=auto") ("ll" . "ls -l")
                              ("ls" . "ls -p --color=auto")
                              ("qutebrowser" . "qutebrowser --qt-flag disable-seccomp-filter-sandbox")))
                   (bashrc (list (local-file
                                  ".config/guix/actual-home/.bashrc" "bashrc")))
                   (bash-profile (list (local-file
                                        ".config/guix/actual-home/.bash_profile"
                                        "bash_profile"))))))))
