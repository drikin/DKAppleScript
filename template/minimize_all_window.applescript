on minimize_all(theApplication)
	tell application theApplication
		repeat with theWindow in windows
			set miniaturized of theWindow to true
		end repeat
	end tell
	
	tell application theApplication
		repeat with theWindow in windows
			set miniaturized of theWindow to true
		end repeat
	end tell
end minimize_all

-- minimize_all("Safari")