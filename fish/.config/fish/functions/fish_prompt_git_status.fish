function fish_prompt_git_status
    set -l porcelain (git status --porcelain=v1 --branch 2>/dev/null)

    if test -z "$porcelain"
        return
    end

    # Colors
    set -l c_staged a6e3a1 # green
    set -l c_modified f9e2af # yellow
    set -l c_untracked f38ba8 # red/pink
    set -l c_deleted f38ba8 # red/pink
    set -l c_renamed 89dceb # cyan
    set -l c_conflicted f38ba8 # red/pink
    set -l c_stashed cba6f7 # purple
    set -l c_remote cdd6f4 # white/gray

    set -l staged 0
    set -l modified 0
    set -l untracked 0
    set -l deleted 0
    set -l renamed 0
    set -l conflicted 0
    set -l ahead 0
    set -l behind 0

    for line in $porcelain
        if string match -q '##*' -- "$line"
            if string match -q '*ahead*' -- "$line"
                set ahead (string replace -r '.*ahead ([0-9]+).*' '$1' -- "$line")
            end

            if string match -q '*behind*' -- "$line"
                set behind (string replace -r '.*behind ([0-9]+).*' '$1' -- "$line")
            end

            continue
        end

        set -l x (string sub -s 1 -l 1 -- "$line")
        set -l y (string sub -s 2 -l 1 -- "$line")

        # Merge conflicts
        if string match -q -r '^(UU|AA|DD|AU|UA|DU|UD)' -- "$line"
            set conflicted (math $conflicted + 1)
            continue
        end

        # Untracked
        if string match -q '??*' -- "$line"
            set untracked (math $untracked + 1)
            continue
        end

        # Index/staged changes
        if test "$x" != ' '
            switch "$x"
                case A M
                    set staged (math $staged + 1)
                case R
                    set renamed (math $renamed + 1)
                case D
                    set deleted (math $deleted + 1)
            end
        end

        # Working tree changes
        if test "$y" != ' '
            switch "$y"
                case M
                    set modified (math $modified + 1)
                case D
                    set deleted (math $deleted + 1)
            end
        end
    end

    set -l stashed (git stash list 2>/dev/null | wc -l | string trim)

    set -l printed 0

    # Opening bracket only if there is anything to print.
    if test $conflicted -gt 0; or test $staged -gt 0; or test $modified -gt 0; or test $untracked -gt 0; or test $deleted -gt 0; or test $renamed -gt 0; or test "$stashed" -gt 0 2>/dev/null; or test "$ahead" -gt 0 2>/dev/null; or test "$behind" -gt 0 2>/dev/null

        set_color normal
        printf '['

        if test $conflicted -gt 0
            if test $printed -gt 0
                printf ' '
            end
            set_color $c_conflicted
            printf '!%s' "$conflicted"
            set printed 1
        end

        if test $staged -gt 0
            if test $printed -gt 0
                printf ' '
            end
            set_color $c_staged
            printf '+%s' "$staged"
            set printed 1
        end

        if test $modified -gt 0
            if test $printed -gt 0
                printf ' '
            end
            set_color $c_modified
            printf '~%s' "$modified"
            set printed 1
        end

        if test $untracked -gt 0
            if test $printed -gt 0
                printf ' '
            end
            set_color $c_untracked
            printf '?%s' "$untracked"
            set printed 1
        end

        if test $deleted -gt 0
            if test $printed -gt 0
                printf ' '
            end
            set_color $c_deleted
            printf '-%s' "$deleted"
            set printed 1
        end
        if test $renamed -gt 0
            if test $printed -gt 0
                printf ' '
            end
            set_color $c_renamed
            printf '»%s' "$renamed"
            set printed 1
        end

        if test "$stashed" -gt 0 2>/dev/null
            if test $printed -gt 0
                printf ' '
            end
            set_color $c_stashed
            printf '$%s' "$stashed"
            set printed 1
        end

        if test "$ahead" -gt 0 2>/dev/null
            if test $printed -gt 0
                printf ' '
            end
            set_color $c_remote
            printf '↑%s' "$ahead"
            set printed 1
        end

        if test "$behind" -gt 0 2>/dev/null
            if test $printed -gt 0
                printf ' '
            end
            set_color $c_remote
            printf '↓%s' "$behind"
            set printed 1
        end

        set_color normal
        printf ']'
    end
end
