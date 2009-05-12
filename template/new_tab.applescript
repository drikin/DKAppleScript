on new_tab()
	tell application "Safari" to activate
	tell application "System Events"
		tell process "Safari"
			click menu item "New Tab" of menu "File" of menu bar 1
		end tell
	end tell
end new_tab

--new_tab()