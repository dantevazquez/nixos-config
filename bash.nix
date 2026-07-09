{ config, pkgs, ... }:

{
  programs.bash = {
    # Define your basic aliases
    shellAliases = {
      nixedit = "sudoedit /etc/nixos/configuration.nix";
      nixclean = "sudo nix-collect-garbage -d && sudo nixos-rebuild switch";
    };

    # Define your custom shell functions for interactive sessions
    interactiveShellInit = ''
      nixadd() {
          if [ $# -eq 0 ]; then
              echo "Error: Please specify at least one package (e.g., nixadd ripgrep htop tmux)"
              return 1
          fi

          for pkg in "$@"; do
              sudo sed -i "/#pkgs_start/a \    $pkg" /etc/nixos/configuration.nix
              echo "Added $pkg to configuration.nix"
          done

          echo "Rebuilding system..."
          sudo nixos-rebuild switch
      }

      nixlist() {
          echo "Currently installed packages via script:"
          echo "----------------------------------------"
          sed -n '/#pkgs_start/,/#pkgs_end/p' /etc/nixos/configuration.nix \
              | grep -vE '#pkgs_start|#pkgs_end|^[[:space:]]*$' \
              | sed 's/^[[:space:]]*//' \
              | sed 's/^/  • /'
          echo "----------------------------------------"
      }

      nixremove() {
          if [ $# -eq 0 ]; then
              echo "Error: Please specify at least one package to remove (e.g., nixremove htop)"
              return 1
          fi

          for pkg in "$@"; do
              sudo sed -i "/#pkgs_start/,/#pkgs_end/ { /^[[:space:]]*$pkg[[:space:]]*$/d }" /etc/nixos/configuration.nix
              echo "Removed $pkg from configuration.nix"
          done

          echo "Rebuilding system..."
          sudo nixos-rebuild switch
      }
    '';
  };
}
