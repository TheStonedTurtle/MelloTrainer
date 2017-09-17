# MelloTrainer
A FiveM (GTA5 Modded Multiplayer) Trainer Made by <a href="https://github.com/TheStonedTurtle">TheStonedTurtle</a>. This is a server-side trainer written in Lua with a NUI written with HTML, CSS, and JS.<br/>
<br/>



<h1>Installation</h1>
<ol>
<li>Drag and drop the <i>mellotrainer</i> folder into the resources folder of your server.</li>
<li>Add <i>start mellotrainer</i> to your server.cfg file.</li>
<li>Restart your server.</li>
</ol>

<h2>Note</h2>
As of v0.4.0, players are required to be logged into the Steam client in order for the new vehicle/skin save system to work.

<h1>Controls</h1>
<table>
<tbody>
<tr><th>Key</th><th>Action</th></tr>
<tr><td>F1</td><td>Open/Close the trainer</td></tr>
<tr><td>Arrow Keys</td><td>Move up,down,left, and right respectively.</td></tr>
<tr><td>Enter</td><td>Select the current trainer option</td></tr>
<tr><td>Backspace</td><td>Go back to the previous menu</td></tr>
<tr><td>F2</td><td>Toggle No-Clip Mode</td></tr>
<tr><td>F3</td><td>Teleport to Current Way Point</td></tr>
<tr><td>Z</td><td>Toggle Between Big & Small Minimap</td></tr>
</tbody>
</table>



<h2>No Clip Controls</h2>
<table>
<tbody>
<tr><th>Key</th><th>Action</th></tr>
<tr><td>F2</td><td>Toggle No-Clip Mode</td></tr>
<tr><td>Shift</td><td>Switch No-Clip Movement Speed</td></tr>
<tr><td>Q</td><td>Move Upwards</td></tr>
<tr><td>Z</td><td>Move Downwards</td></tr>
<tr><td>W</td><td>Move Forwards</td></tr>
<tr><td>S</td><td>Move Backwards</td></tr>
<tr><td>A</td><td>Rotate Left</td></tr>
<tr><td>D</td><td>Rotate Right</td></tr>
</tbody>
</table>


<h1>Features</h1>
<ul>
    <li>Admin Menu w/ Working Permissions</li>
    <li>Admin Only Trainer Options (Time/Weather, syncs with online players)</li>
    <li>General Settings (Map Blips, Player Blips, Overhead Names, etc)</li>
    <li>Online Players Menu w/ Spectate & Teleport Option</li>
    <li>Player Death Messages</li>
    <li>Player Join/Leave Notifications</li>
    <li>Player Skin Changing and Customization</li>
    <li>Player Skin Save & Load System</li>
    <li>Player Toggle Options (God Mode, ETC)</li>
    <li>Vehicle Spawning & Spawning Options</li>
    <li>Vehicle Customization and Modifications</li>
    <li>Vehicle Save & Load System</li>
    <li>Weapon Spawning</li>
    <li>Weapon Attachments/Infinite ammo</li>
    <li>Voice Overlay & Options (Proximity/Channel/Toggle)</li>
    <li>Noclip Abilities with Admin Only Toggle</li>
</ul>


<h1>Credits:</h1>
<ul>
<li><a href="https://github.com/pongo1231/ScorpionTrainer">Scorpion Trainer</a> for a lot of the basic NUI functionality & structure.</li>
<li><a href="https://github.com/citizenfx/project-lambdamenu">Lambda Menu</a> which I used to convert useful functionality from C++ to Lua.</li>
<li><a href="https://forum.fivem.net/t/release-simple-speedometer/7846">Simple Speedometer</a> for the speedometer used by the trainer. (Black Outline)</li>
<li><a href="https://forum.fivem.net/t/release-scammers-script-collection-09-03-17/3313">Player Blips</a> for the basic blip system.</li>
</ul>


<h1>Development Information:</h1>
This section is only intended for people with LUA experience and a basic understanding of JSON/HTML Attributes. The below information should be used to help understand what every attribute does and how to add new dynamic menus and option using them.

<h2>Trainer Option Attributes:</h2>

