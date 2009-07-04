tell application "System Events"
	set frontmostApplication to name of the first process whose frontmost is true
	tell process frontmostApplication
		set frontmostWindow to name of window 1
		return frontmostWindow
	end tell
end tell
