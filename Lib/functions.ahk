#Requires AutoHotkey v2.0


reverseArray(oArray)
{
    if (oArray.length == 0) {
        return []
    }
    Array := []
    For i, v in oArray {
        Array.Push(oArray[oArray.Length - i + 1])
    }


    return Array
}

_searchArray(value, array, isInArray := false) {
    Loop array.Length {
        if (array[A_Index] == value)
            if (isInArray) {
                return true
            } else {
                return A_Index
            }
    }

    return false
}

searchArray(value, array) {
    return _searchArray(value, array)
}

inArray(value, array) {
    return _searchArray(value, array, true)
}

isApplication(winId) {
    return WinGetTitle(winId) != '' && !inArray(WinGetClass(winId), ['IME', 'MSCTFIME UI'])
}

logger(text) {
    logTime := "[" FormatTime(, "yyyy-MM-dd HH:mm:ss") "]"

    FileAppend logTime " " text "`n",  "\\wsl.localhost\Docker\home\h1yokotsuka\ghq\AutoHotkey\log"
}
