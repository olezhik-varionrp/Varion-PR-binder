#Requires AutoHotkey v2.0
#SingleInstance Force
A_IconHidden := 1  ; Скрываем стандартную зеленую иконку процесса в v2

titlcolor := "df005c"

; Чтение настроек из INI
Radio1 := IniRead("Settings.ini", "Settings", "/hidecheatinfo", "0")
Radio2 := IniRead("Settings.ini", "Settings", "/zzdebug", "0")
Radio3 := IniRead("Settings.ini", "Settings", "/gm", "0")
Radio4 := IniRead("Settings.ini", "Settings", "/esp3", "0")
Radio5 := IniRead("Settings.ini", "Settings", "/templeader", "0")
Radio6 := IniRead("Settings.ini", "Settings", "/chide", "0")

KEY1 := IniRead("Settings.ini", "KeySetup", "KEY1", "")
KEY2 := IniRead("Settings.ini", "KeySetup", "KEY2", "")
KEY3 := IniRead("Settings.ini", "KeySetup", "KEY3", "")
KEY4 := IniRead("Settings.ini", "KeySetup", "KEY4", "")
KEY5 := IniRead("Settings.ini", "KeySetup", "KEY5", "")
KEY6 := IniRead("Settings.ini", "KeySetup", "KEY6", "")
KEY7 := IniRead("Settings.ini", "KeySetup", "KEY7", "")
KEY8 := IniRead("Settings.ini", "KeySetup", "KEY8", "")
KEY9 := IniRead("Settings.ini", "KeySetup", "KEY9", "")
KEY10 := IniRead("Settings.ini", "KeySetup", "KEY10", "")
KEY11 := IniRead("Settings.ini", "KeySetup", "KEY11", "")
KEY12 := IniRead("Settings.ini", "KeySetup", "KEY12", "")
KEY13 := IniRead("Settings.ini", "KeySetup", "KEY13", "")
KEY14 := IniRead("Settings.ini", "KeySetup", "KEY14", "")

qdin := IniRead("Settings.ini", "IDStream", "qdin", "0")
tlead := IniRead("Settings.ini", "templeader", "tlead", "5")

; Активация горячих клавиш (Синтаксис v2)
TryHotkey(key, label) {
    if (key != "") {
        try Hotkey(key, label, "On")
    }
}

TryHotkey(KEY1, (*) => SendInput("/asms " qdin_edit.Value " "))
TryHotkey(KEY2, (*) => SendInput("/setdim " qdin_edit.Value " 1{Enter}"))
TryHotkey(KEY3, (*) => SendInput("/setdim " qdin_edit.Value " 0{Enter}"))
TryHotkey(KEY4, (*) => SendInput("/hardban 8888 Cheats{Left 12}"))
TryHotkey(KEY5, (*) => SendInput("/ban 3.5 ОПС{Left 8}"))
TryHotkey(KEY6, (*) => SendInput("/tp " qdin_edit.Value "{Enter}"))
TryHotkey(KEY7, (*) => SendInput("/gh "))
TryHotkey(KEY8, (*) => SendInput("/hp " qdin_edit.Value " 100{Enter}"))
TryHotkey(KEY9, (*) => SendInput("/rescue " qdin_edit.Value "{Enter}"))
TryHotkey(KEY10, (*) => SendInput("/spec " qdin_edit.Value "{Enter}"))
TryHotkey(KEY11, (*) => SendInput("/specoff{Enter}{F5}"))
TryHotkey(KEY12, (*) => SendInput("/repair{Enter}"))
TryHotkey(KEY13, (*) => CheatsheetGui())
TryHotkey(KEY14, (*) => VhodLogic())

; --- ГЛАВНЫЙ ИНТЕРФЕЙС ---
MainGui := Gui("-MaximizeBox", "Varion PR Binder")
MainGui.BackColor := "282b31"
MainGui.SetFont("s9 cWhite", "Bahnschrift")

; Левая колонка кнопок
MainGui.Add("Picture", "x7 y15 w80 h41", LoadImgMem("tp.png")).OnEvent("Click", (*) => TeleportsGui())
MainGui.Add("Picture", "x7 y65 w80 h41", LoadImgMem("spis.png")).OnEvent("Click", (*) => CommandListGui())
MainGui.Add("Picture", "x7 y115 w80 h41", LoadImgMem("nak.png")).OnEvent("Click", (*) => PunishGui())
MainGui.Add("Picture", "x7 y165 w80 h41", LoadImgMem("bind.png")).OnEvent("Click", (*) => InfoGui())

