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
^t:: {
    Send "{ESC}"
    Send "^t"
    Sleep 50
    IME_SET(0)
}
ESC:: {
    Send "{ESC}"
    Sleep 50
    IME_SET(0)
}
^@:: {
    Send "{ESC}"
    Send "^["
    Sleep 50
    IME_SET(0)
}
^;:: Send "{F8}"
; <ctrl + :>
LControl & sc028:: Send "{F10}"
#HotIf GetKeyState('F13', 'P')
c:: Send "^c"
v:: Send "^v"
p:: Send "^p"
+p:: Send "^+p"
l:: Send "^l"
a:: Send "^a"
b:: Send "^b"
+e:: Send "^+e"
+c:: Send "^+c"
+x:: Send "^+x"
+i:: Send "^+i"
+u:: Send "^+u"
+r:: Send "^+r"
+t:: Send "^+t"
+f:: Send "^+f"
w:: Send "^w"
#HotIf
