function fish_prompt_cols
    set -l cols (command tput cols 2>/dev/null)

    if string match -qr '^[0-9]+$' -- "$cols"
        printf '%s\n' "$cols"
    else
        printf '999\n'
    end
end
