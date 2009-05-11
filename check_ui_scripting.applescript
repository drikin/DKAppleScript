tell application "System Events"
	if not (UI elements enabled) then
		tell application "System Preferences"
			activate
			set current pane to pane "com.apple.preference.universalaccess"
			set dialog_message to "This script require to turnning on" & return & return & "Enable access for assistive devices."
			display dialog dialog_message buttons "OK" default button 1 with icon caution
		end tell
	end if
end tell