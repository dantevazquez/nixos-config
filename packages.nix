
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    btop
    vim
    libnotify
    neovim
    tmux
    ripgrep
    htop
    lazygit
    tree
    nixd
    nixfmt
    imagemagick
    tree-sitter
    unzip
    nautilus
    polkit_gnome
    bash-language-server
    shfmt
    xdg-utils
    gh
    fzf
    fd
    google-chrome
    yazi
    python3
    alacritty
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
