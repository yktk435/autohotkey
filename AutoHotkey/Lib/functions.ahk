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

searchArray(val, arr) {
    Loop arr.Length {
        if (arr[A_Index] == val)
            return A_Index
    }

    return false
}

inArray(value, array) {
    Loop array.Length {
        if (array[A_Index] == value)
            return true
    }

    return false
}
