;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
	     (nongnu packages linux)
	     ;; (gnu services desktop)
	     ;; (guix channels)
	     ;; (srfi srfi-1)
	     ;; (guix inferior)
	     )
(use-service-modules desktop admin cups networking ssh xorg sddm nix)
(use-package-modules cups package-management shells wm)

(operating-system
  #| (kernel
    (let*
      ((channels
	 (list (channel
		 (name 'nonguix)
		 (url "https://gitlab.com/nonguix/nonguix")
		 (commit "dd7519aa20948e42469eccc3c7c99c1633420a07")
		 )
	       (channel
		 (name 'guix)
		 (url "https://git.savannah.gnu.org/git/guix.git")
		 (commit "b4382b294e6cd475e9476610d98fdd0bdaec4c84"))))
       (inferior
	 (inferior-for-channels channels)))
      (first (lookup-inferior-packages inferior "linux" "6.3.5")))) |#
  (kernel linux)
  (label "Asami 0.1")
  (firmware (cons* ibt-hw-firmware iwlwifi-firmware %base-firmware))
  (locale "fr_FR.utf8")
  (timezone "America/New_York")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "buscador")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
		  (name "yu")
		  (comment "Yu")
		  (group "users")
		  (home-directory "/home/yu")
		  (supplementary-groups '("wheel" "netdev" "audio" "video" "lp"))
		  (shell (file-append zsh "/bin/zsh")))

		#| (user-account
		  (name "kodi")
		  (comment "Kodi")
		  (group "users")
		  (home-directory "/home/kodi")
		  (supplementary-groups '("wheel" "netdev" "audio" "video"))) |#
		%base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  
  (packages (append (list (specification->package "awesome")
			  (specification->package "qtile")
			  (specification->package "xmonad")
			  (specification->package "ghc-xmonad-contrib")
			  (specification->package "xmobar")
			  (specification->package "sugar-dark-sddm-theme")
			  (specification->package "icedtea")
			  (specification->package "i3lock")
			  (specification->package "i3lock-fancy")
			  (specification->package "kitty")
			  (specification->package "nix")
			  (specification->package "nss-certs")
			  ;; (specification->package "racket")
			  (specification->package "bluez")
			  (specification->package "zsh-syntax-highlighting")
			  (specification->package "zsh-completions")
			  )
		    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services (append (list (service openssh-service-type)
			  (service tor-service-type)
			  (service cups-service-type
				   (cups-configuration
				     (extensions
				       (list cups-filters hplip-minimal))))
			  (service nix-service-type)
			  (service gpm-service-type)
			  (service bluetooth-service-type
				   (bluetooth-configuration
				     ;; (bluez bluez)
				     (auto-enable? #t)))
			  (service unattended-upgrade-service-type
				   (unattended-upgrade-configuration
				     (operating-system-file
				       (file-append (local-file "." "config-dir" #:recursive? #t) "/config.scm"))))
			  (service sddm-service-type
				   (sddm-configuration
				     (theme "sugar-dark")
				     (numlock "none")
				     (minimum-vt 1)
				     (xorg-configuration
				       (xorg-configuration (keyboard-layout keyboard-layout)))))
			  #| (service screen-locker-service-type
				   (screen-locker-configuration
				     (name "i3lock-fancy")
				     (program (file-append i3lock-fancy "/bin/i3lock-fancy"))
				     (using-setuid? #t))) |#
			  )
		    (modify-services %desktop-services
				     (delete gdm-service-type)
				     (guix-service-type config =>
							(guix-configuration
							  (inherit config)
							  (substitute-urls
							    (append (list "https://substitutes.nonguix.org")
								    %default-substitute-urls))
							  (authorized-keys
							    (append (list (local-file "key.pub"))
								    %default-authorized-guix-keys)))))))

  (bootloader (bootloader-configuration
		(bootloader grub-efi-bootloader)
		(targets (list "/boot/efi"))
		(keyboard-layout keyboard-layout)))

  (swap-devices (list (swap-space
			(target (file-system-label "MY-SWAP")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
			 (mount-point "/boot/efi")
			 (device (file-system-label "MY-BOOT"))
			 (type "vfat"))
		       (file-system
			 (mount-point "/")
			 (device (file-system-label "MY-ROOT"))
			 (type "ext4"))
		       %base-file-systems)))
