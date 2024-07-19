#Requires AutoHotkey v2.0

moveDisplay(direction) {
    ; アクティブウィンドウを取得
    activeWindow := WinGetID("A")
    MonitorGet A_Index, &L, &T, &R, &B
    MonitorGetWorkArea A_Index, &WL, &WT, &WR, &WB

    screenWidth := WR
    screenHeight := WB
    switch direction {
        case 's':
            newWidth := screenWidth // 2
            newHeight := screenHeight // 2
            newX := newWidth
            newY := 0
        case 'x':
            newWidth := screenWidth // 2
            newHeight := screenHeight // 2
            newX := newWidth
            newY := newHeight
        case 'z':
            newWidth := screenWidth // 2
            newHeight := screenHeight // 2
            newX := 0
            newY := newHeight
        case 'a':
            newWidth := screenWidth // 2
            newHeight := screenHeight // 2
            newX := 0
            newY := 0
        case 'e':
            newWidth := screenWidth
            newHeight := screenHeight
            newX := 0
            newY := 0
        case 'w':
            newWidth := screenWidth // 2
            newHeight := screenHeight
            newX := newWidth
            newY := 0
        case 'q':
            newWidth := screenWidth // 2
            newHeight := screenHeight
            newX := 0
            newY := 0
        case '0':
            newWidth := screenWidth * 2 // 3
            newHeight := screenHeight
            newX := screenWidth // 3
            newY := 0
        case '9':
            newWidth := screenWidth * 2 // 3
            newHeight := screenHeight
            newX := 0
            newY := 0
        default:
    }

    WinMove(newX, newY, newWidth, newHeight, activeWindow)
}
~^+e:: ; Ctrl + Alt + R のホットキー
{
    moveDisplay('e')
}
^+s:: ; Ctrl + Alt + R のホットキー
{
    moveDisplay('s')
}
^+a:: ; Ctrl + Alt + R のホットキー
{
    moveDisplay('a')
}
; ^+z:: ; Ctrl + Alt + R のホットキー
; {
;     moveDisplay('z')
; }
~^+x:: ; Ctrl + Alt + R のホットキー
{
    moveDisplay('x')
}
^+w:: ; Ctrl + Alt + R のホットキー
{
    moveDisplay('w')
}
^+q:: ; Ctrl + Alt + R のホットキー
{
    moveDisplay('q')
}
^+0:: ; Ctrl + Alt + R のホットキー
{
    moveDisplay('0')
}
^+9:: ; Ctrl + Alt + R のホットキー
{
    moveDisplay('9')
}
