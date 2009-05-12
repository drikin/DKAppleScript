tell application "System Events"
	set all_apps to the name of every process whose visible is true
	set front_app to name of the first process whose frontmost is true
end tell

repeat with a in all_apps
	if not (application a is application front_app) then
		minimize_all(a)
	end if
end repeat

-- this method of minimize function require application to supporting scripting function
on minimize_all(theApplication)
	tell application theApplication to try
		repeat with theWindow in windows
			my do_menu(theApplication, "Window", "Minimize")
		end repeat
	end try
end minimize_all

on do_menu(app_name, menu_name, menu_item)
	try
		-- bring the target application to the front
		tell application app_name
			activate
		end tell
		tell application "System Events"
			tell process app_name
				tell menu bar 1
					tell menu bar item menu_name
						tell menu menu_name
							click menu item menu_item
						end tell
					end tell
				end tell
			end tell
		end tell
		return true
	on error error_message
		return false
	end try
end do_menu