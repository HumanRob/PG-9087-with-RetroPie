# [How to] Get the IPEGA PG-9087 bluetooth controller working with RetroPie
The IPEGA PG-9087, also known as the Red Knight / Red Samurai, is a fairly cheap bluetooth controller (can be found on eBay for around £15). It's one of those retractable control pads that can clamp around a handheld device (in my case an Android phone) to make a Nintendo Switch style handheld gaming console. It also works quite well as a standalone controller, but I couldn't get mine to work with RetroPie out of the box. After lots of trial and error and trying out things on this forum I've got it working perfectly. Thought I'd share how I got it to work here in case someone has similar issues with this controller or a similar model. 
# Step 1: Pairing the controller with RetroPie
This part is pretty straightforward. Put the device into pairing mode and pair it from the Bluetooth option of the RetroPie menu in emulationstation. After this the device works in the bluetooth menu, but frustratingly, not in emulationstation!
# Step 2: Getting the controller to work with emulation station
Here you're adding a rule to tell the pi how it should communicate with the controller (I think!!). There are 2 ways of doing this.

Option 1: Create the rules file yourself. This is best if you have a slightly different controller name to mine, or if it's difficult to copy a file over to /etc/udev/rules.d/
1.) At the main screen, press F4 to drop to the command line (or SSH in using putty)
2.) Type "sudo nano /etc/udev/rules.d/55-local.rules" to create a new udev rule file containing the following entry:
SUBSYSTEM=="input", ATTRS{name}=="PG-9087", MODE="0666", ENV{ID_INPUT_JOYSTICK}="1"
... if you have a controller with a different name, substitute PG-9087 for the name of your controller as it appeared when pairing your device in the step above
3.) Press CTRL+X and save the changes
4.) Exit the command line by typing "reboot" or "exit"
... now the controller will work in emulationstation but not RetroArch!

Option 2: Copy my [55-local.rules](55-local.rules) file to /etc/udev/rules.d/ on the pi

Credit for this goes to the following posts, which accomplished similar things with different controllers:
https://www.amazon.com/gp/customer-reviews/R3GVRHP307ROSX/ref=cm_cr_arp_d_rvw_ttl?ie=UTF8&ASIN=B01N8WWOE5

https://retropie.org.uk/forum/topic/14661/beboncool-controller-bluetooth-issues/13

# Step 3: Getting the controller to work in RetroArch.
￼Launch retroarch and you should hopefully see that the direction pad works but none of the buttons do. To fix this we need to edit the file:
/opt/retropie/configs/all/retroarch-joypads/PG-9087.cfg (which should be automatically created, if not try launch a game via retroarch and check again)
... and tell retroarch what to map each button to. There are 2 ways to do this:

Option 1: Follow meleu's excellent post here:
https://retropie.org.uk/forum/topic/2719/keyboard-stopped-working-after-i-played-around-in-the-controller-config-in-rtgui/3
... to map the controls yourself in retropie and then copy the values to PG-9087.cfg. This option is best if you're trying this on a different controller or option 2 didn't give the results you wanted

Option 2: copy the content of my [PG-9087.cfg](PG-9087.cfg) file into your own file

... after this restart, connect the controller and it should work perfectly!

# Bonus Step 4: script to automatically re-pair and connect to the controller.
I also use this controller with my android phone, and I found that after I'd used it with my phone it wouldn't connect to my raspberry pi. I found the only way to fix this was to remove the device via the RetroPie bluetooth menu and pair it again, which was a big hassle. To avoid this I created an .sh script file which does all this for me. If I find that the controller isn't connecting I run this script and it connects straight away (I execute the script via SSH on my phone but you could include it at startup or anywhere you like). The script can be found in the file [bluetoothpair.sh](bluetoothpair.sh) . You must replace the mac address with the mac address of your own device, which you can find in RetroPie's bluetooth menu.
