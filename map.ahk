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
