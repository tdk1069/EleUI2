# EleUI2
Brax's Elephant Mud UI

The best way to Fresh install this is to : 
1. Log out of Ele if you are logged in.
2. Restart Mudlet if you already have it loaded
3. Start a new profile and select Offline
4. Install EleUI2
5. Connect to ele
6. type 'ui config' to choose and move which elements you want shown around.

To Upgrade:
**note** As of v1.53, *ui upgrade* will check here for updates, download and install if available (If you have made any code tweaks they will get lost so backup!) 
Older than v1.53:
1. Load your profile offline.
2. Uninstall EleUI2 via the package manager
3. Install the new release via the package manager
4. connect!

Default Predefined Alias's 
**ui config** - This shows the config window where you can select which elements are visible
**ui installmap** - this loads (and replaces if you already have one!) a basic map

First release. Expect bugs :) i've done my best to get something usable together.

Body values can drift in combat. This is a GMCP issue, Bug has been raised on ele :) 

Example of the my current layout:
![alt text](https://raw.githubusercontent.com/tdk1069/EleUI2/master/EleUI2.png "Sample layout")

It's probably a good idea to untick "info" in the map window, and set the room/line/zoom to scales you like.

This UI uses AnimatedTimers,Drag and Drop framework, ECMO tab's for chat.
