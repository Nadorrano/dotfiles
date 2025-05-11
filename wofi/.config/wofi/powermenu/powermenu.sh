choice=$(wofi --conf ~/.config/wofi/powermenu/config << EOF
󰗽
󰑓
󰐥
EOF
)

case "$choice" in
	"󰗽")
		loginctl terminate-session $XDG_SESSION_ID
		;;
	"󰑓")
		systemctl reboot
		;;
	"󰐥")
		systemctl poweroff
		;;
esac

