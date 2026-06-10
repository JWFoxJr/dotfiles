function fish_right_prompt
    set -l last_status $status

    set -l color_error f38ba8
    set -l color_time 94e2d5
    set -l color_duration fab387
    set -l color_muted 6c7086

    # Exit status, only if non-zero.
    if test $last_status -ne 0
        set_color $color_error
        printf '󰅙 %s ' $last_status
        set_color normal
    end

    # Command duration, only if over 1 second.
    if test "$CMD_DURATION" -gt 1000 2>/dev/null
        set -l seconds (math -s1 "$CMD_DURATION / 1000")

        set_color $color_duration
        printf '󱎫 %ss ' "$seconds"
        set_color normal
    end

    # Clock
    set_color $color_muted
    printf 'at '
    set_color $color_time
    printf ' %s' (date '+%H:%M:%S')
    set_color normal
end
