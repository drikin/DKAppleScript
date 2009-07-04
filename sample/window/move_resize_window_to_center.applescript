on frontmost_app()
	tell application "System Events" to try
		set pList to name of every process whose frontmost is true
		set appName to item 1 of pList --"Script Editor"
		--set appName to name of (path to frontmost application)--"Script Editor.app"
	end try
end frontmost_app

on run
	tell application "System Events" to tell process "Dock"
		try
			set dock_position to do shell script "defaults read com.apple.dock orientation"
		on error
			set dock_position to bottom
		end try
		set dock_dimensions to size in list 1
		if (dock_position is equal to "left") or (dock_position is equal to "right") then
			set dock_width to item 1 of dock_dimensions
		else
			set dock_width to 0
		end if
		if (dock_position is equal to "top") or (dock_position is equal to "bottom") then
			set dock_height to item 2 of dock_dimensions
		else
			set dock_height to 0
		end if
	end tell
	
	tell application "Finder"
		set menuHight to 22
		set displayBounds to bounds of window of desktop
		if (dock_position is equal to "left") then
			set displaySize to {(item 3 of displayBounds) / 2 - dock_width, (item 4 of displayBounds) - menuHight - dock_height}
		else
			set displaySize to {(item 3 of displayBounds) / 2, (item 4 of displayBounds) - menuHight - dock_height}
		end if
		set displayPosition to {(item 3 of displayBounds) / 2 - (item 3 of displayBounds) / 4, (item 2 of displayBounds) + menuHight}
	end tell
	
	set appName to frontmost_app()
	tell application "System Events" to try
		tell process appName
			set topWindow to window 1
			set position of topWindow to displayPosition
			set size of topWindow to displaySize
		end tell
	end try
end run