MainGui.Add("Text", "x7 y300 +0x200", "ID стримера:")
qdin_edit := MainGui.Add("Edit", "x7 y322 w80 h21 +Number cBlack", qdin)
MainGui.Add("Picture", "x7 y352 w80 h30", LoadImgMem("save.png")).OnEvent("Click", (*) => SaveID())

; ДЕКОРАТИВНЫЕ ПАНЕЛИ СВЕРХУ
MainGui.Add("Picture", "x100 y9 w184 h27", LoadImgMem("bindinfo.png"))
MainGui.Add("Picture", "x294 y9 w168 h27", LoadImgMem("auto.png"))

; ================= ВОЗВРАЩАЕМ ПОЛЯ НАСТРОЙКИ БИНДОВ ИЗ V1 =================
MainGui.SetFont("s8 cWhite", "Bahnschrift")
hot1 := MainGui.Add("Hotkey", "x110 y50 w48 h21", KEY1)
MainGui.Add("Text", "x163 y53 w120 h14 +0x200", "asms media")
hot2 := MainGui.Add("Hotkey", "x110 y76 w48 h21", KEY2)
MainGui.Add("Text", "x163 y79 w120 h14 +0x200", "setdim 1")
hot3 := MainGui.Add("Hotkey", "x110 y102 w48 h21", KEY3)
MainGui.Add("Text", "x163 y105 w120 h14 +0x200", "setdim 0")
hot4 := MainGui.Add("Hotkey", "x110 y128 w48 h21", KEY4)
MainGui.Add("Text", "x163 y131 w120 h14 +0x200", "Бан за читы")
hot5 := MainGui.Add("Hotkey", "x110 y154 w48 h21", KEY5)
MainGui.Add("Text", "x163 y157 w120 h14 +0x200", "Бан за запретку")
hot6 := MainGui.Add("Hotkey", "x110 y180 w48 h21", KEY6)
MainGui.Add("Text", "x163 y183 w120 h14 +0x200", "Телепорт к медиа")
hot7 := MainGui.Add("Hotkey", "x110 y206 w48 h21", KEY7)
MainGui.Add("Text", "x163 y209 w120 h14 +0x200", "Телепорт к себе")
hot8 := MainGui.Add("Hotkey", "x110 y232 w48 h21", KEY8)
MainGui.Add("Text", "x163 y235 w120 h14 +0x200", "Восстановить ХП")
hot9 := MainGui.Add("Hotkey", "x110 y258 w48 h21", KEY9)
MainGui.Add("Text", "x163 y261 w120 h14 +0x200", "Возродить")
hot10 := MainGui.Add("Hotkey", "x110 y284 w48 h21", KEY10)
MainGui.Add("Text", "x163 y287 w120 h14 +0x200", "Spec")
hot11 := MainGui.Add("Hotkey", "x110 y310 w48 h21", KEY11)
MainGui.Add("Text", "x163 y313 w120 h14 +0x200", "Specoff")
hot12 := MainGui.Add("Hotkey", "x110 y336 w48 h21", KEY12)
MainGui.Add("Text", "x163 y339 w120 h14 +0x200", "Починка авто")
hot13 := MainGui.Add("Hotkey", "x110 y362 w48 h21", KEY13)
MainGui.Add("Text", "x163 y365 w120 h14 +0x200", "Памятка")

hot14 := MainGui.Add("Hotkey", "x303 y212 w40 h21", KEY14)
MainGui.Add("Text", "x350 y216 w120 h14 +0x200", "Команды при входе")
; =========================================================================

MainGui.SetFont("s9 cWhite", "Bahnschrift")
; Правая колонка авторизации
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
tlead_edit := MainGui.Add("Edit", "x390 y155 w21 h18 +Number cBlack", tlead)
cb6 := MainGui.Add("CheckBox", "x304 y180 w120 h23", "/chide")
cb6.Value := Radio6

; Правые кнопки-картинки
MainGui.Add("Picture", "x302 y248 w150 h41", LoadImgMem("pred.png")).OnEvent("Click", (*) => InfopredGui())
MainGui.Add("Picture", "x302 y300 w150 h30", LoadImgMem("spisupdate.png")).OnEvent("Click", (*) => FixLogGui())
MainGui.Add("Picture", "x302 y340 w150 h41", LoadImgMem("saveglobal.png")).OnEvent("Click", (*) => SaveOption())

