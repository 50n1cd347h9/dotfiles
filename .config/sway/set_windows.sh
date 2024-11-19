swaymsg "workspace 1"
swaymsg 'exec --no-startup-id wezterm'
swaymsg 'exec --no-startup-id brave-browser'

swaymsg layout tabbed
swaymsg focus right
swaymsg move left
    
# swaymsg "workspace 2"
# swaymsg 'exec --no-startup-id wezterm'
