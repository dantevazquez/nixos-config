{ config, pkgs, ... }:

{
  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    XCURSOR_SIZE = "48";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SUPPRESS_RANDR_SIZE = "1";
  };

  programs.bash = {
    completion.enable = true;

    shellAliases = {
      grep = "grep --color=auto";
      icat = "kitty +kitten icat";
      ls = "ls -la --color=auto";
      nixedit = "sudoedit /etc/nixos/configuration.nix";
      nixclean = "sudo nix-collect-garbage -d && sudo nixos-rebuild switch --flake /home/dante/nixos-config/#nixos";
      nixupgrade = "sudo nixos-rebuild switch --upgrade";
      open = "xdg-open";
      tc = "tmux new-session -A -s code";
      ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
    };

    interactiveShellInit = ''
      parse_git_branch() {
          git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
      }

      export PS1='[\u@\h \W$(parse_git_branch)]\$ '
      export PATH="$HOME/.local/bin:$HOME/.config/scripts:$PATH"

      eval "$(fzf --bash)"

      fcd() {
          local dir
          dir=$(fd --type d --hidden --exclude .git | fzf) && cd "$dir"
      }

      bind "set completion-ignore-case on"
      bind "set show-all-if-ambiguous on"
      set -o vi

      nixadd() {
          local selected
          selected=$(nix-search-tv print | fzf --multi --query="$*" --preview 'nix-search-tv preview {}')
          if [ -z "$selected" ]; then
              echo "No package selected."
              return 0
          fi

          local pkgs
          pkgs=$(echo "$selected" | sed 's|^[^/]*/[[:space:]]*||')
          for pkg in $pkgs; do
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
          local installed
          installed=$(sed -n '/#pkgs_start/,/#pkgs_end/p' /etc/nixos/configuration.nix \
              | grep -vE '#pkgs_start|#pkgs_end|^[[:space:]]*$' \
              | sed 's/^[[:space:]]*//')

          if [ -z "$installed" ]; then
              echo "No packages found in configuration.nix between #pkgs_start and #pkgs_end."
              return 1
          fi

          local selected
          selected=$(echo "$installed" | fzf --multi --query="$*" --header="Select package(s) to remove")
          if [ -z "$selected" ]; then
              echo "No package selected."
              return 0
          fi

          for pkg in $selected; do
              sudo sed -i "/#pkgs_start/,/#pkgs_end/ { /^[[:space:]]*$pkg[[:space:]]*$/d }" /etc/nixos/configuration.nix
              echo "Removed $pkg from configuration.nix"
          done

          echo "Rebuilding system..."
          sudo nixos-rebuild switch
      }

      nixtest() {
          local selected
          selected=$(nix-search-tv print | fzf --multi --query="$*" --preview 'nix-search-tv preview {}')
          if [ -z "$selected" ]; then
              echo "No package selected."
              return 0
          fi

          local pkgs
          pkgs=$(echo "$selected" | sed 's|^[^/]*/[[:space:]]*||')
          if [ -z "$pkgs" ]; then
              return 0
          fi

          echo "Testing package(s) in shell: $pkgs"
          nix-shell -p $pkgs
      }
    '';
  };
}
