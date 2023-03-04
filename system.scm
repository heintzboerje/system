;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)(nongnu packages linux)(gnu services))
(use-service-modules cups desktop networking xorg ssh)

(operating-system
  (kernel linux)
  (firmware (cons* iwlwifi-firmware
		   %base-firmware))
  (locale "en_US.utf8")
  (timezone "America/New_York")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "eva")

  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
			(name "nixbld1")
			(comment "")
			(group "nixbld")
			(supplementary-groups
				'("nixbld"))
			(create-home-directory? #f)
			(shell "$(which nologin)")
			(system? #t))

		(user-account
                  (name "snake")
                  (comment "Main user")
                  (group "users")
                  (home-directory "/home/snake")
                  (supplementary-groups '("wheel" "netdev" "audio" "video"))
									; (shell (file-append zsh "/bin/zsh"))
									)
                %base-user-accounts))

  (groups (cons* (user-group
	(name "nixbld"))
	%base-groups))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  (packages (append (list
				(specification->package "icedtea")
				(specification->package "bluez")
				;; (specification->package "qtile")
			  (specification->package "links")
			  (specification->package "qutebrowser")
			  (specification->package "kitty")
			  (specification->package "nix")
				(specification->package "xsel")
				(specification->package "brightnessctl")
				(specification->package "glibc")
				(specification->package "gcc-toolchain")
			  (specification->package "awesome")
                          (specification->package "nss-certs"))
                    %base-packages))

  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services
   (append (list

                 ;; To configure OpenSSH, pass an 'openssh-configuration'
                 ;; record as a second argument to 'service' below.
                 (service openssh-service-type)
                 (service tor-service-type)
                 (service cups-service-type)
								 (service bluetooth-service-type)
								 ;; (service sddm-service-type
										;; (sddm-configuration
									;; (relogin? #t)))
                 (set-xorg-configuration
                  (xorg-configuration (keyboard-layout keyboard-layout))))
           ;; This is the default list of services we
           ;; are appending to.
		 (modify-services %desktop-services
				  (guix-service-type config => (guix-configuration
								(inherit config)
								(substitute-urls
								 (append (list "https://substitutes.nonguix.org")
									 %default-substitute-urls))
								(authorized-keys
								 (append (list (local-file "signing-key.pub"))
									 %default-authorized-guix-keys)))))
		 ))

  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))
  (swap-devices (list (swap-space
                        (target (uuid
                                 "00e077aa-faf6-4ffe-be4b-c27c09ff7030")))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (uuid
                                  "ef89ddbd-d72d-4713-ad8a-97df279e53a7"
                                  'ext4))
                         (type "ext4"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "C613-007F"
                                       'fat32))
                         (type "vfat")) %base-file-systems)))