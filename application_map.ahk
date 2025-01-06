#Requires AutoHotkey v2.0
#include ./Lib/IMEv2.ahk

#HotIf WinActive("ahk_group windowsVim")

^v:: Send "^q"

#Hotif
