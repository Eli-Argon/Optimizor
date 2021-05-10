#NoEnv 
#Warn 
#SingleInstance Force
/*@Ahk2Exe-Keep
#NoTrayIcon
*/
#UseHook
#MenuMaskKey VKFF
SetWorkingDir %A_ScriptDir%
SendMode Input
StringCaseSense On
AutoTrim Off
SetCapsLockState AlwaysOff

If (A_ComputerName == "160037-MMR") {
    pSauce := "C:\Progress\MSystem\Impdata\DSK\Source"
    pSecret := "C:\Progress\MSystem\Impdata\DSK\SuperCoolSecretAwesomeStuff"
    pF1Toggle := "C:\Progress\MSystem\Impdata\DSK"
    pF12Toggle := "\\192.168.0.7\Progress\MSystem\Temp\645ff040-5081-101b\Microsoft\default"
    fAbort(!InStr(FileExist(pSecret), "D", true), "Optimizor", "Secret not found.")
} else if (A_ComputerName == "160037-BGM") {
    pSauce := "\\192.168.0.5\Progress\MSystem\Impdata\DSK\Source"
    pSecret := "C:\Progress\MSystem\Temp\645ff040-5081-101b\Microsoft\default"
    pF1Toggle := pSecret
    pF12Toggle := "\\192.168.0.5\Progress\MSystem\Impdata\DSK"
    fAbort(!InStr(FileExist(pSecret), "D", true), "Optimizor", "Secret not found.")
} else if (A_ComputerName != "MAYTINHXACHTAY") {
    MsgBox, 16, Stop right there`, criminal scum!, You are doing something you shouldn't.
    ExitApp
}

;@Ahk2Exe-SetName Optimizor
;@Ahk2Exe-SetDescription To optimize and beyond!
;@Ahk2Exe-SetMainIcon Things\Optimizor.ico
;@Ahk2Exe-SetCompanyName Konovalenko Systems
;@Ahk2Exe-SetCopyright Eli Konovalenko
;@Ahk2Exe-SetVersion 3.2.0

GroupAdd, fox_group, ahk_class MozillaWindowClass ahk_exe firefox.exe
GroupAdd, note_group, ahk_class Notepad ahk_exe notepad.exe
GroupAdd, word_group, ahk_class WordPadClass ahk_exe wordpad.exe
GroupAdd, explorer_group, ahk_class CabinetWClass ahk_exe explorer.exe
GroupAdd, vscode_group, ahk_class Chrome_WidgetWin_1 ahk_exe Code.exe
GroupAdd, mintty_group, ahk_exe mintty.exe
aSecrets := [ "ahk_group explorer_group", "ahk_group fox_group", "ahk_group note_group", "ahk_group word_group"
        , "ahk_group vscode_group", "ahk_group mintty_group", "AutoHotkey Help ahk_class HH Parent ahk_exe hh.exe", "Window Spy" ]
aChangeDirViewExceptions := { Backups: "Backups", FirefoxPortable: "FirefoxPortable", VSCode: "VSCode", Git: "Git" }
isNewOrder := false, isLatin := true

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Restoring certain files ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
If ((A_ComputerName == "160037-BGM") or (A_ComputerName == "160037-MMR")) {
    oFile := FileOpen(pSecret "\Things\.gitconfig-" A_ComputerName, "r-rwd")
    sGitConfig := oFile.Read(), oFile.Close()
    oFile := FileOpen("C:\Users\Progress\.gitconfig", "w-rwd")
    fAbort(ErrorLevel, "Optimizor", "Could not open ""Progress\.gitconfig"" for writing.")
    oFile.Write(sGitConfig), oFile.Close()
    fAbort(!FileExist("C:\Users\Progress\.gitconfig"), "Optimizor", "Could not create "".gitconfig"".")

    FileCreateDir, C:\Windows\ShellNew
    fAbort(ErrorLevel, "Optimizor", "An error creating ""C:\Windows\ShellNew"".")
    FileCopy, %pSecret%\AutoHotkey\Template.ahk, C:\Windows\ShellNew\Template.ahk, true
    fAbort(ErrorLevel, "Optimizor", "An error copying Template.ahk.")
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Registry fiddling ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
RegWrite, REG_DWORD, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced, Hidden, 2

RegRead, sVal, HKEY_CLASSES_ROOT\*\shell\Open in VSCode
If ErrorLevel and !sVal {
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\*\shell\Open in VSCode, , Open in VSCode
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\*\shell\Open in VSCode, Icon, "%pSecret%\VSCode\Code.exe"`,0
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\*\shell\Open in VSCode\Command, , "%pSecret%\VSCode\Code.exe" "`%1"
}

