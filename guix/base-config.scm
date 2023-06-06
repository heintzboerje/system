;; Ceci est une configuration de système d'exploitation générée par
;; l'installateur graphique.
;;
;; Une fois l'installation terminée, vous pouvez apprendre à modifier
;; ce fichier pour ajuster la configuration du système et le passer à
;; la commande « guix system reconfigure » pour rendre vos changements
;; effectifs.


;; Indique quels modules importer pour accéder aux variables
;; utilisées dans cette configuration.
(use-modules (gnu)
	     (nongnu packages linux))
(use-service-modules cups desktop networking ssh xorg)

(operating-system
 (kernel linux)
 (firmware (cons* iwlwifi-firmware %base-firmware))
  (locale "fr_FR.utf8")
  (timezone "America/New_York")
  (keyboard-layout (keyboard-layout "us"))
  (host-name "buscador")

  ;; La liste des comptes utilisateurs (« root » est implicite).
  (users (cons* (user-account
                  (name "yu")
                  (comment "Yu")
                  (group "users")
                  (home-directory "/home/yu")
                  (supplementary-groups '("wheel" "netdev" "audio" "video")))
                %base-user-accounts))

  ;; Paquets installés pour tout le système. Les utilisateurs et utilisatrices peuvent aussi installer des paquets
  ;; sous leur propre compte : utilisez « guix search MOT-CLÉ » pour chercher
  ;; des paquets et « guix install PAQUET » pour installer un paquet.
  (packages (append (list (specification->package "nss-certs"))
                    %base-packages))

  ;; Voici la liste des services du système.  Pour trouver les services disponibles,
  ;; lancez « guix system search MOT-CLÉ » dans un terminal.
  (services
   (append (list

                 ;; Pour configurer OpenSSH, passez un enregistrement « openssh-configuration »
                 ;; en deuxième argument à « service » ci-dessous.
                 (service openssh-service-type)
                 (service tor-service-type)
                 (service connman-service-type)
                 (service wpa-supplicant-service-type)
                 (service ntp-service-type)
                 (service gpm-service-type)
                 (service cups-service-type))

           ;; Voici la liste des services par défaut à laquelle nous
           ;; ajoutons nos propres services.
           %base-services))
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets (list "/boot/efi"))
                (keyboard-layout keyboard-layout)))

  ;; La liste des systèmes de fichiers qui seront « montés ». Les identifiants
  ;; de systèmes de fichiers uniques (« UUIDs ») qui se trouvent ici s'obtiennent
  ;; en exécutant « blkid » dans un terminal.
  (file-systems (cons* (file-system
                         (mount-point "/")
                         (device (file-system-label "MY-ROOT"))
                         (type "ext4"))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (file-system-label "MY-BOOT"))
                         (type "vfat"))
                        %base-file-systems)))
