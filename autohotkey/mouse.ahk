; Script para AutoHotkey - Remapeo inteligente del 4to botón del mouse
; Revit: Botón 4 = Shift
; InDesign: Botón 4 = Espacio
; Otras aplicaciones: Comportamiento normal

#Persistent
#SingleInstance force
; Hotkey: Ctrl+Alt+Space
#t::
	WinGet, ExStyle, ExStyle, A ; Get the Extended Style of the active window.
        If !(ExStyle & 0x00000080) ; Check if the window is NOT set to be on all desktops.
            WinSet, ExStyle, 0x00000080, A ; Make the active window visible on all desktops.
        Else ; If the window IS already on all desktops...
            WinSet, ExStyle, -0x00000080, A ; Remove the flag and make it appear only on the current desktop.
    Return

; Revit - Botón 4 como Shift
;#If WinActive("ahk_exe Revit.exe")
;	XButton1::
;        Send {Shift Down}
;        Sleep 10
;        Send {MButton Down}
;        Return
;
;    XButton1 Up::
;        Send {MButton Up}
;        Sleep 10
;        Send {Shift Up}
;		Return
;
;    XButton2::MButton
;#If

; Sketchup - Boton 4 como Shift
#If WinActive("ahk_exe Revit.exe")
    XButton1::
        SendInput {Shift Down}
        Sleep 30
        SendInput {MButton Down}
        Return

    XButton1 Up::
        SendInput {MButton Up}
        Sleep 30
        SendInput {Shift Up}
        Return

    XButton2::MButton
#If

; InDesign - Botón 4 como Barra Espaciadora
#If WinActive("ahk_exe InDesign.exe")
 XButton1::
        Send {Space Down}
        Sleep 20
        Send {LButton Down}
        KeyWait, XButton1
        Return
        
    XButton1 Up::
        Send {LButton Up}
        Sleep 10
        Send {Space Up}
    Return
    XButton2::Send {Alt Down}
    XButton2 Up::Send {Alt Up}
#If

; Opcional: Restaurar función original en otras aplicaciones
#If !(WinActive("ahk_exe Revit.exe") || WinActive("ahk_exe InDesign.exe"))
    XButton1::Send {Control Down}
    XButton1 Up::Send {Control Up}
    XButton2::Send {Alt Down}
    XButton2 Up::Send {Alt Up}
    ; El botón mantiene su función predeterminada
    ; (No es necesario agregar código aquí)
#If
