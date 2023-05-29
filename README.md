# dotfiles

## Programs

- **OS**: Arch Linux
- **WM**: [bspwm](https://github.com/baskerville/bspwm/)
- **Shell**: [zsh](https://wiki.archlinux.org/index.php/Zsh)
- **Terminal**: [alacritty](https://alacritty.org/)
- **Shell-Prompt**: [starship](https://starship.rs/)
- **Editor**: [neovim](https://github.com/neovim/neovim/) with config from [NvChad](https://github.com/NvChad/NvChad)
- **App-Launcher**: [rofi](https://github.com/davatorium/rofi)
- **Status-Bar**: [polybar](https://github.com/polybar/polybar)
- **Document-Viewer**: [zathura](https://github.com/pwmt/zathura)
- **Music-Player**: [ncmpcpp](https://github.com/ncmpcpp/ncmpcpp)

## GUI Themes

### GTK (lxappearance)

- **Theme**: Arc-Dark
- **Icons**: Vimix
- **Cursor**: Breeze Light

### QT (qt5ct)

- **Theme**: Kvantum-dark
- **Icons**: Vimix dark

## Notes

- **font**: RobotoMono Nerd Font
- **xclip**: for systemwide-clipboard in neovim
- **noto-fonts-emoji**: package

### Python

Installing python packages for older python versions.

```bash
yay -S python3.xx

python3.xx -m ensurepip --upgrade
python3.xx -m pip install --upgrade pip

python3.xx -m pip install <pkg>
```
