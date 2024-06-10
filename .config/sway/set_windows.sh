swaymsg "assign [class=\"Brave-browser\"] 1"
swaymsg "assign [class=\"Alacritty\"] 1"
swaymsg "assign [class=\"Obsidian\"] 1"
swaymsg "assign [class=\"Binary Ninja\"] 2"

swaymsg "workspace \"1: Web and Code\"; append_layout ~/.config/i3/workspace-1.json"
swaymsg 'exec --no-startup-id brave-browser'
swaymsg 'exec --no-startup-id alacritty'
swaymsg 'exec --no-startup-id obsidian'

swaymsg "workspace \"2: BinaryNinja\"; append_layout ~/.config/i3/workspace-2.json"
swaymsg 'exec --no-startup-id $HOME/binaryninja/binaryninja'
