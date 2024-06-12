#Requires AutoHotkey v2.0

set_ignore_applications() {
  GroupAdd "IgnoreApplications", "ahk_class CASCADIA_HOSTING_WINDOW_CLASS" ; Windows Terminal
  GroupAdd "IgnoreApplications", "ahk_exe Code.exe" ; Visual Studio Code
  GroupAdd "IgnoreApplications", "ahk_exe Cursor.exe" ; Cursor AI Editor
}

main() {
  ListLines 0

  SetControlDelay 0
  SetKeyDelay -1
  SetWinDelay 0
  SendMode "Input"

  set_ignore_applications()
}

main()
#UseHook

;; Set suspend toggle key "<ctrl>F1"
#SuspendExempt
^F1::Suspend
#SuspendExempt False

#HotIf not WinActive("ahk_group IgnoreApplications")

;
; <ctrl>b
; move cursor backward
;
^b:: Send "{Left}"

;
; <shift><ctrl>b
; move cursor backward selecting chars
;
+^b:: Send "+{Left}"

; <ctrl+f>
; Moves cursor one character to the right
^f::Send "{Right}"
^y::Send "^v"

; <shift+ctrl+f>
; Moves cursor one character to the right while selecting text
+^f::Send "+{Right}"

; <ctrl+p>
; Moves cursor one line up
^p::Send "{Up}"

; <shift+ctrl+p>
; Moves cursor one line up while selecting text
+^p::Send "+{Up}"

; <ctrl+n>
; Moves cursor one line down
^n::Send "{Down}"

; <shift+ctrl+n>
; Moves cursor one line down while selecting text
+^n::Send "+{Down}"

; <ctrl+d>
; Deletes the character to the right of the cursor
^d::Send "{Del}"

; <ctrl+h>
; Deletes the character to the left of the cursor (Backspace)
^h::Send "{BS}"

; <ctrl+a>
; Moves cursor to the beginning of the current line
^a::Send "{Home}"

; <shift+ctrl+a>
; Moves cursor to the beginning of the current line while selecting text
+^a::Send "+{Home}"

; <ctrl+e>
; Moves cursor to the end of the current line
^e::Send "{End}"

; <shift+ctrl+e>
; Moves cursor to the end of the current line while selecting text
+^e::Send "+{End}"

; <shift+alt+f>
; Moves cursor one word forward while selecting text
+!f::Send "+^{Right}"

; <ctrl+k>
; Deletes characters from the cursor to the end of the line
^k::
{
    Send "{ShiftDown}{End}{ShiftUp}"
    Sleep 50
    Send "^x"
    Return
}

#HotIf
