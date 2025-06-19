set -e

if [ -n "$BASH_VERSION" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
elif [ -n "$ZSH_VERSION" ]; then
  SCRIPT_DIR="$(cd "$(dirname "${(%):-%N}")" && pwd)"
else
  echo "Unsupported shell, you are likely using dash. Run `zsh init.sh` or ´bash init.sh´ to source .zshrc or .bashrc respectively"
fi


GITDST="$HOME/.cfg"
GITSRC="$SCRIPT_DIR/.git"
REPO_NAME=$(basename "$(git -C "$CURDIR" rev-parse --show-toplevel)")

if [ "$SCRIPT_DIR" = "$HOME" ]; then
    echo "Initialization already done, nothing to do."
    exit 1
fi

if [ "$REPO_NAME" != "dotfiles" ]; then
    echo "FATAL: $GITSRC does not contain a git repository 'dotfiles', found '$REPO_NAME'"
    exit 1
fi

git --git-dir=$GITSRC config --local status.showUntrackedFiles no

if [ -e "$GITDST" ]; then
    echo "The git directory '$GITDST' already exists"
    echo "What do you want to do? [o]verwrite / [k]eep / [a]bort"
    while true; do
        printf "Your choice: "
        read choice
        case "$choice" in
            o|O)
                echo "Are you sure you want to overwrite the existing directory? [y/n]"
                read confirm
                if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
                    echo "Aborted."
                    exit 1
                else
                    echo "Overwriting existing directory..."
                    rm -rf "$GITDST"
                    cp -R "$GITSRC" "$GITDST"
                    break
                fi
                ;;
            k|K)
                echo "Keeping existing directory. Skipping copy."
                break
                ;;
            a|A)
                echo "Aborted."
                exit 1
                ;;
            *)
                echo "Invalid choice. Please enter o, k, or a."
                ;;
        esac
    done
else
    echo "Creating $GITDST..."
    cp -R $GITSRC $GITDST
    echo "Creating $GITDST... Done!\n"
fi

echo "Copying configuration files into $HOME..."
find "$CURDIR" -mindepth 1 -maxdepth 1 ! -name '.git' -exec cp -Riv {} "$HOME/" \;
echo "Copying configuration files into $HOME... Done!\n"

if [ -n "$BASH_VERSION" ]; then
    echo "sourcing .bashrc ..."
    source "$HOME/.bashrc"
    echo "... Done!\n"
elif [ -n "$ZSH_VERSION" ]; then
    echo "sourcing .zshrc ..."
    source "$HOME/.zshrc"
    echo "... Done!\n"
fi

alias cfg="git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

echo "Initialization complete."
echo ""
echo "Manage dotfiles with the 'cfg' command. It's already been aliased for you:"
echo ""
echo "  alias cfg=git --git-dir=$HOME/.cfg/ --work-tree=$HOME <command>"
echo ""
echo "You can now safely delete $SCRIPT_DIR if you wish, as all files have been copied to your home directory."
