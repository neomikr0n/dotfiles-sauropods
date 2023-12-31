export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Session
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=hyprland
export XDG_CURRENT_DESKTOP=hyprland

# GTK
export MOZ_ENABLE_WAYLAND=1             # only start firefox in wayland mode and no other GTK apps
export MOZ_DBUS_REMOTE=1                # fixes firefox is already running, but is not responding
export MOZ_WAYLAND_USE_VAAPI=1
export GDK_BACKEND=wayland             # this can prevent programs from starting (e.g. chromium and electron apps). therefore, this should be set per app instead of globally.

# clutter
#export CLUTTER_BACKEND=wayland          # this can prevent programs from starting. therefore, this should be set per app instead of globally.

# elementary
export ECORE_EVAS_ENGINE=wayland-egl
export ELM_ENGINE=wayland_egl

# java
export _JAVA_AWT_WM_NONREPARENTING=1
export NO_AT_BRIDGE=1
export BEMENU_BACKEND=wayland

# sdl
export SDL_VIDEODRIVER=wayland           # this can prevent programs from starting old sdl games. therefore, this should be set per app instead of globally.

# Qt
export QT_QPA_PLATFORM=wayland

export FZF_DEFAULT_OPTS=" \
--color=bg+:-1,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#a6e3a1,prompt:#cba6f7,hl+:#f38ba8"
