' windows-time-voice makes Windows tell you the current time.
'
' Copyright (c) 2018, Mnheia <mnheia@gmail.com>
'
' This module is free software; you can redistribute it and/or modify it
' under the terms of GNU general public license (gpl) version 3.
' See the LICENSE file for details.

' Configuration
Language = "en"       ' en, de, ru, es, fr, zh
Use24Hour = False

Set Sapi = WScript.CreateObject("SAPI.SpVoice")
SetVoice Sapi, Language

Select Case LCase(Language)
    Case "de"
        timeText = "Es ist jetzt"
    Case "ru"
        timeText = U("\u0421\u0435\u0439\u0447\u0430\u0441")
    Case "es"
        timeText = "Ahora son las"
    Case "fr"
        timeText = "Il est"
    Case "zh"
        timeText = U("\u73B0\u5728\u662F")
    Case Else
        timeText = "It is now"
End Select

Sapi.Speak timeText
SpeakCurrentTime Sapi, Use24Hour, Language

If Hour(Time) = 16 Then
    Select Case LCase(Language)
        Case "de"
            Sapi.Speak "Zeit, nach Hause zu gehen."
        Case "ru"
            Sapi.Speak U("\u0412\u0440\u0435\u043C\u044F \u0438\u0434\u0442\u0438 \u0434\u043E\u043C\u043E\u0439.")
        Case "es"
            Sapi.Speak "Hora de ir a casa."
        Case "fr"
            Sapi.Speak "Il est temps de rentrer."
        Case "zh"
            Sapi.Speak U("\u8BE5\u56DE\u5BB6\u4E86\u3002")
        Case Else
            Sapi.Speak "Time to go home."
    End Select
End If

Sub SpeakCurrentTime(Sapi, Use24Hour, Language)
    h = Hour(Time)
    m = Minute(Time)

    If Use24Hour Then
        Sapi.Speak CStr(h)
        If m < 10 Then Sapi.Speak "0"
        Sapi.Speak CStr(m)
    Else
        displayHour = h Mod 12
        If displayHour = 0 Then displayHour = 12

        Sapi.Speak CStr(displayHour)

        If m > 0 Then
            If m < 10 Then Sapi.Speak "0"
            Sapi.Speak CStr(m)
        End If

        Select Case LCase(Language)
            Case "de"
                If h < 12 Then marker = "vormittags" Else marker = "nachmittags"
            Case "ru"
                If h < 12 Then marker = U("\u0443\u0442\u0440\u0430") Else marker = U("\u0434\u043D\u044F")
            Case "es"
                If h < 12 Then marker = U("de la ma\u00F1ana") Else marker = "de la tarde"
            Case "fr"
                If h < 12 Then marker = "du matin" Else marker = U("de l'apr\u00E8s-midi")
            Case "zh"
                If h < 12 Then marker = U("\u4E0A\u5348") Else marker = U("\u4E0B\u5348")
            Case Else
                If h < 12 Then marker = "A.M." Else marker = "P.M."
        End Select

        Sapi.Speak marker
    End If
End Sub

Sub SetVoice(Sapi, ByRef Language)
    Select Case LCase(Language)
        Case "de"
            languageId = "407"
        Case "ru"
            languageId = "419"
        Case "es"
            languageId = "40A"
        Case "fr"
            languageId = "40C"
        Case "zh"
            languageId = "804"
        Case Else
            Language = "en"
            languageId = "409"
    End Select

    Set voices = Sapi.GetVoices("Language=" & languageId)

    If voices.Count > 0 Then
        Set Sapi.Voice = voices.Item(0)
    Else
        Language = "en"
        Set voices = Sapi.GetVoices("Language=409")
        If voices.Count > 0 Then Set Sapi.Voice = voices.Item(0)
    End If
End Sub

Function U(text)
    result = ""

    Do While Len(text) > 0
        pos = InStr(text, "\u")

        If pos = 0 Then
            result = result & text
            Exit Do
        End If

        result = result & Left(text, pos - 1)
        result = result & ChrW(CLng("&H" & Mid(text, pos + 2, 4)))
        text = Mid(text, pos + 6)
    Loop

    U = result
End Function
