#Requires AutoHotkey v2.0
#SingleInstance Force

; Создаем папку для картинок, если её нет
if !DirExist(A_ScriptDir "\img")
    DirCreate(A_ScriptDir "\img")

; Функция для скачивания картинок с твоего GitHub
DownloadImg(imgName) {
    localPath := A_ScriptDir "\img\" imgName
    if !FileExist(localPath) {
        url := "https://raw.githubusercontent.com/olezhik-varionrp/Varion-PR-binder/main/" imgName
        try {
            Download(url, localPath)
        } catch {
            ; Если не удалось скачать, скрипт продолжит работу без картинки
        }
    }
}

; Скачиваем все необходимые элементы интерфейса (происходит только 1 раз при первом запуске)
DownloadImg("icon.png")
DownloadImg("tp.png")
DownloadImg("spis.png")
DownloadImg("nak.png")
DownloadImg("bind.png")
DownloadImg("save.png")
DownloadImg("pred.png")
DownloadImg("spisupdate.png")
DownloadImg("saveglobal.png")
DownloadImg("bindinfo.png")
DownloadImg("auto.png")

; Установка иконки в трей
if FileExist(A_ScriptDir "\img\icon.png")
    TraySetIcon(A_ScriptDir "\img\icon.png")

; Цвет заголовка (переменная сохранена, если понадобится в дальнейшем)
titlcolor := "df005c"

; Чтение настроек из INI-файла (в v2 синтаксис IniRead изменился)
Radio1 := IniRead("Settings.ini", "Settings", "/hidecheatinfo", "0")
Radio2 := IniRead("Settings.ini", "Settings", "/zzdebug", "0")
Radio3 := IniRead("Settings.ini", "Settings", "/gm", "0")
Radio4 := IniRead("Settings.ini", "Settings", "/esp3", "0")
Radio5 := IniRead("Settings.ini", "Settings", "/templeader", "0")
Radio6 := IniRead("Settings.ini", "Settings", "/chide", "0")

qdin := IniRead("Settings.ini", "IDStream", "qdin", "0")
tlead := IniRead("Settings.ini", "templeader", "tlead", "5")

; --- СОЗДАНИЕ ГЛАВНОГО ИНТЕРФЕЙСА ---
MainGui := Gui("-MaximizeBox", "Varion PR Binder")
MainGui.BackColor := "282b31"
MainGui.SetFont("s9 cWhite", "Bahnschrift")

; Поля ввода (в v2 нужно сохранять переменные элементов для получения их значений)
MainGui.Add("Text", "x7 y300 +0x200", "ID стримера:")
qdin_edit := MainGui.Add("Edit", "x7 y322 w80 h21 +Number cBlack", qdin)

MainGui.Add("Text", "x304 y156 +0x200", "/templeader")
tlead_edit := MainGui.Add("Edit", "x390 y155 w21 h18 +Number cBlack", tlead)

; Картинки-кнопки (в v2 события привязываются через .OnEvent)
MainGui.Add("Picture", "x7 y15 w80 h41", A_ScriptDir "\img\tp.png").OnEvent("Click", (*) => TeleportsGui())
MainGui.Add("Picture", "x7 y65 w80 h41", A_ScriptDir "\img\spis.png").OnEvent("Click", (*) => CommandListGui())
MainGui.Add("Picture", "x7 y115 w80 h41", A_ScriptDir "\img\nak.png").OnEvent("Click", (*) => PunishGui())
MainGui.Add("Picture", "x7 y165 w80 h41", A_ScriptDir "\img\bind.png").OnEvent("Click", (*) => InfoGui())
MainGui.Add("Picture", "x7 y352 w80 h30", A_ScriptDir "\img\save.png").OnEvent("Click", (*) => SaveID())

MainGui.Add("Picture", "x302 y248 w150 h41", A_ScriptDir "\img\pred.png").OnEvent("Click", (*) => InfopredGui())
MainGui.Add("Picture", "x302 y300 w150 h30", A_ScriptDir "\img\spisupdate.png").OnEvent("Click", (*) => FixLogGui())
MainGui.Add("Picture", "x302 y340 w150 h41", A_ScriptDir "\img\saveglobal.png").OnEvent("Click", (*) => SaveOption())

