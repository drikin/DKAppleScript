tell application "System Events"
	tell application "Chromium" to quit
end tell

try
	do shell script "rm -rf /tmp/chromedownload"
	do shell script "mkdir /tmp/chromedownload"
end try
do shell script "curl http://build.chromium.org/buildbot/snapshots/sub-rel-mac/LATEST -o /tmp/chromedownload/LATEST --silent"
do shell script "LATEST=`cat /tmp/chromedownload/LATEST` && curl http://build.chromium.org/buildbot/snapshots/sub-rel-mac/$LATEST/chrome-mac.zip -o /tmp/chromedownload/chrome-mac.zip --silent"
do shell script "cd /tmp/chromedownload && unzip -qq /tmp/chromedownload/chrome-mac.zip"
do shell script "cp -R /tmp/chromedownload/chrome-mac/Chromium.app /Applications"

tell application "Chromium"
	activate
end tell