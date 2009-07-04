on frontmost_app()
	tell application "System Events"
		set pList to name of every process whose frontmost is true
		set appName to item 1 of pList
	end tell
end frontmost_app

on run
	set appName to frontmost_app()
	tell application "System Events"
		tell process appName
			set topWindow to window 1
			set {WIDTH, HEIGHT} to size of topWindow
			set size of topWindow to {WIDTH + WIDTH / 4, HEIGHT}
		end tell
	end tell
end run