; Нижняя памятка
MainGui.Add("GroupBox", "x3 y385 w240 h130 cA52A2A")
MainGui.Add("GroupBox", "x241 y385 w226 h130 cA52A2A")
MainGui.Add("Text", "x10 y395 h20 +0x200", ".ку - Приветствие на 'ты'")
MainGui.Add("Text", "x10 y415 h20 +0x200", ".привет - Приветствие на 'Вы'")
MainGui.Add("Text", "x10 y435 h20 +0x200", ".замена - Замена другим ассистентом")
MainGui.Add("Text", "x10 y455 h20 +0x200", ".пока - Прощание в конце стрима")
MainGui.Add("Text", "x10 y475 h20 +0x200", ".не - 'Не нарушайте' игроку")
MainGui.Add("Text", "x305 y395 h20 +0x200", "Помощь с м-чатом")
MainGui.Add("Text", "x248 y415 h20 +0x200", ".кпз - Выпуск с КПЗ")
MainGui.Add("Text", "x248 y435 h20 +0x200", ".авто - Выдача авто")
MainGui.Add("Text", "x248 y455 h20 +0x200", ".искин - Выдача скина")
MainGui.Add("Text", "x248 y475 h20 +0x200", ".од - Запрос одобрения в ЛС")

MainGui.Show("w470 h520")

; --- ЛОГИКА НАСТРОЕК ---
SaveID() {
    IniWrite(qdin_edit.Value, "Settings.ini", "IDStream", "qdin")
    MsgBox("ID Стримера успешно сохранен!", "Сохранение", 64)
}

SaveOption() {
    IniWrite(cb1.Value, "Settings.ini", "Settings", "/hidecheatinfo")
    IniWrite(cb2.Value, "Settings.ini", "Settings", "/zzdebug")
    IniWrite(cb3.Value, "Settings.ini", "Settings", "/gm")
    IniWrite(cb4.Value, "Settings.ini", "Settings", "/esp3")
    IniWrite(cb5.Value, "Settings.ini", "Settings", "/templeader")
    IniWrite(cb6.Value, "Settings.ini", "Settings", "/chide")
    IniWrite(tlead_edit.Value, "Settings.ini", "templeader", "tlead")
    
    IniWrite(hot1.Value, "Settings.ini", "KeySetup", "KEY1")
    IniWrite(hot2.Value, "Settings.ini", "KeySetup", "KEY2")
    IniWrite(hot3.Value, "Settings.ini", "KeySetup", "KEY3")
    IniWrite(hot4.Value, "Settings.ini", "KeySetup", "KEY4")
    IniWrite(hot5.Value, "Settings.ini", "KeySetup", "KEY5")
    IniWrite(hot6.Value, "Settings.ini", "KeySetup", "KEY6")
    IniWrite(hot7.Value, "Settings.ini", "KeySetup", "KEY7")
    IniWrite(hot8.Value, "Settings.ini", "KeySetup", "KEY8")
    IniWrite(hot9.Value, "Settings.ini", "KeySetup", "KEY9")
    IniWrite(hot10.Value, "Settings.ini", "KeySetup", "KEY10")
    IniWrite(hot11.Value, "Settings.ini", "KeySetup", "KEY11")
    IniWrite(hot12.Value, "Settings.ini", "KeySetup", "KEY12")
    IniWrite(hot13.Value, "Settings.ini", "KeySetup", "KEY13")
    IniWrite(hot14.Value, "Settings.ini", "KeySetup", "KEY14")
    Reload()
}

VhodLogic() {
    SendInput("{T}/gm{Enter}")
    Sleep(300)
    if (cb4.Value == 1) {
        SendInput("{T}/esp3{Enter}")
        Sleep(300)
    }
    if (cb6.Value == 1) {
        SendInput("{T}/chide{Enter}")
        Sleep(300)
    }
    if (cb2.Value == 1) {
        SendInput("{T}/zzdebug{Enter}")
        Sleep(300)
    }
    if (cb1.Value == 1) {
        SendInput("{T}/hidecheatinfo{Enter}")
        Sleep(300)
    }
    if (cb5.Value == 1) {
        SendInput("{T}/templeader " tlead_edit.Value "{Enter}")
    }
}

