function fish_prompt_cols
    # In tmux, ask tmux for the actual pane width. `tput cols` can report
    # the client/window width instead of the pane width in some layouts.
    if set -q TMUX
        set -l tmux_cols (command tmux display-message -p '#{pane_width}' 2>/dev/null)

        if string match -qr '^[0-9]+$' -- "$tmux_cols"
            printf '%s\n' "$tmux_cols"
            return
        end
    end

    set -l cols (command tput cols 2>/dev/null)

    if string match -qr '^[0-9]+$' -- "$cols"
        printf '%s\n' "$cols"
    else
        printf '999\n'
    end
end
