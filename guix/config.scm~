;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
             (nongnu packages linux))
(use-service-modules cups desktop networking ssh xorg sddm nix)
(use-package-modules package-management shells wm)

(operating-system
 (kernel linux)
  (firmware (list linux-firmware))
  (locale "en_US.utf8")
  (timezone "America/New_York")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "Coeus")
  
  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                 (name "enki")
                 (comment "Enki")
                 (group "users")
                 (home-directory "/home/enki")
                 (supplementary-groups '("wheel" "netdev" "audio" "video"))
                 (shell (file-append zsh "/bin/zsh")))

                (user-account
                  (name "kodi")
                  (comment "Kodi")
                  (group "users")
                  (home-directory "/home/kodi")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  
  (packages (append (list (specification->package "awesome")
                          (specification->package "qtile")
                          (specification->package "sugar-dark-sddm-theme")
                          (specification->package "icedtea")
                          (specification->package "gcc-toolchain")
                          (specification->package "racket")
                          (specification->package "i3lock")
                          (specification->package "i3lock-fancy")
                          (specification->package "bluez")
                          (specification->package "kitty")
                          (specification->package "nix")
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
            (service nix-service-type)
            (service bluetooth-service-type)
	        (service sddm-service-type
		             (sddm-configuration
		              (theme "sugar-dark")
                      (numlock "none")
		              (xorg-configuration
		               (xorg-configuration (keyboard-layout keyboard-layout)))))
            (service screen-locker-service-type
                     (screen-locker-configuration
                      "i3lock-fancy" (file-append i3lock-fancy "/bin/i3lock") #f)))
	   
           ;; This is the default list of services we
           ;; are appending to.
            (modify-services %desktop-services
			      (delete gdm-service-type))))
  
  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets (list "/boot/efi"))
               (keyboard-layout keyboard-layout)))
  
  (swap-devices (list (swap-space
                       (target (uuid
                                "4ea9bd52-f560-4f69-8e53-71c71bb2a420")))))
  
  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                        (mount-point "/boot/efi")
                        (device (uuid "9015-A9B4"
                                      'fat32))
                        (type "vfat"))
                       (file-system
                        (mount-point "/")
                        (device (uuid
                                 "82207e91-7aa4-44ff-b07a-2a3d68b89f8e"
                                 'ext4))
                        (type "ext4")) %base-file-systems)))