<table>
<tbody>
<tr><th>Attribute</th><th>Explanation</th></tr>
<tr><td>data-action</td><td>The action to callback to lua via a NUICallback. Space delimited values with the first value being the name of the NUICallback.</td></tr>
<tr><td>data-hover</td><td>Exact same as data-action but this triggers when they change to the option instead of selecting the option.</td></tr>
<tr><td>data-state</td><td>Holds a "ON"/"OFF" value for toggle options.</td></tr>
<tr><td>data-toggle</td><td>Global boolean lua variable to sync data-state with.</td></tr>
<tr><td>data-sub</td><td>ID of the new menu to show when selected.</td></tr>
<tr><td>data-share</td><td>Information to share with the sub menu action options.(won't do anything unless data-sub is also specified)</td></tr>
<tr><td>data-shareid</td><td>Updates the submenu ID to this if it exists. Useful for ensuring that a menu that is used my multiple different options will return to the correct place within the trainer.</td></tr>
<tr><td>data-require</td><td>Used for permission checks for <b>data-action</b> and <b>data-sub</b> events. See Below</td></tr>
</tbody>
</table>


<h2>Trainer Div Attributes:</h2>
<table>
<tbody>
<tr><th>Attribute</th><th>Explanation</th></tr>
<tr><td>data-container</td><td>Prevents this div from being turned into a menu by JS.</td></tr>
<tr><td>data-parent</td><td>The ID of the parent element so if they try to go back</td></tr>
<tr><td>data-staticmenu</td><td>A menu that will be created from static JSON by JS. This will require updating JS so it is recommended you use data-dynamicmenu instead.</td></tr>
<tr><td>data-dynamicmenu</td><td>Holds the name of the NUI Callback that will return a JSON object to populate the current menu with (includes sub menus). See JSON format below.</td></tr>
<tr><td>data-sharedinfo</td><td>Usually added by JS from the data-share attribute of the option. This information will be appended to the end of every data-action and data-hover when requested.</td></tr>
</tbody>
</table>



<h2>JSON/Table Format</h2>

```json
{
	"menuName": "Example Text",
	"data": {
		"action": "String",
		"sub": "String",
		"state": "String"
	},
	"submenu": []
}
```


<table>
<tbody>
<tr><th>Atribute</th><th>Explanation</th><tr>
<tr>
	<td>menuName</td>
	<td>The text to show in the menu</td>
</tr>
<tr>
	<td>data</td>
	<td>An object containg key value pairs for all data-* attributes to be added to new menu option</td>
</tr>
<tr>
	<td>submenu</td>
	<td>An Array of of objects that are formatted in the exact same way as the current object. Used for creating linked sub menus.</td>
</tr>


<h2>JSON Editing</h2>
I created a website hosted on my github.io pages for editing the Mello Trainer JSON. It is not the best website and may have performance issues but it accomplishes the required task. Please read the above JSON information before trying/asking questions about this editor.

<a href="https://thestonedturtle.github.io/mellotrainer/mellotrainer.html" target="_blank">TheStonedTurtle.github.io</a></li>


<h2>Custom Privileges</h2>
To create custom privileges within mello trainer using data-require you can follow the below template. This works for data-action and data-sub but does not support data-hover events. <i>Note: This can be done without triggering a server event.</i>

<h3>Client.lua</h3>
Add the below to any client lua file.


```
-- Request Cop Status
RegisterNUICallback("requirecop", function(data, cb)
    TriggerServerEvent("mellotrainer:requestCopStatus")
end)

-- Recieve Cop Status
RegisterNetEvent("mellotrainer:copstatus")
AddEventHandler("mellotrainer:copstatus", function(status)
    if(status)then
        SendNUIMessage({customprivilegecheck = true})
    else
        drawNotification("~r~Permission Denied!")
    end     
end)
```

<h3>Server.lua</h3>

Add the below to any server lua file.


```
RegisterServerEvent('mellotrainer:requestCopStatus')
AddEventHandler('mellotrainer:requestCopStatus', function(id) 
    local result = false
    
    -- Logic to check if they are a cop here

    TriggerClientEvent("mellotrainer:copstatus",source,result)
end)
```