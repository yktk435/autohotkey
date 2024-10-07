#Requires AutoHotkey v2.0
#include ./Lib/IMEv2.ahk

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
^F1:: Suspend
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
^f:: Send "{Right}"
^y:: Send "^v"

; <shift+ctrl+f>
; Moves cursor one character to the right while selecting text
+^f:: Send "+{Right}"

; <ctrl+p>
; Moves cursor one line up
; ^p::Send "{Up}"

; <shift+ctrl+p>
; Moves cursor one line up while selecting text
+^p:: Send "+{Up}"

; <ctrl+n>
; Moves cursor one line down
^n:: Send "{Down}"

; <shift+ctrl+n>
; Moves cursor one line down while selecting text
+^n:: Send "+{Down}"

; <ctrl+d>
; Deletes the character to the right of the cursor
^d:: Send "{Del}"

; <ctrl+h>
; Deletes the character to the left of the cursor (Backspace)
^h:: Send "{BS}"

; <ctrl+a>
; Moves cursor to the beginning of the current line
^a:: Send "{Home}"

; <ctrl+e>
; Moves cursor to the end of the current line
^e:: Send "{End}"

; <shift+alt+f>
; Moves cursor one word forward while selecting text
+!f:: Send "+^{Right}"

; <ctrl+k>
; Deletes characters from the cursor to the end of the line
^k::
{
    ; MsgBox IME_GetConverting()
    Send "{ShiftDown}{End}{ShiftUp}"
    Sleep 50
    Send "^x"

    Return
}

#HotIf

*F13 up:: {
    if (A_PriorKey == "F13") { ; upイベントの中では、この条件で単体押しを検知できる
        IME_SET(0)
    }
}
*F14 up:: {
    if (A_PriorKey == "F14") { ; upイベントの中では、この条件で単体押しを検知できる
        IME_SET(1)
    }
}

^j:: Send "{Enter}"

ESC:: {
    Send "{ESC}"
    Sleep 50
    IME_SET(0)
}
^@:: {
    SendInput "{ESC}"
    Sleep 50
    SendInput "^["
    Sleep 50
    IME_SET(0)
}

^;:: Send "{F8}"
^h:: Send "{BS}"
^n:: Send "{Down}"
^p:: Send "{Up}"
; <ctrl + :>
; これをコメントアウトするとなぜか ' が ： になってしまう
LControl & sc028:: Send "{F10}"

#HotIf GetKeyState('F13', 'P')
+i:: SendInput "^+i"
+Down:: SendInput "^+{End}"
+Left:: SendInput "^+{Home}"
+Right:: SendInput "^+{End}"
+Up:: SendInput "+^{Home}"
+b:: SendInput "^+b"
+c:: SendInput "^+c"
+e:: SendInput "^+e"
+f:: SendInput "^+f"
+m:: SendInput "^+m"
+n:: SendInput "^+n"
+p:: SendInput "^+p"
+r:: SendInput "^+r"
+s:: SendInput "^+s"
+t:: SendInput "^+t"
+u:: SendInput "^+u"
+x:: SendInput "^+x"
+z:: SendInput "^y" ;進む
-:: SendInput "^-"
Down:: SendInput "^{Down}"
Left:: SendInput "{Home}"
Right:: SendInput "{End}"
Up:: SendInput "^{Up}"
^+;:: SendInput "^+;"
^v:: SendInput "#v"
a:: SendInput "^a"
b:: SendInput "^b"
c:: SendInput "^c"
f:: SendInput "^f"
l:: SendInput "^l"
m:: SendInput "^m"
n:: SendInput "^n"
p:: SendInput "^p"
s:: SendInput "^s"
t:: SendInput "^t"
v:: SendInput "^v"
w:: SendInput "^w"
x:: SendInput "^x"
z:: SendInput "^z"
#HotIf

; k up:: {
;     if (A_PriorKey == "j") { ; upイベントの中では、この条件で単体押しを検知できる
;         Send "{ESC}"
;         IME_SET(0)
;     }else{
;         send "k"
;     }
; }

^+Left:: Send "+{Left}"
^+Right:: Send "+{Right}"


; -----------------------------------------------------------
; macOS 単語移動操作風キーバインド
; Option+左右 の挙動を再現
; -----------------------------------------------------------

; 単語単位のカーソル操作
!Left:: SendInput "^{Left}"
!Right:: SendInput "^{Right}"
+!Left:: SendInput "^+{Left}"
+!Right:: SendInput "^+{Right}"