MainGui.Add("Picture", "x100 y9 w184 h27", A_ScriptDir "\img\bindinfo.png")
MainGui.Add("Picture", "x294 y9 w168 h27", A_ScriptDir "\img\auto.png")

; Чекбоксы настроек
cb1 := MainGui.Add("CheckBox", "x304 y50 w120 h23", "/hidecheatinfo")
cb1.Value := Radio1
cb2 := MainGui.Add("CheckBox", "x304 y76 w120 h23", "/zzdebug")
cb2.Value := Radio2
cb3 := MainGui.Add("CheckBox", "x304 y102 w120 h23", "/gm")
cb3.Value := Radio3
cb4 := MainGui.Add("CheckBox", "x304 y128 w120 h23", "/esp3")
cb4.Value := Radio4
cb5 := MainGui.Add("CheckBox", "x420 y154 w20 h23", "") ; невидимый чекбокс рядом с полем ввода
cb5.Value := Radio5
cb6 := MainGui.Add("CheckBox", "x304 y180 w120 h23", "/chide")
cb6.Value := Radio6

; Нижний текст-памятка
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

; --- ФУНКЦИИ КНОПОК И ОКON ---
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
    IniWrite(tlead_edit.Value, "Settings.ini", "templeader", "tlead")
    IniWrite(cb6.Value, "Settings.ini", "Settings", "/chide")
    Reload()
}

InfopredGui() {
    g := Gui(, "Предупреждения")
    g.BackColor := "282b31"
    g.SetFont("s12 cWhite", "Bahnschrift")
    g.Add("GroupBox", "x20 y5 w660 h50 cA52A2A")
    g.Add("Text", "cYellow x250 y23 +0x200", "Предупреждения на стриме:")
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
    g.Add("Text", "cYellow x270 y23 +0x200", "Список изменений:")
    g.Add("Text", "x25 y80 cWhite", "- Актуальная версия Переведена на движок AHK v2 (22.05.2026).")
    g.Add("Text", "x25 y100 cWhite", "По вопросам и ошибкам Discord: Olezhik.ad или Telegram: @olezhikmanager.")
    g.Show("h160 w700")
}

