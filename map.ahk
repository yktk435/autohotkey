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
-:: SendInput "^-"
^+;:: SendInput "^+;"
+Down:: Send "+^{Down}"
+Up:: Send "+^{Up}"
+b:: Send "^+b"
+c:: Send "^+c"
+e:: Send "^+e"
+f:: Send "^+f"
+i:: Send "^+i"
+p:: Send "^+p"
+r:: Send "^+r"
+t:: Send "^+t"
+u:: Send "^+u"
+n:: Send "^+n"
+x:: Send "^+x"
+z:: Send "^y" ;進む
Down:: Send "^{Down}"
Left:: Send "{Home}"
Right:: Send "{End}"
Up:: Send "^{Up}"
^v:: Send "#v"
a:: Send "^a"
b:: Send "^b"
c:: Send "^c"
f:: Send "^f"
l:: Send "^l"
n:: Send "^n"
p:: Send "^p"
s:: Send "^s"
+s:: Send "^+s"
t:: Send "^t"
v:: Send "^v"
m:: Send "^m"
w:: Send "^w"
x:: Send "^x"
z:: Send "^z"
+Left:: SendInput "^+{Home}"
+Right:: SendInput "^+{End}"
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
