function fish_prompt
    set -l last_status $status

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

    # Git segment, only inside a git work tree
    if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
        set -l branch (git symbolic-ref --short HEAD 2>/dev/null)

        if test -z "$branch"
            set branch (git rev-parse --short HEAD 2>/dev/null)
        end

        printf ' '

        set_color $c_muted
        printf 'on '
        set_color normal

        printf '%s' (fish_prompt_git_provider_icon)
        printf ' '
        set_color $c_git
        printf ' '
        printf '%s' "$branch"
        set_color normal

        set -l git_status (fish_prompt_git_status)

        if test -n "$git_status"
            printf ' '
            set_color $c_muted
            printf '%s' "$git_status"
            set_color normal
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