InfoGui() {
    g := Gui(, "Информация о биндере")
    g.BackColor := "282b31"
    g.SetFont("s12 cWhite", "Bahnschrift")
    g.Add("Text", "cYellow x8 y8 h23 +0x200", "Данный Binder создан для облегчения работы PR ассистентов.")
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
    g.Add("Text", "cYellow x8 y450 h20 +0x200", "Ключи")
    g.Add("Text", "x8 y466 h20 +0x200", ".ключ - /ctp -361.424 -129.636 38.696")
    g.Add("Text", "x8 y482 h20 +0x200", ".клг - /ctp -40.529 -1077.648 26.653")
    g.Add("Text", "x8 y498 h20 +0x200", ".клс - /ctp 1728.313 3717.568 34.109")
    g.Add("Text", "x8 y514 h20 +0x200", ".клп - /ctp -196.836 6218.708 31.491")
    g.Add("Text", "cYellow x8 y8 h20 +0x200", "Респавны фракций")
    g.Add("Text", "x8 y24 h20 +0x200", ".лспд - /ctp 429 -980 30.50")
    g.Add("Text", "x8 y40 h20 +0x200", ".бол - /ctp 287.70 -578.35 50")
    g.Add("Text", "x8 y56 h20 +0x200", ".шд - /ctp -434.87 6024.54 31.50")
    g.Add("Text", "x8 y72 h20 +0x200", ".шд2 - /ctp 1843.770 3666.384 33.760")
    g.Add("Text", "x8 y88 h20 +0x200", ".фз - /ctp -2336 3257 32.50")
    g.Add("Text", "x8 y104 h20 +0x200", ".мэр - /ctp -534.70 -222.07 37.60")
    g.Add("Text", "x8 y120 h20 +0x200", ".визл - /ctp -593 -929 24")
    g.Add("Text", "x8 y136 h20 +0x200", ".фиб - /ctp 2527 -377 93")
    g.Add("Text", "x8 y152 h20 +0x200", ".бал - /ctp -70.06 -1824.64 26.94")
    g.Add("Text", "x8 y168 h20 +0x200", ".ваг - /ctp 967 -1817 31")
    g.Add("Text", "x8 y184 h20 +0x200", ".фэм - /ctp -204.29 -1513.69 31.60")
    g.Add("Text", "x8 y200 h20 +0x200", ".бладс - /ctp 496 -1330 29.40")
    g.Add("Text", "x8 y216 h20 +0x200", ".мара - /ctp 1437.61 -1509.64 62.40")
    g.Add("Text", "x8 y232 h20 +0x200", ".лкн - /ctp 1385 1154 114.40")
    g.Add("Text", "x8 y248 h20 +0x200", ".рм - /ctp -1526 858 181")
    g.Add("Text", "x8 y264 h20 +0x200", ".як - /ctp -1556.36 113.07 57")
    g.Add("Text", "x8 y280 h20 +0x200", ".мекс - /ctp 381.03 23.12 91.40")
    g.Add("Text", "x8 y296 h20 +0x200", ".ир - /ctp -3028.926 100.118 11.614")
    g.Add("Text", "x8 y312 h20 +0x200", ".лост - /ctp 969.84 -128.40 74.40")
    g.Add("Text", "x8 y328 h20 +0x200", ".аод - /ctp 1995.99 3062.44 47.06")
    g.Add("Text", "x8 y344 h20 +0x200", ".ам - /ctp -1895.23 2027.19 141")
    g.Add("Text", "x8 y360 h20 +0x200", ".груб - /ctp -3022 105 11.30")
    g.Add("Text", "x8 y376 h20 +0x200", ".клаб - /ctp 1588.65 6445.38 25")
    g.Add("Text", "x8 y392 h20 +0x200", ".рич - /ctp -1302.49 294.52 64.50")
    g.Add("Text", "x8 y408 h20 +0x200", ".манор - /ctp -58.20 343.73 111.80")
    g.Add("Text", "x8 y424 h20 +0x200", ".15 - /ctp -712.42 -366.30 33.90")
    g.Add("Text", "cYellow x280 y8 h20 +0x200", "Места")
    g.Add("Text", "x280 y24 h20 +0x200", ".хум - /ctp 3569.54 3789.48 30")
    g.Add("Text", "x280 y40 h20 +0x200", ".мейз - /ctp -75 -818 326")
    g.Add("Text", "x280 y56 h20 +0x200", ".каз - /ctp 1110.117 217.0512 -49.56448")
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

; --- ГОРЯЧИЕ СТРОКИ И ОТИГРЫШИ ---
::.ку::Привет, сегодня я слежу за тобой. Хорошего стрима
::.привет::Приветствую, на сегодня я ваш ассистент, по любым игровым вопросам - обращайтесь ко мне.
::.кпз::Напомню, что как либо контактировать с игроками которые вели процессуальные действия - запрещено.
::.авто::Напомню, что краймить на выданном авто нельзя, если заглохнет, то завести можно будет только отверткой.
::.искин::Правила не нарушать, RP моменты существенные для скина поддерживать. Будут жалобы - Вас кикнут/накажут. После окончания записи, нужно перезайти на server, чтобы снять скин.
::.замена::К сожалению, мне нужно тебя покинуть, меня заменит другой Ассистент. Хорошего продолжения стрима
::.пока::Спасибо за стрим, хорошего настроения.
::.од::Предоставьте одобрение в личные сообщения.
::.не::Не нарушайте

; Быстрые команды с автоподстановкой ID
:X:.1п:: {
    A_Clipboard := ""
    SendInput("/asms " qdin_edit.Value " 1/3 предупреждений за ")
}
:X:.2п:: {
    A_Clipboard := ""
    SendInput("/asms " qdin_edit.Value " 2/3 предупреждений за ")
}
:X:.3п:: {
    A_Clipboard := ""
    SendInput("/asms " qdin_edit.Value " 3/3 предупреждений за .Если продолжешь нарушать, будет полноценное наказание. {left 56}")
}
