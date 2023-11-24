#!/bin/sh

## LXQt common settings
contains()
{
    local str="$1" substr="$2"
    [ "$str" = "$substr" -o -z "${str##$substr:*}" -o -z "${str##*:$substr:*}" -o -z "${str%%*:$substr}" ]
}

if [ -z "$XDG_DATA_HOME" ]; then
    export XDG_DATA_HOME="$HOME/.local/share"
fi

if [ -z "$XDG_CONFIG_HOME" ]; then
    export XDG_CONFIG_HOME="$HOME/.config"
fi

if [ -z "$XDG_DATA_DIRS" ]; then
    XDG_DATA_DIRS="$XDG_DATA_HOME:/usr/local/share:/usr/share"
else
    if ! contains "$XDG_DATA_DIRS" "/usr/share"; then
        XDG_DATA_DIRS="$XDG_DATA_DIRS:/usr/share"
    fi
fi
export XDG_DATA_DIRS

if [ -z "$XDG_CONFIG_DIRS" ]; then
    export XDG_CONFIG_DIRS="/etc:/etc/xdg:/usr/share"
else
    if ! contains "$XDG_CONFIG_DIRS" '/etc/xdg'; then
        XDG_CONFIG_DIRS="$XDG_CONFIG_DIRS:/etc/xdg"
    fi
fi

if [ -z "$XDG_CACHE_HOME" ]; then
    export XDG_CACHE_HOME="$HOME/.cache"
fi

# Ensure the existence of the 'Desktop' folder
if [ -e "$XDG_CONFIG_HOME/user-dirs.dirs" ]; then
    . "$XDG_CONFIG_HOME/user-dirs.dirs"
else
    XDG_DESKTOP_DIR="$HOME/Desktop"
fi
mkdir -p "$XDG_DESKTOP_DIR"

# Launch DBus if needed
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    if [ -z "$XDG_RUNTIME_DIR" ] || ! [ -S "$XDG_RUNTIME_DIR/bus" ] || ! [ -O "$XDG_RUNTIME_DIR/bus" ]; then
        eval "$(dbus-launch --sh-syntax --exit-with-session)" || echo "startlxqt: error executing dbus-launch" >&2
    fi
fi

# Qt4 platform plugin
export QT_PLATFORM_PLUGIN="lxqt"

# Qt5 platform plugin
export QT_QPA_PLATFORMTHEME="lxqt"

# use lxqt-applications.menu for main app menu
export XDG_MENU_PREFIX="lxqt-"

export XDG_CURRENT_DESKTOP="LXQt"

# Import compositor from  LXQt settings:
#export $(cat $XDG_CONFIG_HOME/lxqt/session.conf |grep wayland_compositor)
export wayland_compositor=Hyprland

# Import and set locale and scale factor from lxqt (not needed if using lxqt-session)
export $(cat "$XDG_CONFIG_HOME"/lxqt/lxqt-config-locale.conf |grep LANG)
export $(cat "$XDG_CONFIG_HOME"/lxqt/session.conf |grep QT_SCALE_FACTOR)

# Faster startup for GTK applications
dbus-update-activation-environment --systemd WAYLAND_DISPLAY DISPLAY XAUTHORITY

# Firefox
export MOZ_ENABLE_WAYLAND=1

# Grim (screenshots)
#export GRIM_DEFAULT_DIR=/tmp

# Create wayland settings dir if not existing
mkdir -p -- "$XDG_CONFIG_HOME/lxqt-wayland"