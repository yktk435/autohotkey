#Requires AutoHotkey v2.0

MsgBox "main reloaded!!"

KeyHistory

^!r:: Reload

; 診断用: アクティブウィンドウの class / exe を表示
^!w:: {
    cls := WinGetClass("A")
    exe := WinGetProcessName("A")
    title := WinGetTitle("A")
    inGroup := WinActive("ahk_group windowsVim") ? "YES" : "no"
    MsgBox "class: " cls "`nexe: " exe "`ntitle: " title "`nin windowsVim group: " inGroup
}

#include Lib/functions.ahk
#include Config/ahkGroup.ahk

#include window_size.ahk
#include us_keybord_map.ahk

#include emack_like.ahk
#include right_command.ahk
#include tab.ahk
#include application_map.ahk