; --- ОКНА GUI ---
InfopredGui() {
    g := Gui(, "Предупреждения")
    g.BackColor := "282b31"
    g.SetFont("s12 cWhite", "Bahnschrift")
    g.Add("GroupBox", "x20 y5 w660 h50 cA52A2A")
    g.Add("Text", "cee5180 x250 y23 +0x200", "Предупреждения на стриме:")
    g.Add("Text", "x25 y70 cYellow", "Бинд: .1п/.2п/.3п - нельзя доводить медиа до 3/3 предупреждений.")
    g.Add("Text", "x25 y100 cWhite", "Так же не забывайте есть и устные предупреждения за мелкие нарушения.")
    g.Add("Text", "x25 y130 cYellow", ".уст - Устное предупреждение медиа-партнёру.")             
    g.Add("Text", "x25 y190 cee5180", "1 предупреждение - нарушение на 80-120 минут деморгана.")
    g.Add("Text", "x25 y220 cWhite", "Например, DB + PG + NRD + OOC оск - это все стакается в одно предупреждение.")
    g.Add("Text", "x25 y250 cWhite", "(Предупреждайте словесно за мелкие нарушения перед стаком в 1/3 preads).")
    g.Add("Text", "x25 y280 cee5180", "2 предупреждения - нарушение от бана.")
    g.Add("Text", "x25 y310 cRed", "Прямое оскорбление родных - выдаёте сразу бан (не хард) на 30 дней.")
    g.Show("h340 w700")
}

FixLogGui() {
    g := Gui(, "Список изменений")
    g.BackColor := "282b31"
    g.SetFont("s12 cWhite", "Bahnschrift")
    g.Add("GroupBox", "x20 y5 w660 h50 cA52A2A")
    g.Add("Text", "cee5180 x270 y23 +0x200", "Список изменений:")
    g.Add("Text", "x25 y80 cWhite", "- Актуальная версия Переведена на движок AHK v2 (22.05.2026).")
    g.Add("Text", "x25 y100 cWhite", "По вопросам и ошибкам Discord: Olezhik.ad или Telegram: @olezhikmanager.")
    g.Show("h160 w700")
}

InfoGui() {
    g := Gui(, "Информация о биндере")
    g.BackColor := "282b31"
    g.SetFont("s12 cWhite", "Bahnschrift")
    g.Add("Text", "cee5180 x8 y8 h23 +0x200", "Данный Binder создан для облегчения работы PR ассистентов.")
    g.SetFont("s11")
    g.Add("Text", "x8 y40 +0x200", "Все команды, телепорты, наказания можно вводить транслитом.")
    g.Add("Text", "x8 y60 h23 +0x200", "В окно 'ID стримера' вводите динамик медиа, за которым следите.")
    g.Add("Text", "x8 y100 h23 +0x200", "Доступные команды для автоматического динамика:")
    g.Add("Text", "x8 y120 h23 +0x200", "/asms; /setdim 1/0; .1п; .2п; .3п;")
    g.Add("Text", "cYellow x8 y150 h23 +0x200", "Ctrl + F9 - Моментально обновить биндер с GitHub.")
    g.Add("Text", "cYellow x8 y170 h23 +0x200", "Ctrl + F10 - Полностью закрыть биндер.")
    g.SetFont("s14")
    g.Add("Text", "x8 y210 h23 +0x200", "Автор биндера - olezhik")
    g.Add("Text", "x8 y230 h23 +0x200", "Редактирование и актуализация - olezhik")
    g.Add("Text", "x8 y250 h23 +0x200", "Дизайн иконки - yokkk")
    g.Show("h280 w540")
}

TeleportsGui() {
    g := Gui(, "Телепорты")
    g.BackColor := "282b31"
    g.SetFont("s10 cWhite", "Bahnschrift")
    g.Add("Text", "cee5180 x8 y450 h20 +0x200", "Ключи")
    g.Add("Text", "x8 y466 h20 +0x200", ".ключ - /ctp -361.424 -129.636 38.696")
    g.Add("Text", "x8 y482 h20 +0x200", ".клг - /ctp -40.529 -1077.648 26.653")
    g.Add("Text", "x8 y498 h20 +0x200", ".клс - /ctp 1728.313 3717.568 34.109")
    g.Add("Text", "x8 y514 h20 +0x200", ".клп - /ctp -196.836 6218.708 31.491")
    g.Add("Text", "cee5180 x8 y8 h20 +0x200", "Респавны фракций")
    g.Add("Text", "x8 y24 h20 +0x200", ".лспд - /ctp 429 -980 30.50")
    g.Add("Text", "x8 y40 h20 +0x200", ".бол - /ctp 287.70 -578.35 50")
    g.Add("Text", "x8 y56 h20 +0x200", ".шд - /ctp -434.87 6024.54 31.50")
    g.Add("Text", "x8 y72 h20 +0x200", ".шд2 - /ctp 1843.770 3666.384 33.760")
    g.Add("Text", "x8 y88 h20 +0x200", ".фз - /ctp -2336 3257 32.50")
    g.Show("h540 w550")
}

