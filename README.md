RegJump  [![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](https://github.com/Yohanna/RegJump/blob/master/LICENSE)
=======

A simple Power Shell script to jump to a specific registry key.


## Usage

The script works by opening the registry editor with the reg key in the clipboard, so all you have to do is:
* copy the registry key and 
* open the bat file Run PS Script.

A batch file is used to launch the Power Shell script, since on many computers either running scripts (like Power Shell, VBscript, Javascript) is turned off or you would have to open the Power Shell terminal and manually run the PS script. That is two extra steps too many!

## How it works ?

By default the Windows Registry Editor remembers the last opened key by saving that key location in `HKCU\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit` in the `LastKey` key.

So all the script does is change `LastKey` value to a new location and then start the registry editor which would make it go to that key. Voilà.

