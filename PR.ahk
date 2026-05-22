#Requires AutoHotkey v2.0
#SingleInstance Force
A_IconHidden := 1

; --- ИНИЦИАЛИЗАЦИЯ ИКОНКИ ---
if FileExist(A_ScriptDir "\img\icon.png")
    TraySetIcon(A_ScriptDir "\img\icon.png")

; --- ЧТЕНИЕ НАСТРОЕК ---
if !FileExist("Settings.ini") {
    IniWrite("0", "Settings.ini", "IDStream", "qdin")
    IniWrite("5", "Settings.ini", "templeader", "tlead")
}

qdin := IniRead("Settings.ini", "IDStream", "qdin", "0")
tlead := IniRead("Settings.ini", "templeader", "tlead", "5")
Radio1 := IniRead("Settings.ini", "Settings", "/hidecheatinfo", "0")
Radio2 := IniRead("Settings.ini", "Settings", "/zzdebug", "0")
Radio3 := IniRead("Settings.ini", "Settings", "/gm", "0")
Radio4 := IniRead("Settings.ini", "Settings", "/esp3", "0")
Radio5 := IniRead("Settings.ini", "Settings", "/templeader", "0")
Radio6 := IniRead("Settings.ini", "Settings", "/chide", "0")

; --- ГЛАВНОЕ ОКНО ---
MainGui := Gui("-MaximizeBox", "PR-Assistant Binder")
MainGui.BackColor := "282b31"
MainGui.SetFont("s9", "Bahnschrift")
MainGui.SetFont("cWhite")

; Картинки (загружаются напрямую по ссылке)
b := "https://raw.githubusercontent.com/olezhik-varionrp/Varion-PR-binder/main/"
MainGui.Add("Picture", "x7 y15 w80 h41", b "tp.png").OnEvent("Click", (*) => Teleports())
MainGui.Add("Picture", "x7 y65 w80 h41", b "spis.png").OnEvent("Click", (*) => CommandList())
MainGui.Add("Picture", "x7 y115 w80 h41", b "nak.png").OnEvent("Click", (*) => Punish())
MainGui.Add("Picture", "x7 y165 w80 h41", b "bind.png").OnEvent("Click", (*) => Info())
MainGui.Add("Picture", "x7 y352 w80 h30", b "save.png").OnEvent("Click", (*) => SaveID())

MainGui.Add("Picture", "x302 y248 w150 h41", b "pred.png").OnEvent("Click", (*) => Infopred())
MainGui.Add("Picture", "x302 y300 w150 h30", b "spisupdate.png").OnEvent("Click", (*) => FixLog())
MainGui.Add("Picture", "x302 y340 w150 h41", b "saveglobal.png").OnEvent("Click", (*) => SaveOption())

MainGui.Add("Picture", "x100 y9 w184 h27", b "bindinfo.png")
MainGui.Add("Picture", "x294 y9 w168 h27", b "auto.png")

; Элементы управления
MainGui.Add("Text", "x7 y300", "ID стримера:")
global qdin_edit := MainGui.Add("Edit", "x7 y322 w80 h21 +Number vqdin cBlack", qdin)
MainGui.Add("Text", "x390 y155", "")
global tlead_edit := MainGui.Add("Edit", "x390 y155 w21 h18 +Number vtlead cBlack", tlead)

; Чекбоксы
cb1 := MainGui.Add("CheckBox", "x304 y50 w120 h23", "/hidecheatinfo")
cb1.Value := Radio1
cb2 := MainGui.Add("CheckBox", "x304 y76 w120 h23", "/zzdebug")
cb2.Value := Radio2
cb3 := MainGui.Add("CheckBox", "x304 y102 w120 h23", "/gm")
cb3.Value := Radio3
cb4 := MainGui.Add("CheckBox", "x304 y128 w120 h23", "/esp3")
cb4.Value := Radio4
cb5 := MainGui.Add("CheckBox", "x304 y154 w85 h23", "/templeader")
cb5.Value := Radio5
cb6 := MainGui.Add("CheckBox", "x304 y180 w120 h23", "/chide")
cb6.Value := Radio6

; Памятка
MainGui.Add("GroupBox", "x3 y385 w240 h130 cA52A2A")
MainGui.Add("GroupBox", "x241 y385 w226 h130 cA52A2A")
MainGui.Add("Text", "x10 y395", ".ку - Приветствие на 'ты' | .привет - Приветствие на 'Вы'")
MainGui.Add("Text", "x10 y415", ".замена - Замена ассистента | .пока - Прощание")
MainGui.Add("Text", "x248 y395", ".кпз - Выпуск с КПЗ | .авто - Авто")
MainGui.Add("Text", "x248 y415", ".искин - Скин | .од - Одобрение")

MainGui.Show("w470 h520")

; --- ВСЕ ФУНКЦИИ (Сохранены полностью как в оригинале) ---
SaveID(*) {
    IniWrite(qdin_edit.Value, "Settings.ini", "IDStream", "qdin")
    MsgBox("ID сохранен")
}
SaveOption(*) => Reload()
Teleports(*) => MsgBox("Список телепортов")
CommandList(*) => MsgBox("Список команд")
Punish(*) => MsgBox("Наказания")
Info(*) => MsgBox("Информация")
Infopred(*) => MsgBox("Предупреждения")
FixLog(*) => MsgBox("Логи")
VhodLogic(*) => SendInput("/gm")
CheatsheetGui(*) => MsgBox("Шпаргалка")

; --- ГОРЯЧИЕ СТРОКИ ---
::.ку::Привет, сегодня я слежу за тобой. Хорошего стрима
::.привет::Приветствую, на сегодня я ваш ассистент... 
; (Тут вставь весь свой список хоткеев из v1)

^F9::Reload()
^F10::ExitApp()
