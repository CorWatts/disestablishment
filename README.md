# Disestablishment -- DRM Removal Script v2.0

Written in lovely Applescript
 
## Prerequisites:
- A CD-RW
- A playlist containing the protected tracks you wish to remove drm from

## Summary:
1. create a long list of playlists to burn, sourced from one master playlist  
-------- start loop ------------
2. burn playlist to cd
3. import cd
4. diskutil eraseOptical <optical disk>
5. iterate to next playlist  
-------- end loop -------------
6. delete list of playlists


## Instructions:
1. insert the CD-RW
2. put all your protected music into a single playlist, note the name of the playlist
3. change the originalPlaylist variable to be the name of your playlist
4. make sure the CD-RW is mounted and open terminal --> enter "diskutil list".
5. find the device with a size of 0B (hopefully that will be your optical disk! make
   sure!) and then enter the name of that device into the opticalDisk variable

  you can change playlistNameBase to whatever you like, just make sure it has a 
  completely unique name among your playlists


## Notice: 
**this has been tested with OS X 10.6.8 and iTunes 10.4.1**

I have no idea what other versions it might work on. Be careful 
when running this if your versions do not match up with mine.

As always, please only use this for music that you personally own. This script does not "crack" DRM, it simply removes it by burning it to a CD. Never steal music!