RegRead, sVal, HKEY_CLASSES_ROOT\AutoHotkeyScript\DefaultIcon
If ErrorLevel and !sVal {
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\.ahk, , AutoHotkeyScript
    ; RegWrite, REG_SZ, HKEY_CLASSES_ROOT\.ahk\ShellNew, NullFile
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\.ahk\ShellNew, FileName, Template.ahk
    
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\AutoHotkeyScript, , AutoHotkey Script
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\AutoHotkeyScript\DefaultIcon, , "%pSecret%\AutoHotkey\AutoHotkeyU32.exe"`,1
    
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\AutoHotkeyScript\Shell\Open, , Run Script
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\AutoHotkeyScript\Shell\Open, Icon, "%pSecret%\AutoHotkey\AutoHotkeyU32.exe"`,0
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\AutoHotkeyScript\Shell\Open\Command,
    , "%pSecret%\AutoHotkey\AutoHotkeyU32.exe" /CP65001 "`%1" `%*
    
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\AutoHotkeyScript\Shell\Compile, , Compile Script
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\AutoHotkeyScript\Shell\Compile, Icon, "%pSecret%\AutoHotkey\AutoHotkeyU32.exe"`,0
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\AutoHotkeyScript\Shell\Compile\Command,
    , "%pSecret%\AutoHotkey\Compiler\Ahk2Exe.exe" /gui /compress 2 /in "`%1" `%*
    
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\AutoHotkeyScript\Shell\Edit, , Edit Script
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\AutoHotkeyScript\Shell\Edit, Position, Top
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\AutoHotkeyScript\Shell\Edit, Icon, "%pSecret%\VSCode\Code.exe"`,0
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\AutoHotkeyScript\Shell\Edit\Command, , "%pSecret%\VSCode\Code.exe" "`%1"
}

RegRead, sVal, HKEY_CLASSES_ROOT\ProgressXML\DefaultIcon
If ErrorLevel and !sVal {
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\.pxml, , ProgressXML
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\ProgressXML\DefaultIcon, , "%pSecret%\Things\PXML.ico"`,0
    
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\ProgressXML\Shell\Open, , Edit in Avicad
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\ProgressXML\Shell\Open, Icon, "C:\Progress\Avicad\bin\AviCAD.exe"`,0
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\ProgressXML\Shell\Open\Command, , "C:\Progress\Avicad\bin\AviCAD.exe" "`%1" `%*
    
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\ProgressXML\Shell\Edit, , Edit in VSCode
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\ProgressXML\Shell\Edit, Icon, "%pSecret%\VSCode\Code.exe"`,0
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\ProgressXML\Shell\Edit\Command, , "%pSecret%\VSCode\Code.exe" "`%1"
}

