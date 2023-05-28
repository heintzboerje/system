;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
             (nongnu packages linux)
	     (gnu packages shells))
(use-service-modules networking ssh)

(operating-system
 (kernel linux)
  (firmware (cons iwlwifi-firmware %base-firmware))
  (locale "fr_FR.utf8")
  (timezone "America/New_York")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "Coeus")
  
  ;; The list of user accounts ('root' is implicit).
  (users (cons* (user-account
                 (name "enki")
                 (comment "Enki")
                 (group "users")
                 (home-directory "/home/enki")
                 (supplementary-groups '("wheel" "netdev" "audio" "video")))
		%base-user-accounts))

  ;; Packages installed system-wide.  Users can also install packages
  ;; under their own account: use 'guix search KEYWORD' to search
  ;; for packages and 'guix install PACKAGE' to install a package.
  
  (packages %base-packages)
  
  ;; Below is the list of system services.  To search for available
  ;; services, run 'guix system search KEYWORD' in a terminal.
  (services %base-services)
  
  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets (list "/boot/efi"))
               (keyboard-layout keyboard-layout)))
  
  (swap-devices (list (swap-space
                       (target (file-system-label
                                "my-swap")))))
  
  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                        (mount-point "/boot/efi")
                        (device (file-system-label "boot-area"))
                        (type "vfat"))
                       (file-system
                        (mount-point "/")
                        (device (file-system-label "my-root"))
                        (type "ext4")) %base-file-systems)))
