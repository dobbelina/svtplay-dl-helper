;@Ahk2Exe-SetCopyright    Dobbelina
;@Ahk2Exe-SetDescription  svtplay-dl-helper
;@Ahk2Exe-SetFileVersion   1.0.0.0
;@Ahk2Exe-SetProductName   svtplay-dl-helper.exe
;@Ahk2Exe-SetProductVersion   1.0.0.0

#NoEnv
#Include PageUrl.ahk
SetBatchLines, -1
SetWorkingDir %A_ScriptDir%
IniName = svtplay-dl.ini

if !FileExist(IniName)
{
IniWrite, Path to executable name without quotes, %IniName%, Options, ProgramPath
IniWrite, Path to download folder also no quotes, %IniName%, Options, Outputfolder
IniWrite, p, %IniName%, Options, Shortcut
MsgBox Ini file in same diretory
ExitApp
}
IniRead, ProgramPath, svtplay-dl.ini, Options, ProgramPath
IniRead, Outputfolder, svtplay-dl.ini, Options, Outputfolder
IniRead, Shortcut, svtplay-dl.ini, Options, Shortcut
ProgramPath := chr(34) . ProgramPath . chr(34)
Outputfolder := chr(34) . Outputfolder . chr(34)

Progress,B2 fs18 c0 zh0  w350 h30 CW4e8af2 CTFFFFFF cbBlack,Download = Ctrl + %Shortcut% F4 To Exit ,, svtplay-dl-Notification
Fader()

Hotkey,^%Shortcut%,DoIt
Return

DoIt:
Progress,B2 fs16 c0 zh0  w350 h80 cbBlack,Press "1" Download Only`nPress "2" Download + Subs`nPress "3" Download + Subs Merge
Loop {
If (getKeyState("1", "P")) or (getKeyState("Numpad1", "P"))
gosub, Label1
else if (getKeyState("2", "P")) or (getKeyState("Numpad2", "P"))
gosub, Label2
else if (getKeyState("3", "P")) or (getKeyState("Numpad3", "P"))
gosub, Label3
Sleep 50
}
return

label1:
Progress, off
accData:= GetAccData() 
url := accData.2
Run, %ProgramPath% %url% -o %Outputfolder%
Exit

label2:
Progress, off
accData:= GetAccData() 
url := accData.2
Run, %ProgramPath% -S %url% -o %Outputfolder%
Exit

label3:
Progress, off
accData:= GetAccData() 
url := accData.2
Run, %ProgramPath% -S -M %url% -o %Outputfolder%
Exit

F4::
Progress,B2 fs18 c0 zh0  w290 h30 CW4e8af2 CTFFFFFF cbBlack,Closing Svtplay-dl Helper,, svtplay-dl-Notification
Fader()
ExitApp

Fader(){
Iterations =
 Loop, 7
{
 Iterations +=36.42
    WinSet, Transparent, %Iterations%, svtplay-dl-Notification
    Sleep, 60
}
WinSet, TransColor, Off, svtplay-dl-Notification
Sleep, 1215
 Loop, 7
{
 Iterations -= 36.42
    WinSet, Transparent, %Iterations%, svtplay-dl-Notification
    Sleep, 30
}
Progress, off
WinSet, TransColor, Off, svtplay-dl-Notification
return
}
