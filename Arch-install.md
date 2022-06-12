- setfont ter-132n
- iwctl for wifi 
- no partition boot flag for UEFI installation

- base base-devel linux linux-firmware amd-ucode vim
- grub efibootmgr networkmanager network-manager-applet wpa_supplicant git reflector zsh linux-headers bluez bluez-utils xdg-utils xdg-user-dirs rsync openssh

- multilib repository

- Laptop Gestures https://wiki.archlinux.org/title/Touchpad_Synaptics

### Graphics
- mesa
- xf86-video-amdgpu


### PACKAGES

- xorg
- iwd
- man-pages
- pulseaudio
- xclip for vim clipboard
- blue, bluez-utils
- alsa-utils
- acpi
- virt-manager
- qemu
- bridge-utils
- dnsmasq
- openbsd-netcat
- iptables
- nftables
- os-prober
- dialog
- mtools
- dosfstools
- dmidecode
- openssh
- xf86-input-synaptics
- tlp
- gvfs
- udisks2
- firewalld
- wmname
- pamixer
- betterlockscreen

### Programs

- alacritty
- pcmanfm
- ncmpcpp
- mpd
- zathura
- mpd
- firefox
- gimp
- obs-studio
- redshift
- flameshot
- volumeicon


### Systemd Services

- networkmanager
- bluetooth
- sshd
- cups
- tlp
- fstrim.timer
- reflector.timer
- libvirtd
- firewalld
- acpid (optional ??)


### Themes

https://wiki.archlinux.org/title/Uniform_look_for_Qt_and_GTK_applications

- lxappearance
- qt5ct

#### GTK

- nordic-darker-theme
- paper-icon-theme
- bibata-cursor-theme
- vimix-icon-theme

#### QT

- kvantum

### Fonts

- noto-fonts-emoji
- noto-fonts
- ttf-dejavu
- ttf-fira-mono
- ttc-iosevka
- adobe-source-code-pro-fonts
- ttf-opensans
- adobe-source-han-sans-cn-fonts
- adobe-source-han-sans-jp-fonts
- adobe-source-han-sans-kr-fonts
- ttf-material-design-icons
- nerd-fonts-jetbrains-mono
- ttf-iosevka-nerd
- ttf-font-awesome


### Backlight

Install **mesa**, **xf86-video-amdgpu**, **brillo** and maybe **acpilight** packages and create udev rule in /etc/udev/rules.d/backlight.rules:
*ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl0", GROUP="video", MODE="0664"*.
Add user to video group.

https://www.youtube.com/watch?v=pGOaSS8nEQA

### Android USB Transfer

**Packages:**

- android-tools
- mtpfs
- gvfs-mtp
- gvfs-gphoto2


