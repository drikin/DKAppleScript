tell application "System Events"
	set all_apps to the name of every process whose visible is true
	set front_app to name of the first process whose frontmost is true
end tell

repeat with a in all_apps
	if not (application a is application front_app) then
		minimize_all(a)
	end if
end repeat

tell application front_app
	activate
end tell

on minimize_all(theApplication)
	tell application theApplication to try
		activate
		tell application "System Events" to try
			keystroke "`" using {command down}
			keystroke "m" using {command down, option down}
		end try
	end try
end minimize_all