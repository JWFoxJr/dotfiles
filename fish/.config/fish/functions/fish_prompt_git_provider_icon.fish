function fish_prompt_git_provider_icon
    set -l c_github cdd6f4
    set -l c_gitlab fc6d26
    set -l c_bitbucket 2684ff
    set -l c_gitscm fca326 #f14e32

    set -l remote (git config --get remote.origin.url 2>/dev/null)

    if string match -qi '*github.com*' -- "$remote"
        set_color $c_github
        printf ' '
        set_color normal
    else if string match -qi '*foundry1*' -- "$remote"
        set_color $c_gitlab
        printf ' '
        set_color normal
    else if string match -qi '*bitbucket*' -- "$remote"
        set_color $c_bitbucket
        printf ' '
        set_color normal
    else
        set_color $c_gitscm
        printf ' '
        set_color normal
    end
end
