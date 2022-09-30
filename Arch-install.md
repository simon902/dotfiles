- setfont ter-132n
- iwctl for wifi 
- no partition boot flag for UEFI installation

- base base-devel linux linux-firmware amd-ucode vim
- grub efibootmgr networkmanager network-manager-applet wpa_supplicant git reflector zsh linux-headers bluez bluez-utils xdg-utils xdg-user-dirs rsync openssh

- multilib repository

- Laptop Gestures https://wiki.archlinux.org/title/Touchpad_Synaptics

- Firefox: set page size to A4 for printing


### Graphics
- mesa
- xf86-video-amdgpu


### PACKAGES

- xorg
- xorg-xinit
- iwd
- man-pages
- pulseaudio
- xclip for vim clipboard
- bluez, bluez-utils
- pulseaudio-bluetooth
- alsa-utils
- acpi
- virt-manager
- qemu-desktop
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
- betterlockscreen                      (aur)
- exa
- lscolors-git                          (aur)
- starship
- neovim

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
- ranger
- sxiv
- volumeicon
- polybar                       (aur)
- bspwm   
- sxhkd
- rofi
- dmenu 


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
- ttf-iosevka-nerd
- ttf-font-awesome
- ttf-material-design-icons             (aur)
- nerd-fonts-jetbrains-mono             (aur)
- nerd-fonts-roboto-mono                (aur)


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


### VSCode Extensions

- C/C++
- clangd
- CodeLLDB
- ES7+ React/Redux/React-Native snippets
- Haskell
- Haskell Syntax Highlighting
- Live Server
- One Monokai Theme
- Prettier - Code formatter
- Python
- Quokka.js
- Tabnine
- Vim


