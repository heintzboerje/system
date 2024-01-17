;; -*- mode: scheme; -*-
;; This is an operating system configuration template
;; for a "desktop" setup without full-blown desktop
;; environments.

(use-modules (gnu) (gnu system nss) (nongnu packages linux))
(use-service-modules desktop xorg)
(use-package-modules linux bootloaders certs emacs display-managers wm
                     xorg xdisorg terminals shells)

(operating-system
 (kernel linux)
 (label "Beyond the point of no return")
 (firmware  (list linux-firmware))
 (host-name "mimisbrunnr")
 (timezone "Europe/Paris")
 (locale "fr_FR.utf8")
 (keyboard-layout (keyboard-layout "fr"))
 
 ;; Use the UEFI variant of GRUB with the EFI System
 ;; Partition mounted on /boot/efi.
 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets '("/boot/efi"))))
 
 ;; Assume the target root file system is labelled "my-root",
 ;; and the EFI System Partition has UUID 1234-ABCD.
 (file-systems (append
                (list (file-system
                       (device (file-system-label "yggdrasil"))
                       (mount-point "/")
                       (type "ext4"))
                      (file-system
                       (device (file-system-label "hvergelmir"))
                       (mount-point "/boot/efi")
                       (type "vfat")))
                %base-file-systems))
 
 (users (cons (user-account
               (name "jheyrree")
               (comment "Jheyrree")
               (home-directory "/home/nous")
               (group "users")
	       (shell (file-append zsh "/bin/zsh"))
               (supplementary-groups '("wheel" "netdev"
                                       "audio" "video" "lp")))
              %base-user-accounts))
 
 ;; Add a bunch of window managers; we can choose one at
 ;; the log-in screen with F1.
 (packages (append (list
                    ;; window managers
                    i3-wm emacs-no-x xmobar
                    bspwm sxhkd rofi i3lock i3lock-fancy
                    ;; terminal emulator
                    alacritty
                    ;; bluetooth
                    bluez
                    ;; for HTTPS access
                    nss-certs)
                   %base-packages))
 
 ;; Use the "desktop" services, which include the X11
 ;; log-in service, networking with NetworkManager, and more.
 (services (append (list
		    (simple-service 'my-bluetooth-service bluetooth-service-type
				    (list
				    (bluetooth-configuration (name "yggdrasil"))))
		   ; (service bluetooth-service-type (bluetooth-configuration
		;				     (name "yggdrasil")))
		    (set-xorg-configuration
		     (xorg-configuration (keyboard-layout keyboard-layout)))
		    (service screen-locker-service-type
			     (screen-locker-configuration
			      (name "i3lock-fancy")
			      (program (file-append i3lock-fancy "/bin/i3lock-fancy"))
			      (allow-empty-password? #t)
			      (using-pam? #f)
			      (using-setuid? #t)))
		    )
		   %desktop-services))
 
 ;; Allow resolution of '.local' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))
