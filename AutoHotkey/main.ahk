#Requires AutoHotkey v2.0

MsgBox "main reloaded!!"
KeyHistory

^!r::Reload

#include Lib/functions.ahk

#include window_size.ahk
#include us_keybord_map.ahk
#include map.ahk

#include emack_like.ahk
#include right_command.ahk
#include tab.ahk