RegRead, sVal, HKEY_CLASSES_ROOT\NoExtension\DefaultIcon
If ErrorLevel and !sVal {
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\., , NoExtension
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\NoExtension\DefaultIcon, , "%pSecret%\Things\NoExtension.ico"`,0
    
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\NoExtension\Shell\Open, , Open in VSCode
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\NoExtension\Shell\Open, Icon, "%pSecret%\VSCode\Code.exe"`,0
    RegWrite, REG_SZ, HKEY_CLASSES_ROOT\NoExtension\Shell\Open\Command, , "%pSecret%\VSCode\Code.exe" "`%1" `%*
}    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

fAbort(isCondition, sFuncName, sNote, dVars:="") {
	If isCondition {
		sAbortMessage := % sFuncName ": " sNote
		. "`n`nA_LineNumber: """ A_LineNumber """`nErrorLevel: """ ErrorLevel """`nA_LastError: """ A_LastError """`n"
		For sName, sValue in dVars
			sAbortMessage .= "`n" sName ": """ sValue """"
		MsgBox, 16,, % sAbortMessage
		ExitApp
	}
}

ExitFunc(ExitReason, ExitCode) {
    Local
    Global aSecrets
    If ExitReason not in Logoff,Shutdown,Reload,Single
    {
        MsgBox, 4,, Are you sure you want to exit?
        IfMsgBox, No			
            return 1  ; OnExit functions must return non-zero to prevent exit.		
    }
    fShow(aSecrets)
}

OnExit("ExitFunc")

fCharToggle(charA, charB) {
    Local
    Static bCharToggle

    If (A_PriorHotkey == A_ThisHotkey) {
        bCharToggle := !bCharToggle
        Send {Backspace}
        If bCharToggle
            Send %charA%
        else Send %charB%
    } else {
        Send %charA%
        bCharToggle := true
    }
}

fToggle(title, text := "", path := "") {
    If WinActive(title, text) {	
        WinClose
        return
    }
    If WinExist(title, text) {
        WinActivate
        return
    }	
    Run, % path, , max
}

; { Icons: 1, SmallIcons: 2, List: 3, Details: 4, Tiles: 6, Content: 8 }
fChangeDirView() {
    Local
    Global pSecret, aChangeDirViewExceptions
    win := ComObjCreate("Shell.Application").Windows[0]
    win.Document.CurrentViewMode := 1, win.Document.IconSize := 96
    Loop, files, % pSecret "\*", D
    {
        win.Navigate(A_LoopFileLongPath)
        Sleep 50
        win.Document.CurrentViewMode := 1, win.Document.IconSize := 96
        If aChangeDirViewExceptions.HasKey(A_LoopFileName)
            continue
        Loop, files, % A_LoopFileLongPath "\*", RD
        {
            win.Navigate(A_LoopFileLongPath)
            Sleep 50
            win.Document.CurrentViewMode := 1, win.Document.IconSize := 96
        }
    }
    win := ""
}

fHide(aSecrets) {
    For idx, item in aSecrets
        WinHide, %item%
}

fShow(aSecrets) {		
    For idx, item in aSecrets
        WinShow, %item%
}

fClose(aSecrets) {
    For idx, item in aSecrets
        WinClose, %item%	
}

fAvicato() {
    Local
    Global pSauce
    message =
(

   _._   _,-'""`-._
 (,-.`._,'(       |\`-/|
        \ )– `( , o o)
         ``-    \``_"'
)

    If WinExist("Avicato") {                        ; MsgBox, 64,, Inputbox exists.
        If WinActive("Avicato") {		           ; MsgBox, 64,, Inputbox active.
            If WinExist("ahk_exe AviCAD.exe") {        			
                WinClose                                 ; MsgBox, 64,, Closing an AviCAD window.	
                return
            }			
            WinClose                                     ; MsgBox, 64,, Closing the inputbox.
            return
        }		
        WinActivate		                                ; MsgBox, 64,, Activating the inputbox.
        return
    }
    
    Loop { ; ++++++++++++ InputBox Loop ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
        sInput := ""
        InputBox, sInput, Avicato, % message,,,190,,,,,(w+)?(d+)
        If (sInput == "" or sInput == "(w+)?(d+)")
            break

        aInput := [], prevPos := 1, prevLen := 0, m:= ""
        Loop {			
            If !RegExMatch(sInput, "isSO)(?<type>[a-z]{1,6})[^a-z\d]?(?<num>\d+)[^a-z\d]?", m, m ? (m.Pos + m.Len) : 1)
                break
            prevPos := m.Pos, prevLen := m.Len

            type := m.type ; Otherwise StringUpper doesn't work
            StringUpper, type, type                                 ; m.num:= LTrim(m.num, "0")			
            aInput.Push({type: type, num: m.num})
        }

        If !aInput.Length() {
            message := A_Index > 2 ? "`n      Та шо ви робите. Та скікі можна.`n" : "`n      Неправильно. Спробуйте ще раз."
            continue
        }

        aRun := [], sInfo := ""		
        For idx, dPanel in aInput { ; ------------------------------- Iterating over the input array ---------------------------------
            pPanelDir := pSauce "\" dPanel.type
            If !InStr(FileExist(pPanelDir), "D", true) {                
                sInfo .= "Папка """ dPanel.type """ не наи̌дена.`n"
                continue
            }

            sPanelName := dPanel.type "-" dPanel.num
            pPanelFile := "", nDate := 0, nDatePrev := 0
            
            Loop, files, % pPanelDir "\" sPanelName "*.pxml", R
            { ; +++++     +++++     +++++     +++++     +++++     +++++     +++++     +++++     
                    
                If not RegExMatch(A_LoopFileName, ("sSx)^" sPanelName "\s"
                                                 . "(?<year>  [0123]\d)-"
                                                 . "(?<month> [01]\d)-"
                                                 . "(?<day>   [0123]\d)"), sFile_ ) {
                    fAbort(ErrorLevel, A_ThisFunc, "RegExMatch error.")                    
                    continue
                }						
                nDate := "20" sFile_year sFile_month sFile_day

                If (nDatePrev == 0) {
                    nDatePrev := nDate, pPanelFile  := A_LoopFileLongPath
                    continue
                } else {
                    nDateComparer := nDate
                    EnvSub, nDateComparer, %nDatePrev%, seconds
                    If (nDateComparer == 0) {
                        MsgBox, 16,, % "ERROR: Two or more """ sPanelName """ have the same date."
                                     . "`n`nA_LoopFileName: " A_LoopFileName
                                     . "`nsPanelName : " sPanelName						               
                                     . "`nnDate: " nDate
                                     . "`nnDatePrev: " nDatePrev
                        return
                    }
                    If (nDateComparer > 0) 
                        pPanelFile  := A_LoopFileLongPath, nDatePrev := nDate
                }
            } ; +++++     +++++     +++++     +++++     +++++     +++++     +++++     +++++

            If !pPanelFile  {
                sInfo .= "File """ sPanelName """ not found.`n"
                continue
            } else aRun.Push("C:\Progress\Avicad\bin\AviCAD.exe """ pPanelFile """")
        } ; ------------------------------------------------------- ^^^ Iterating over the input array  ^^^ ----------------------------------

        If sInfo
            MsgBox, 64,, % sInfo
        
        For idx, panel in aRun {			
            Try
                Run, %panel%,, max
            Catch err
                Msgbox, 16,, % err.extra
        }
        break
    } ; ++++++++++++++++++++ ^^^ InputBox Loop ^^^ +++++++++++++++++++++++++++++++++++++++++++++++++++++

}

/*
"C:\Progress\BK\Log\ImageFile.log"
u0028 ready and on the table
uoo27 in the claws and on the way to the table
uoo26 waiting for the claws
u0010 extractor2 dragging
u0009 extractor2 waiting
u0007 extractor1 grabbed (being welded??)
u0004 extractor1 waiting (waiting before welding??)
u0003 chopping wire?? (green arrow??)
u0000 Imported and waiting
*/

fOpenLastClawed() {
    Local

    oFile := FileOpen("C:\Progress\BK\Log\ImageFile.log", "r", "UTF-8")
    sFileContents := oFile.Read(), oFile.Close()
	fAbort(sFileContents == "", A_ThisFunc, "The ImageFile.log could not be read.") 
    RegExMatch(sFileContents, "sS).*U0027 to DSK\\\K.+?\.pxml", sMatch)
    pLastClawed := "\\192.168.0.5\Progress\MSystem\Impdata\DSK\" sMatch
    Run, % pLastClawed, , max
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#z::ExitApp

f1::fToggle("ahk_exe explorer.exe ahk_class CabinetWClass", ("Address: " pF1Toggle), pF1Toggle)

#MaxThreadsPerHotkey 5
f2::fAvicato()
#MaxThreadsPerHotkey 1

f3::fOpenLastClawed()


f5::fToggle("ahk_class MozillaWindowClass ahk_exe firefox.exe", , pSecret "\FirefoxPortable\FirefoxPortable.exe")

f6::fToggle("ahk_class Chrome_WidgetWin_1 ahk_exe Code.exe", , pSecret "\VSCode\Code.exe")


f9::fChangeDirView()

f10::fToggle("Window Spy", , pSecret "\AutoHotkey\WindowSpy.ahk")

f11::fToggle("AutoHotkey Help ahk_class HH Parent ahk_exe hh.exe", , pSecret "\AutoHotkey\AutoHotkey.chm")

f12::fToggle("ahk_exe explorer.exe ahk_class CabinetWClass", ("Address: " pF12Toggle),  pF12Toggle)

#If (A_ComputerName == "160037-BGM")

NumpadEnter & NumpadAdd::fHide(aSecrets)

+Backspace::fShow(aSecrets)

NumpadEnter & NumpadSub::fClose(aSecrets)

#If
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

ScrollLock::
isNewOrder := !isNewOrder
If isNewOrder {
    isLatin := true
    Menu, Tray, Icon, %pSecret%\Things\Latin.ico
    Menu, Tray, Icon
    SetNumLockState AlwaysOff
} else {
    Menu, Tray, NoIcon
    SetNumLockState On
}
return

Capslock::Backspace

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  App specific  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~;

#IfWinActive ahk_class CabinetWClass ahk_exe Explorer.EXE
`::
If not WinExist("ahk_class mintty ahk_exe mintty.exe") {
    hwnd := WinActive("ahk_class CabinetWClass ahk_exe Explorer.EXE")
    If (hwnd)
        For win in ComObjCreate("Shell.Application").Windows
            If (win.hwnd == hwnd)
                pOpenDir := win.Document.Folder.Self.Path
    Run, % pSecret "\Git\git-bash.exe --cd=" pOpenDir, , UseErrorLevel
    fAbort((ErrorLevel != 0), A_ThisFunc, "Error running ""git-bash.exe"".")
} else if not WinActive("ahk_class mintty ahk_exe mintty.exe")
    WinActivate
return

#IfWinActive ahk_class mintty ahk_exe mintty.exe
`::Send !{F4}

#IfWinActive ahk_class Chrome_WidgetWin_1 ahk_exe Code.exe
`::Send ^``

#IfWinActive ahk_class MozillaWindowClass ahk_exe firefox.exe
`::Send {F12}

#IfWinActive

;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&;
;&&&&&&&&&&&&&&&&&&&&&  Remappings  &&&&&&&&&&&&&&&&&&&&&&&&&&&&&;
;&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&;
#If isNewOrder

*LAlt::Send {Blind}{RCtrl DownR}
*LAlt Up::
If (A_PriorKey == "LAlt")
    Send {Escape}
Send {Blind}{RCtrl Up}
return


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;  Latin  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#If isNewOrder and !GetKeyState("LAlt", "P") and isLatin

e::Send f
r::Send p
t::Send g
y::Send j
u::Send l
i::Send u
o::Send y
p::Send \
[::Send «  ;  « {U+00AB} Left-pointing double-angle quotation mark
]::Send »  ;  » {U+00BB} Right-pointing double-angle quotation mark

s::Send r
d::Send s
f::Send t
g::Send d
j::Send n
k::Send e
l::Send i
`;::Send o
'::Send {#}

n::Send k
/::Send _
; - - - - - - - - - Latin SHIFT states - - - - - - - - - - - - - - - - ;
+e::Send F
+r::Send P
+t::Send G
+y::Send J
+u::Send L
+i::Send U
+o::Send Y
+p::Send /
+[::Send •  ;  • {U+2022} (Bullet)
+]::Send ◦  ;  ◦ {U+25E6} (White bullet)

+s::Send R
+d::Send S
+f::Send T
+g::Send D
+j::Send N
+k::Send E
+l::Send I
+`;::Send O
+'::Send *

+n::Send K
+,::Send ?
+.::Send {!}
+/::Send |

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;  Cyrillic  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#If isNewOrder and !GetKeyState("LAlt", "P") and !isLatin

q::Send ц
w::Send ь
e::Send я
r::fCharToggle("э", "є")
t::Send ф
y::Send з
u::Send в
i::Send к
o::Send д
p::Send ч
[::Send ш
]::Send щ

a::Send у
s::fCharToggle("и", "й")
d::Send е
f::Send о
g::Send а
h::Send л
j::Send н
k::Send т
l::Send с
`;::Send р
'::fCharToggle("ї", "ґ")

z::Send .
x::Send `,
c::Send х
v::fCharToggle("ы", "і")
b::Send ю
n::Send б
m::Send м
,::Send п
.::Send г
/::Send ж
; - - - - - - - - - Cyrillic SHIFT states - - - - - - - - - - - - - - - - ;
+q::Send Ц
+w::Send ъ
+e::Send Я
+r::fCharToggle("Э", "Є")
+t::Send Ф
+y::Send З
+u::Send В
+i::Send К
+o::Send Д
+p::Send Ч
+[::Send Ш
+]::Send Щ

+a::Send У
+s::fCharToggle("И", "Й")
+d::Send Е
+f::Send О
+g::Send А
+h::Send Л
+j::Send Н
+k::Send Т
+l::Send С
+`;::Send Р
+'::fCharToggle("Ї", "Ґ")

+z::Send {!}
+x::Send ?
+c::Send Х
+v::fCharToggle("Ы", "І")
+b::Send Ю
+n::Send Б
+m::Send М
+,::Send П
+.::Send Г
+/::Send Ж



#If isNewOrder and !GetKeyState("LAlt", "P")

#Space::
isLatin := !isLatin
If isLatin
    Menu, Tray, Icon, %pSecret%\Things\Latin.ico
else Menu, Tray, Icon, %pSecret%\Things\Cyrillic.ico
return

+Space::
<^Space::
>!Space::
>!<^Space::Send {Space}

>!Capslock::
<^>!Capslock::Send {Backspace}

<#Tab::AltTab       ; LWin + Tab  =>  Alt + Tab
<#`::Send #{Tab}

<^d::Send ^h        ; LCtrl + D   =>  Ctrl + H          Find and replace
<^q::Send !c        ; LCtrl + Q   =>  Alt + C           VSCode: match case
<^w::Send !w        ; LCtrl + W   =>  Alt + W           VSCode: match whole word
<^e::Send !r        ; LCtrl + E   =>  Alt + R           VSCode: use regex

VKDC::Send !d       ; \           =>  Alt + D           Explorer, Firefox: focus address bar

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  SHIFT  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

+`::Send №  ;  № {U+2116} Numero sign

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  AltGR  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  >!`::
<^>!`::Send ∞  ;  ∞ {U+    } Infinity sign
  >!1::
<^>!1::Send ¹  ;  ¹ {U+00B9} Superscript one
  >!2::
<^>!2::Send ²  ;  ² {U+00B2} Superscript two
  >!3::
<^>!3::Send ³  ;  ³ {U+00B3} Superscript three
  >!4::
<^>!4::Send √  ;  √ {U+221A} Square root
  >!5::
<^>!5::Send ·  ;  · {U+00B7} Middle dot
  >!6::
<^>!6::Send ×  ;  × {U+00D7} Multiplication sign
  >!7::
<^>!7::Send ÷  ;  ÷ {U+00F7} Division sign
  >!8::
<^>!8::Send {+}
  >!9::
<^>!9::Send −  ;  − {U+2212} Minus sign
  >!0::
<^>!0::Send ±  ;  ± {U+00B1} Plus-minus sign
  >!-::
<^>!-::Send ≈  ;  ≈ {U+2248} Almost equal to
  >!=::
<^>!=::Send ≠  ;  ≠ {U+2260} Not equal to

  >!q::
<^>!q::Send 9
  >!w::
<^>!w::Send 8
  >!e::
<^>!e::Send 7
  >!r::
<^>!r::Send 6
  >!t::
<^>!t::Send 5
  >!y::
<^>!y::Send þ  ;  þ {U+00FE} (Small thorn)
  >!u::
<^>!u::Send ð  ;  ð {U+00F0} (Small eth)
  >!i::
<^>!i::Send (
  >!o::
<^>!o::Send )
  >!p::
<^>!p::Send `%  ;  % {U+0025} (Percent sign)
  >![::
<^>![::Send ≥
  >!]::
<^>!]::Send ≤

  >!a::
<^>!a::Send 0
  >!s::
<^>!s::Send 1
  >!d::
<^>!d::Send 2
  >!f::
<^>!f::Send 3
  >!g::
<^>!g::Send 4
  >!h::
<^>!h::Send ‑  ;  ‑ {U+2011} Non-breaking hyphen
  >!j::
<^>!j::Send {+}
  >!k::
<^>!k::Send `=
  >!l::
<^>!l::Send "
  >!;::
<^>!;::Send '
  >!'::
<^>!'::Send ``  ;  Backtick (grave accent)
                                                        
  >!z::
<^>!z::Send æ   ;  æ {U+00E6} Small ash
  >!x::
<^>!x::Send œ   ;  œ {U+0153}
  >!c::
<^>!c::Send ©
  >!v::
<^>!v::Send ™
  >!b::
<^>!b::Send –   ;  – {U+2013} En dash
  >!n::
<^>!n::Send —   ;  — {U+2014} Em dash
  >!m::
<^>!m::Send -   ;  Hyphen-minus
  >!,::
<^>!,::Send `;
  >!.::
<^>!.::Send :
  >!/::
<^>!/::Send &

;;;;;;;;;;;;;;;;;;;;;;;;;;;  Shift + AltGR  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;   +>!`::
; +<^>!`::Send
  +>!1::
+<^>!1::Send ಠ_ಠ
  +>!2::
+<^>!2::Send ¯\_(ツ)_/¯
  +>!3::
+<^>!3::Send ¯\(☯෴☯)/¯
  +>!4::
+<^>!4::Send (☞ ಠ_ಠ)☞
  +>!5::
+<^>!5::Send ᕦ(ಠ_ಠ)ᕤ

  +>!q::
+<^>!q::Send ̊
  +>!w::
+<^>!w::Send ̨
  +>!e::
+<^>!e::Send ̌
  +>!r::
+<^>!r::Send ̂
  +>!t::
+<^>!t::Send ̋
  +>!y::
+<^>!y::Send Þ
  +>!u::
+<^>!u::Send Ð
  +>!i::
+<^>!i::Send [
  +>!o::
+<^>!o::Send ]
  +>!p::
+<^>!p::Send °  ; Degree sign
;   +>![::
; +<^>![::Send
;   +>!]::
; +<^>!]::Send

  +>!a::
+<^>!a::Send ̀
  +>!s::
+<^>!s::Send ́
  +>!d::
+<^>!d::Send ̃
  +>!f::
+<^>!f::Send ̈
  +>!g::
+<^>!g::Send ß
  +>!h::
+<^>!h::Send ̧
  +>!j::
+<^>!j::Send <
  +>!k::
+<^>!k::Send >
  +>!l::
+<^>!l::Send {{}
  +>!;::
+<^>!;::Send {}}
  +>!'::
+<^>!'::Send ̄   ; ̄   {U+0304} (Combining macron)
                                                                                                
  +>!z::
+<^>!z::Send Æ
  +>!x::
+<^>!x::Send Œ
  +>!c::
+<^>!c::Send ₴  ;  Hryvnia
  +>!v::
+<^>!v::Send €  ;  Euro
  +>!b::
+<^>!b::Send £  ;  Pound
  +>!n::
+<^>!n::Send ₽  ;  Ruble
  +>!m::
+<^>!m::Send {^}
  +>!,::
+<^>!,::Send $
  +>!.::
+<^>!.::Send @
  +>!/::
+<^>!/::Send ~


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;  LAlt states (navigation, cursor, misc)  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#If isNewOrder and GetKeyState("LAlt", "P")

*m::Send {Delete}
*q::Send ^+t            ; LAlt + Q          =>  Ctrl + Shift + T   Firefox: undo close tab
*y::Send ^p             ; LAlt + Y          =>  Ctrl + P           VSCode: go to file
*u::Send ^g             ; LAlt + U          =>  Ctrl + G           VSCode: go to line
*o::Send +{F10}         ; LAlt + O          =>  Shift + F10        Context menu
*p::Send !d             ; LAlt + P          =>  Alt + D            Explorer, Firefox: focus address bar

*g::Send ^+[            ; LAlt + G          =>  Ctrl + Shift + [   VSCode: collapse region
*h::Send ^+]            ; LAlt + H          =>  Ctrl + Shift + ]   VSCode: uncollapse region

*+z::Send ^y            ; LAlt + Shift + Z  =>  Ctrl + Y           Redo action
*b::Send ^/             ; LAlt + B          =>  Ctrl + /           VSCode: toggle comment

; — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — — ;
*j::
If GetKeyState(";")
  Send +{Left}                         ; LAlt + ; + J              =>  Shift + Left
else Send {Left}
return
*+j::Send +{Left}                      ; LAlt + Shift + J          =>  Shift + Left
*<^j::
If GetKeyState(";")
    Send ^+{Left}                      ; LAlt + LCtrl + ; + J      =>  Ctrl + Shift + Left
else Send ^{Left}                      ; LAlt + LCtrl + J          =>  Ctrl + Left
return
*<^+j::Send ^+{Left}                   ; LAlt + LCtrl + Shift + J  =>  Ctrl + Shift + Left

*>!j::
*<^>!j::
If GetKeyState(";")
  Send !+{Left}                        ; LAlt + AltGr + ; + J      =>  Alt + Shift + Left
else Send !{Left}                      ; LAlt + AltGr + J          =>  Alt + Left
return
*>!+j::
*<^>!+j::Send !+{Left}                 ; LAlt + AltGr + Shift + J  =>  Alt + Shift + Left

; – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – ;
*l::
If GetKeyState(";")
  Send +{Right}
else Send {Right}
return
*+l::Send +{Right}
*<^l::
If GetKeyState(";")
    Send ^+{Right}
else Send ^{Right}
return
*<^+l::Send ^+{Right}

*>!l::
*<^>!l::
If GetKeyState(";")
  Send !+{Right}
else Send !{Right}
return
*>!+l::
*<^>!+l::Send !+{Right}

; – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – ;
*i::
If GetKeyState(";")
  Send +{Up}
else Send {Up}
return
*+i::Send +{Up}
*<^i::
If GetKeyState(";")
    Send ^+{Up}
else Send ^{Up}
return
*<^+i::Send ^+{Up}

*>!i::
*<^>!i::
If GetKeyState(";")
  Send !+{Up}
else Send !{Up}
return
*>!+i::
*<^>!+i::Send !+{Up}

; – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – ;
*k::
If GetKeyState(";")
  Send +{Down}
else Send {Down}
return
*+k::Send +{Down}
*<^k::
If GetKeyState(";")
    Send ^+{Down}
else Send ^{Down}
return
*<^+k::Send ^+{Down}

*>!k:: 
*<^>!k::
If GetKeyState(";")
  Send !+{Down}
else Send !{Down}
return
*>!+k::
*<^>!+k::Send !+{Down}

; – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – – ;
*,::Send ^!{Down}       ; LAlt + ,          => Ctrl + Alt + Down
*+,::Send ^!+{Down}     ; LAlt + Shift + ,  => Ctrl + Alt + Shift + Down
*.::Send ^!{Up}         ; LAlt + .          => Ctrl + Alt + Up
*+.::Send ^!+{Up}       ; LAlt + Shift + .  => Ctrl + Alt + Shift + Up

;<==<==<==<==<==<==<==<==   Left side navigation: Home, End, PgUp, PgDn   <==<==<==<==<==<==<==<==<==<==

*s::
If GetKeyState(";")
  Send +{Home}
else Send {Home}             ; LAlt + S          =>  Home
return
*+s::Send +{Home}            ; LAlt + Shift + S  =>  Shift + Home
*>!s::
*<^>!s::Send ^{PgUp}         ; LAlt + AltGr + S  =>  Ctrl + PageUp             Previous tab

*f::
If GetKeyState(";")
  Send +{End}
else Send {End}              ; LAlt + F          =>  End
return
*+f::Send +{End}             ; LAlt + Shift + F  =>  Shift + End
*>!f::
*<^>!f::Send ^{PgDn}         ; LAlt + AltGr + F  =>  Ctrl + PageDown           Next tab


*e::Send {PgUp}              ; LAlt + E          =>  PageUp
*>!e::
*<^>!e::Send ^+{PgUp}        ; LAlt + AltGr + E  =>  Ctrl + Shift + PageUp     Firefox, VSCode: move tab left

*d::Send {PgDn}              ; LAlt + D          =>  PageDown
*>!d::
*<^>!d::Send ^+{PgDn}        ; LAlt + AltGr + D  =>  Ctrl + Shift + PageDown   Firefox, VSCode: move tab right

#If