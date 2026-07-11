function fish_prompt
    set -l last_status $status

    # Pane width
    set -l cols (fish_prompt_cols)

    # Width policy
    set -l show_git 1
    set -l show_on_word 1
    set -l show_git_status 1

    # On Joe's ultrawide Ghostty layout, the 75/25 rail is still often
    # wider than 75 columns. Treat anything below 120 cols as compact.
    if test "$cols" -lt 120
        set show_on_word 0
        set show_git_status 0
    end

    # Extremely narrow panes get path-only steel.
    if test "$cols" -lt 80
        set show_git 0
    end

    # P10K Lean-ish colors from your screenshot
    set -l c_os cdd6f4 # light gray/white
    set -l c_path 00afff # cyan/blue
    set -l c_muted a6adc8 # soft gray
    set -l c_git a6e22e # bright green
    set -l c_error ff5f87 # pink/red

    # First line: OS glyph
    fish_prompt_os_icon

    # Folder glyph + path
    set_color $c_path
    printf ' '
    printf '%s' (prompt_pwd)
    set_color normal

    # Git segment, only inside a git work tree and only when the pane is wide enough.
    if test "$show_git" -eq 1; and command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l branch (git symbolic-ref --short HEAD 2>/dev/null)

        if test -z "$branch"
            set branch (git rev-parse --short HEAD 2>/dev/null)
        end

        # Keep long branch names from eating the right rail.
        if test "$cols" -lt 160
            set branch (string shorten --max 18 -- "$branch")
        end

        if test "$cols" -lt 120
            set branch (string shorten --max 12 -- "$branch")
        end

        printf ' '

        if test "$show_on_word" -eq 1
            set_color $c_muted
            printf 'on '
            set_color normal
        end

        # Call directly so provider colors survive.
        fish_prompt_git_provider_icon
        printf ' '

        set_color $c_git
        printf ' '
        printf '%s' "$branch"
        set_color normal

        if test "$show_git_status" -eq 1
            set -l git_status (fish_prompt_git_status)

            if test -n "$git_status"
                printf ' '
                # Call directly so individual status-token colors survive.
                fish_prompt_git_status
                set_color normal
            end
        end
    end

    # Second line prompt char
    printf '\n'

    if test $last_status -eq 0
        set_color --bold $c_git
        printf '❯ '
    else
        set_color --bold $c_error
        printf '❯ '
    end

    set_color normal
end
