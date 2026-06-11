function fish_prompt_os_icon
    set -l os (uname -s 2>/dev/null)

    # Default color: soft white/gray
    set -l c_os cdd6f4

    # Linux distro detection
    set -l distro ''
    if test -f /etc/os-release
        set distro (string lower (grep '^ID=' /etc/os-release | cut -d= -f2 | string trim --chars='"'))
    end

    set_color $c_os

    switch "$os"
        case Darwin
            # macOS
            printf ' '

        case Linux
            switch "$distro"
                case ubuntu
                    printf ' '
                case debian
                    printf ' '
                case fedora
                    printf ' '
                case arch
                    printf ' '
                case manjaro
                    printf ' '
                case opensuse-tumbleweed opensuse-leap opensuse
                    printf ' '
                case centos
                    printf ' '
                case rhel
                    printf ' '
                case rocky
                    printf ' '
                case almalinux
                    printf ' '
                case kali
                    printf ' '
                case raspbian
                    printf ' '
                case nixos
                    printf ' '
                case alpine
                    printf ' '
                case gentoo
                    printf ' '
                case void
                    printf ' '
                case '*'
                    # Generic Linux / Tux
                    printf ' '
            end

        case FreeBSD
            printf ' '

        case OpenBSD
            printf ' '

        case NetBSD
            printf '󰈺 '

        case '*'
            # Generic terminal/computer fallback
            printf ' '
    end

    set_color normal
end
