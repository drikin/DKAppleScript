property TMP_DIR : "/tmp/chromedownload"

tell application "System Events"
	tell application "Chromium" to quit
end tell

try
	do shell script "rm -rf " & TMP_DIR
	do shell script "mkdir " & TMP_DIR
end try
do shell script "curl http://build.chromium.org/buildbot/snapshots/sub-rel-mac/LATEST -o " & TMP_DIR & "/LATEST --silent"
do shell script "LATEST=`cat " & TMP_DIR & "/LATEST` && curl http://build.chromium.org/buildbot/snapshots/sub-rel-mac/$LATEST/chrome-mac.zip -o " & TMP_DIR & "/chrome-mac.zip --silent"
do shell script "cd " & TMP_DIR & " && unzip -qq " & TMP_DIR & "/chrome-mac.zip"
do shell script "cp -R " & TMP_DIR & "/chrome-mac/Chromium.app /Applications"

tell application "Chromium"
	activate
end tell