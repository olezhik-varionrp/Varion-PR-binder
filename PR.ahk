#Requires AutoHotkey v2.0
#SingleInstance Force
A_IconHidden := 1

global base := "https://raw.githubusercontent.com/olezhik-varionrp/Varion-PR-binder/main/"

; Чтение настроек
if !FileExist("Settings.ini") {
    IniWrite("0", "Settings.ini", "IDStream", "qdin")
    IniWrite("5", "Settings.ini", "templeader", "tlead")
}

qdin := IniRead("Settings.ini", "IDStream", "qdin", "0")
tlead := IniRead("Settings.ini", "templeader", "tlead", "5")

; Интерфейс
MainGui := Gui("-MaximizeBox", "PR-Assistant Binder")
MainGui.BackColor := "282b31"
MainGui.SetFont("s9 cWhite", "Bahnschrift")

; Левые кнопки
MainGui.Add("Picture", "x7 y15 w80 h41", base "tp.png").OnEvent("Click", (*) => Teleports())
MainGui.Add("Picture", "x7 y65 w80 h41", base "spis.png").OnEvent("Click", (*) => CmdList())
MainGui.Add("Picture", "x7 y115 w80 h41", base "nak.png").OnEvent("Click", (*) => Punish())
MainGui.Add("Picture", "x7 y165 w80 h41", base "bind.png").OnEvent("Click", (*) => Info())
MainGui.Add("Picture", "x7 y352 w80 h30", base "save.png").OnEvent("Click", (*) => SaveID())

; Правые кнопки
MainGui.Add("Picture", "x302 y248 w150 h41", base "pred.png").OnEvent("Click", (*) => Infopred())
MainGui.Add("Picture", "x302 y300 w150 h30", base "spisupdate.png").OnEvent("Click", (*) => FixLog())
MainGui.Add("Picture", "x302 y340 w150 h41", base "saveglobal.png").OnEvent("Click", (*) => SaveOpt())

; Картинки заголовков
MainGui.Add("Picture", "x100 y9 w184 h27", base "bindinfo.png")
MainGui.Add("Picture", "x294 y9 w168 h27", base "auto.png")

; Поля ввода
MainGui.Add("Text", "x7 y300", "ID стримера:")
global qdin_edit := MainGui.Add("Edit", "x7 y322 w80 h21 +Number", qdin)
MainGui.Add("Text", "x390 y155", "")
global tlead_edit := MainGui.Add("Edit", "x390 y155 w21 h18 +Number", tlead)

; Памятка
MainGui.Add("GroupBox", "x3 y385 w240 h130 cA52A2A")
MainGui.Add("GroupBox", "x241 y385 w226 h130 cA52A2A")
MainGui.Add("Text", "x10 y395", ".ку - Приветствие на 'ты'\n.привет - Приветствие на 'Вы'\n.замена - Замена ассистента\n.пока - Прощание\n.не - 'Не нарушайте'")
MainGui.Add("Text", "x248 y395", "Помощь с м-чатом\n.кпз - Выпуск с КПЗ\n.авто - Выдача авто\n.искин - Выдача скина\n.од - Запрос одобрения")

MainGui.Show("w470 h520")

; --- ФУНКЦИИ ---
SaveID(*) {
    IniWrite(qdin_edit.Value, "Settings.ini", "IDStream", "qdin")
    MsgBox("ID сохранен")
}
SaveOpt(*) => Reload()
Teleports(*) => Run(base "tp_list.txt") ; Или создай функцию для GUI
CmdList(*) => MsgBox("Список команд")
Punish(*) => MsgBox("Наказания")
Info(*) => MsgBox("Автор: flayme")
Infopred(*) => MsgBox("Преды")
FixLog(*) => MsgBox("Обновления")
VhodLogic(*) => SendInput("/gm")

; --- ХОТКЕИ ИЗ V1 (ПРИМЕР) ---
:X:.ку::SendInput("Привет, сегодня я слежу за тобой. Хорошего стрима")
:X:.1п::SendInput("/asms " qdin_edit.Value " 1/3 предупреждений за ")

^F9::Reload()
^F10::ExitApp()
