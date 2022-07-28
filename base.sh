#!/bin/sh
ln -sf /usr/share/zoneinfo/Europe/Vienna /etc/localtime
hwclock --systohc
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=de-latin1" >> /etc/vconsole.conf
echo "simon-arch" >> /etc/hostname

echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts
echo "127.0.0.1 simon-arch.localdomain simon-arch" >> /etc/hosts

passwd root

pacman -S terminus-font grub efibootmgr networkmanager network-manager-applet wpa_supplicant git reflector zsh linux-headers bluez bluez-utils xdg-utils xdg-user-dirs rsync openssh neofetch htop libvirt


# if AMD GPU
pacman -S mesa mesa-utils vulkan-radeon

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg


systemctl enable NetworkManager
systemctl enable cups.service
systemctl enable tlp
systemctl enable fstrim.timer
systemctl enable libvirtd
systemctl enable virtlogd.socket
systemctl enable firewalld
systemctl enable acpid
# systemctl enable bluetooth
# systemctl enable sshd

useradd -mG wheel simon
passwd simon
usermod -aG network,storage,video,libvirt simon

echo -e "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/99_wheel 
su -c "chsh -s /usr/bin/zsh" simon


echo "Run: exit\numount -R /mnt\nreboot"
