(*
**	DRM Removal Script v2.0
**  
** PREREQUISITES:
** A CD-RW
** A PLAYLIST CONTAINING THE PROTECTED TRACKS YOU WISH TO REMOVE DRM FROM
**
** Summary:
** create a long list of playlists to burn, sourced from one master playlist
** -------- start loop ------------
** burn playlist to cd
** import cd
** diskutil eraseOptical <optical disk>
** iterate to next playlist
** -------- end loop -------------
** delete list of playlists


** INSTRUCTIONS:
** 1. insert the CD-RW
** 2. put all your protected music into a single playlist, note the name of the playlist
** 3. change the originalPlaylist variable to be the name of your playlist
** 4. make sure the CD-RW is mounted and open terminal --> enter "diskutil list".
** 5. find the device with a size of 0B (hopefully that will be your optical disk! make
**    sure!) and then enter the name of that device into the opticalDisk variable
**
**   you can change playlistNameBase to whatever you like, just make sure it has a 
**   completely unique name among your playlists


** NOTICE: this has been tested with OS X 10.6.8 and iTunes 10.4.1
** I have no idea what other versions it might work on. Be careful 
** when running this if your versions do not match up with mine.
**)




-- *** VARIABLES ***
set originalPlaylist to "aaaaaa" -- playlist of all the songs you want to remove the DRM from
-- this script increments from playlist to playlist, after finding the first auto created playlist
-- so make sure there aren't any "normal" playlists in the newly created block of playlists to burn
-- just having a unique name in playlistNameBase should probably be enough, but I'm just warning you ;)
set playlistNameBase to "burnMeNOW" -- the base name of each newly created playlist
set playlistNum to 1 -- the number we start incrementing at
set opticalDisk to "/dev/disk1" -- to locate your optical disk: "diskutil list" **!! MAKE SURE YOU HAVE THE RIGHT DISK !!**
set playlistList to {}


-- The following section was taken from http://www.mactech.com/articles/mactech/Vol.21/21.06/UserInterfaceScripting/index.html
-- this code block makes sure the "access for assistive devices" is enabled in sys prefs for GUI scripting
tell application "System Events" to set isUIScriptingEnabled to UI elements enabled
if isUIScriptingEnabled = false then
	tell application "System Preferences"
		activate
		set current pane to pane "com.apple.preference.universalaccess"
		display dialog "Your system is not properly configured to run this script.  
         Please select the \"Enable access for assistive devices\" 
         checkbox and trigger the script again to proceed."
		return
	end tell
end if

-- *******************************************************
-- ***** this code block creates all the playlists we are going to burn *****
-- *******************************************************
"creating playlists..."
tell application "iTunes"
	set playlistCurrentNum to playlistNum
	repeat with aTrack in (file tracks of user playlist originalPlaylist)
		set playlistName to playlistNameBase & playlistCurrentNum
		-- we're gonna have to create each new playlist, if it doesn't already exist
		if not (exists user playlist playlistName) then
			make new user playlist with properties {name:playlistName}
			set playlistList to playlistList & playlistName
		end if
		-- make sure each playlist will fit onto a CD (max 80min == 4800s) but some songs
		-- are long, so use a lower number for fudge room
		-- if you get error messages that the playlist won't fit on a single cd, lower this number
		if (duration of user playlist playlistName is less than 4300) then
			duplicate aTrack to user playlist playlistName
		else
			set playlistCurrentNum to playlistCurrentNum + 1
		end if
	end repeat
end tell

"playlists created"

-- *****************************************************************************
-- ******** GUI SCRIPTING PART (WARNING: EASILY BREAKABLE BY ITUNES UPDATES!!!) *********
-- *****************************************************************************
-- ***** this code section searches for and burns each playlist, unmounts and remounts it (which *****
-- ***** automatically imports it again), wipes the CD-RW, increments the playlist num, and  starts ***
-- ***** over again 															 	     ******
-- *****************************************************************************

set listSize to count of playlistList
set currentPlaylistNum to playlistNum

--"starting at playlist location: " & playlistPosition

repeat while currentPlaylistNum ≤ listSize
	set currentPlaylistName to playlistNameBase & currentPlaylistNum
	"burning playlist: " & currentPlaylistName
	
	activate application "iTunes"
	tell application "System Events"
		tell process "iTunes"
			
			-- determine the location of playlist to burn
			set x to 1
			repeat
				if exists static text currentPlaylistName of row x of outline 1 of scroll area 2 of window "iTunes" then
					set currentPlaylistPosition to x
					exit repeat
				end if
				set x to x + 1
			end repeat
			
			select row currentPlaylistPosition of outline 1 of scroll area 2 of window "iTunes"
			click menu item 9 of menu 1 of menu bar item "File" of menu bar 1
			
			-- wait until burn window pops up
			repeat while not (exists static text "Disc Burner:" of window "Burn Settings")
				delay 0.5
			end repeat
			
			select window "Burn Settings"
			click button "Burn" of window "Burn Settings"
			
			"burning cd..."
			
			-- don't progress until the burning is finished
			tell application "iTunes"
				repeat while not (exists source currentPlaylistName)
					delay 0.5
				end repeat
			end tell
			
			"importing cd..."
			-- import the audio cd
			tell application "iTunes"
				repeat with thisTrack in every audio CD track of source currentPlaylistName
					try
						convert thisTrack
					end try
				end repeat
			end tell
			
			"erasing optical disk..."
			do shell script ("/usr/sbin/diskutil eraseOptical " & opticalDisk)
			
			-- hit "OK" when the new cd mounts
			tell application "System Events"
				tell process "SystemUIServer"
					repeat while not (exists static text "You inserted a blank CD. Choose an action from the pop-up menu or click Ignore." of window 1)
						delay 0.05
					end repeat
					click button "OK" of window 1
				end tell
			end tell
			
			"incrementing playlist and starting loop again..."
			set currentPlaylistNum to currentPlaylistNum + 1
		end tell
	end tell
end repeat


-- ***************************************************************
-- ****** this code block deletes all the previously created temporary playlists ******
-- ***************************************************************
tell application "iTunes"
	repeat with thePlaylistToDelete in playlistList
		delete user playlist thePlaylistToDelete
	end repeat
end tell