CommandListGui() {
    g := Gui(, "Команды")
    g.BackColor := "282b31"
    g.SetFont("s10 cWhite", "Bahnschrift")
    g.Add("Text", "x8 y8 h20 +0x200", "/bch - /bancheck")
    g.Add("Text", "x8 y24 h20 +0x200", ".иср - /bancheck")
    g.Add("Text", "x8 y40 h20 +0x200", "/jch - /ajailcheck")
    g.Add("Text", "x8 y56 h20 +0x200", ".оср - /ajailcheck")
    g.Show("h120 w300")
}

PunishGui() {
    g := Gui(, "Наказания")
    g.BackColor := "300b31"
    g.SetFont("s10 cWhite", "Bahnschrift")
    g.Add("Text", "x8 y8 h20 +0x200", ".чит - /hardban 8888 Cheats")
    g.Add("Text", "x8 y24 h20 +0x200", ".запретка - /ban 3.5 ОПС")
    g.Show("h80 w300")
}

CheatsheetGui() {
    ; Метод памятки
}

LoadImgMem(fileName) {
    url := "https://raw.githubusercontent.com/olezhik-varionrp/Varion-PR-binder/main/" . fileName
    try {
        whr := ComObject("WinHttp.WinHttpRequest.5.1")
        whr.Open("GET", url, true)
        whr.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
        whr.Send()
        whr.WaitForResponse()
        pStream := DllCall("Shlwapi\SHCreateMemStream", "Ptr", whr.ResponseBody, "UInt", whr.ResponseBody.MaxIndex() + 1, "Ptr")
        DllCall("gdiplus\GdipCreateBitmapFromStream", "Ptr", pStream, "Ptr*", &pBitmap := 0)
        DllCall("gdiplus\GdipCreateHBITMAPFromBitmap", "Ptr", pBitmap, "Ptr*", &hBitmap := 0, "UInt", 0)
        return "HBITMAP:" . hBitmap
    } catch {
        return ""
    }
}

; --- ГОРЯЧИЕ СТРОКИ И ОТИГРЫШИ ---
::.ку::Привет, сегодня я слежу за тобой. Хорошего стрима
::.привет::Приветствую, на сегодня я ваш ассистент, по любым игровым вопросам - обращайтесь ко мне.
::.кпз::Напомню, что как либо контактировать с игроками которые вели процессуальные действия - запрещено.
::.авто::Напомню, что краймить на выданном авто нельзя, если заглохнет, то завести можно будет только отверткой.
::.искин::Правила не нарушать, RP моменты существенные для скина поддерживать. Будут жалобы - Вас кикнут/накажут. После окончания записи, нужно перезайти на server, чтобы снять скин.
::.замена::К сожалению, мне нужно тебя покинуть, меня заменит другой Ассистент. Хорошего продолжения стрима
::.пока::Спасибо за стрим, хорошего настроения.
::.од::Предоставьте одобрение в личные сообщения.
::.промо::При достижении 3 уровня по твоему промо игроки будут получать: 7 дней PLATINUM VIP и 50.000$.

; Быстрые команды автоматического динамика
:X:.1п:: {
    SendInput("/asms " qdin_edit.Value " 1/3 предупреждений за ")
}
:X:.2п:: {
    SendInput("/asms " qdin_edit.Value " 2/3 предупреждений за ")
}
:X:.3п:: {
    SendInput("/asms " qdin_edit.Value " 3/3 предупреждений за .Если продолжешь нарушать, будет полноценное наказание. ")
}
:X:.не:: {
    SendInput("/asms Не нарушайте, иначе Вы получите наказание. ")
}
:X:/ye:: {
    SendInput("/asms Не нарушайте, иначе Вы получите наказание. ")
}
:X:.уст:: {
    SendInput("/asms " qdin_edit.Value " Не стоит нарушать правила сервера.")
}
:X:/ecn:: {
    SendInput("/asms " qdin_edit.Value " Не нарушай, иначе ты получишь предупреждение.")
}
