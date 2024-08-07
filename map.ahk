#Requires AutoHotkey v2.0
#include ./Lib/IMEv2.ahk

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
; ^t:: {
;     Send "{ESC}^t"
;     IME_SET(0)
; }
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
+c:: Send "^+c"
+e:: Send "^+e"
+f:: Send "^+f"
+i:: Send "^+i"
+p:: Send "^+p"
+r:: Send "^+r"
+s:: Send "^+s"
+t:: Send "^+t"
+u:: Send "^+u"
+x:: Send "^+x"
+z:: Send "^+z"
^v:: Send "#v"
a:: Send "^a"
b:: Send "^b"
c:: Send "^c"
f:: Send "^f"
l:: Send "^l"
n:: Send "^n"
p:: Send "^p"
s:: Send "^s"
t:: Send "^t"
v:: Send "^v"
w:: Send "^w"
x:: Send "^x"
z:: Send "^z"
Right:: Send "{End}"
Left:: Send "{Home}"
#HotIf

; k up:: {
;     if (A_PriorKey == "j") { ; upイベントの中では、この条件で単体押しを検知できる
;         Send "{ESC}"
;         IME_SET(0)
;     }else{
;         send "k"
;     }
; }
