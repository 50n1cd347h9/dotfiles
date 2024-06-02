i3-msg "assign [class=\"Brave-browser\"] 1"
i3-msg "assign [class=\"Alacritty\"] 1"
i3-msg "assign [class=\"Obsidian\"] 1"
i3-msg "assign [class=\"Binary Ninja\"] 2"

i3-msg "workspace \"1: Web and Code\"; append_layout ~/.config/i3/workspace-1.json"
i3-msg 'exec --no-startup-id brave-browser'
i3-msg 'exec --no-startup-id alacritty'
i3-msg 'exec --no-startup-id obsidian'

i3-msg "workspace \"2: BinaryNinja\"; append_layout ~/.config/i3/workspace-2.json"
i3-msg 'exec --no-startup-id $HOME/binaryninja/binaryninja'
