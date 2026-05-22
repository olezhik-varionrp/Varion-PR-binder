#Requires AutoHotkey v2.0
#SingleInstance Force
A_IconHidden := 1  ; Намертво отключаем стандартную зеленую иконку в v2

titlcolor := "df005c"

; Чтение настроек из INI
Radio1 := IniRead("Settings.ini", "Settings", "/hidecheatinfo", "0")
Radio2 := IniRead("Settings.ini", "Settings", "/zzdebug", "0")
Radio3 := IniRead("Settings.ini", "Settings", "/gm", "0")
Radio4 := IniRead("Settings.ini", "Settings", "/esp3", "0")
Radio5 := IniRead("Settings.ini", "Settings", "/templeader", "0")
Radio6 := IniRead("Settings.ini", "Settings", "/chide", "0")

qdin := IniRead("Settings.ini", "IDStream", "qdin", "0")
tlead := IniRead("Settings.ini", "templeader", "tlead", "5")

; --- ГЛАВНЫЙ ИНТЕРФЕЙС ---
MainGui := Gui("-MaximizeBox", "Varion PR Binder")
MainGui.BackColor := "282b31"
MainGui.SetFont("s9 cWhite", "Bahnschrift")

MainGui.Add("Text", "x7 y300 +0x200", "ID стримера:")
qdin_edit := MainGui.Add("Edit", "x7 y322 w80 h21 +Number cBlack", qdin)

MainGui.Add("Text", "x304 y156 +0x200", "/templeader")
tlead_edit := MainGui.Add("Edit", "x390 y155 w21 h18 +Number cBlack", tlead)

; Кнопки-картинки из оперативной памяти напрямую с GitHub
MainGui.Add("Picture", "x7 y15 w80 h41", LoadImgMem("tp.png")).OnEvent("Click", (*) => TeleportsGui())
MainGui.Add("Picture", "x7 y65 w80 h41", LoadImgMem("spis.png")).OnEvent("Click", (*) => CommandListGui())
MainGui.Add("Picture", "x7 y115 w80 h41", LoadImgMem("nak.png")).OnEvent("Click", (*) => PunishGui())
MainGui.Add("Picture", "x7 y165 w80 h41", LoadImgMem("bind.png")).OnEvent("Click", (*) => InfoGui())
MainGui.Add("Picture", "x7 y352 w80 h30", LoadImgMem("save.png")).OnEvent("Click", (*) => SaveID())

MainGui.Add("Picture", "x302 y248 w150 h41", LoadImgMem("pred.png")).OnEvent("Click", (*) => InfopredGui())
MainGui.Add("Picture", "x302 y300 w150 h30", LoadImgMem("spisupdate.png")).OnEvent("Click", (*) => FixLogGui())
MainGui.Add("Picture", "x302 y340 w150 h41", LoadImgMem("saveglobal.png")).OnEvent("Click", (*) => SaveOption())

MainGui.Add("Picture", "x100 y9 w184 h27", LoadImgMem("bindinfo.png"))
MainGui.Add("Picture", "x294 y9 w168 h27", LoadImgMem("auto.png"))

; Чекбоксы
cb1 := MainGui.Add("CheckBox", "x304 y50 w120 h23", "/hidecheatinfo")
cb1.Value := Radio1
cb2 := MainGui.Add("CheckBox", "x304 y76 w120 h23", "/zzdebug")
cb2.Value := Radio2
cb3 := MainGui.Add("CheckBox", "x304 y102 w120 h23", "/gm")
cb3.Value := Radio3
cb4 := MainGui.Add("CheckBox", "x304 y128 w120 h23", "/esp3")
cb4.Value := Radio4
cb5 := MainGui.Add("CheckBox", "x420 y154 w20 h23", "")
cb5.Value := Radio5
cb6 := MainGui.Add("CheckBox", "x304 y180 w120 h23", "/chide")
cb6.Value := Radio6

; Памятка
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
    g.Add("Text", "cee5180 x280 y8 h20 +0x200", "Места")
    g.Add("Text", "x280 y24 h20 +0x200", ".хум - /ctp 3569.54 3789.48 30")
    g.Add("Text", "x280 y40 h20 +0x200", ".мейз - /ctp -75 -818 326")
    g.Add("Text", "x280 y56 h20 +0x200", ".каз - /ctp 1110.117 217.0512 -49.56448")
    g.Add("Text", "x280 y72 h20 +0x200", ".аш - /ctp -620 -2264 6")
    g.Add("Text", "x280 y88 h20 +0x200", ".гг - /ctp -257 -2023 30")
    g.Add("Text", "x280 y104 h20 +0x200", ".бургер - /ctp -1171.31 -890.20 13.90")
    g.Add("Text", "x280 y120 h20 +0x200", ".багама - /ctp -1391.30 -585.35 30")
    g.Add("Text", "x280 y136 h20 +0x200", ".кайо - /ctp 4488.58 -4493.52 4")
    g.Add("Text", "x280 y152 h20 +0x200", ".авиа - /ctp 3035.21 -4688.55 15")
    g.Add("Text", "x280 y168 h20 +0x200", ".мол - /ctp 61.67 -1751.80 47")
    g.Add("Text", "x280 y184 h20 +0x200", ".трас - /ctp 7400 3946 1124")
    g.Add("Text", "x280 y200 h20 +0x200", ".трасс - /ctp 7400 -656 1124")
    g.Add("Text", "x280 y216 h20 +0x200", ".аук - /ctp -833 -699.50 27")
    g.Add("Text", "x280 y232 h20 +0x200", ".бокс - /ctp 8.56 -1658.55 28.71")
    g.Add("Text", "x280 y248 h20 +0x200", ".бар - /ctp -305.09 6259.59 30.92")
    g.Add("Text", "x280 y264 h20 +0x200", ".бк - /ctp 500.44 109.79 96.49")
    g.Add("Text", "x280 y280 h20 +0x200", ".ванила - /ctp 131.33 -1302.93 29.23")
    g.Add("Text", "x280 y296 h20 +0x200", ".починка - /ctp -1430.45 -450.5 35.91")
    g.Add("Text", "x280 y312 h20 +0x200", ".сэнди - /ctp 1843.770 3666.384 33.760")
    g.Add("Text", "x280 y328 h20 +0x200", ".порт - /ctp 417 -2501 13.46")
    g.Add("Text", "x280 y344 h20 +0x200", ".стр - /ctp 1304 1453 98.87")
    g.Add("Text", "x280 y360 h20 +0x200", ".лес - /ctp -321 6093 31.14")
    g.Add("Text", "x280 y376 h20 +0x200", ".бмара - /ctp 1302 -1646 51.04")
    g.Add("Text", "x280 y392 h20 +0x200", ".самол - /ctp 1473 2730 37.38")
    g.Add("Text", "x280 y408 h20 +0x200", ".чил - /ctp 498 5592 795")
    g.Add("Text", "x280 y424 h20 +0x200", ".палето - /ctp -434.87 6024.54 31.50")
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
    g.Add("Text", "x8 y72 h20 +0x200", ".ифтсрусл - /bancheck")
    g.Add("Text", "x8 y88 h20 +0x200", ".фофшдсрусл - /ajailcheck")
    g.Add("Text", "x8 y104 h20 +0x200", "/tf - /tempfamily")
    g.Add("Text", "x8 y120 h20 +0x200", ".еа - /tempfamily")
    g.Add("Text", "x8 y136 h20 +0x200", "/sm - /setmaterials")
    g.Add("Text", "x8 y152 h20 +0x200", ".ыь - /setmaterials")
    g.Add("Text", "x8 y168 h20 +0x200", "/tn - /tempname")
    g.Add("Text", "x8 y184 h20 +0x200", ".ет - /tempname")
    g.Add("Text", "x8 y200 h20 +0x200", ".яяв - /zzdebug")
    g.Add("Text", "x8 y216 h20 +0x200", "/zzd - /zzdebug")
    g.Add("Text", "x8 y232 h20 +0x200", "/amph - /addamphitheater")
    g.Add("Text", "x8 y248 h20 +0x200", ".фьзр - /addamphitheater")
    g.Add("Text", "x8 y264 h20 +0x200", "/ramph - /removeamphitheater")
    g.Add("Text", "x8 y280 h20 +0x200", ".кфьзр - /removeamphitheater")
    g.Add("Text", "x8 y296 h20 +0x200", "/gzone - /togglegreenzone")
    g.Add("Text", "x8 y312 h20 +0x200", ".пящту - /togglegreenzone")
    g.Add("Text", "x8 y328 h20 +0x200", "/mcheck - /mutecheck")
    g.Add("Text", "x8 y344 h20 +0x200", ".ьсрусл - /mutecheck")
    g.Add("Text", "x8 y360 h20 +0x200", ".ьгеусрусл - /mutecheck")
    g.Add("Text", "x8 y376 h20 +0x200", ".гтофшд - /unjail")
    g.Add("Text", "x8 y392 h20 +0x200", ".цфкт - /warn")
    g.Add("Text", "x8 y408 h20 +0x200", ".дв - /lastdriver")
    g.Add("Text", "x8 y424 h20 +0x200", "/ld - /lastdriver")
    g.Add("Text", "x8 y440 h20 +0x200", "/af - /ainfect")
    g.Add("Text", "x8 y456 h20 +0x200", ".фа - /ainfect")
    g.Add("Text", "x8 y472 h20 +0x200", "/sk - /skick")
    g.Add("Text", "x8 y488 h20 +0x200", ".ыл - /skick")
    g.Add("Text", "x8 y504 h20 +0x200", "/k - /kick")
    g.Add("Text", "x8 y520 h20 +0x200", ".л - /kick")
    g.Add("Text", "x8 y536 h20 +0x200", "/ai - /auninvite")
    g.Add("Text", "x8 y552 h20 +0x200", ".фш - /auninvite")
    g.Add("Text", "x8 y568 h20 +0x200", ".аи - /fb")
    g.Add("Text", "x8 y584 h20 +0x200", "/aif - /ainfect")
    g.Add("Text", "x8 y600 h20 +0x200", ".фша - /ainfect")
    g.Add("Text", "x8 y616 h20 +0x200", ".с - /c")
    g.Add("Text", "x8 y632 h20 +0x200", ".си - /cb")
    g.Add("Text", "x8 y648 h20 +0x200", ".гтьгеу - /unmute")
    g.Add("Text", "x8 y664 h20 +0x200", ".пшв - /gid")
    g.Add("Text", "x8 y680 h20 +0x200", ".фвьшты - /admins")
    g.Add("Text", "x8 y696 h20 +0x200", ".фштаусе - /ainfect")
    g.Add("Text", "x8 y712 h20 +0x200", ".умутещт - /eventon")
    g.Add("Text", "x8 y728 h20 +0x200", ".умутещаа - /eventoff")
    g.Add("Text", "x8 y744 h20 +0x200", ".пц - /gw")
    g.Add("Text", "x8 y760 h20 +0x200", ".мурыефе - /vehstat")

    g.Add("Text", "x210 y8 h20 +0x200", ".мур - /veh")
    g.Add("Text", "x210 y24 h20 +0x200", ".ашчсфк - /fixcar")
    g.Add("Text", "x210 y40 h20 +0x200", ".уьздуфвук - /templeader")
    g.Add("Text", "x210 y56 h20 +0x200", "/tl - /templeader")
    g.Add("Text", "x210 y72 h20 +0x200", ".ед - /templeader")
    g.Add("Text", "x210 y88 h20 +0x200", ".ылшсл - /skick")
    g.Add("Text", "x210 y104 h20 +0x200", ".кузфшк - /repair")
    g.Add("Text", "x210 y120 h20 +0x200", ".фгтшмшеу - /auninvite")
    g.Add("Text", "x210 y136 h20 +0x200", ".учсфк - /excar")
    g.Add("Text", "x210 y152 h20 +0x200", ".агуд - /fuel")
    g.Add("Text", "x210 y168 h20 +0x200", ".акууяу - /freeze")
    g.Add("Text", "x210 y200 h20 +0x200", ".згддекгтл - /pulltrunk")
    g.Add("Text", "x210 y216 h20 +0x200", ".езсфк - /tpcar")
    g.Add("Text", "x210 y232 h20 +0x200", ".дфыевкшмук - /lastdriver")
    g.Add("Text", "x210 y248 h20 +0x200", ".вудшеуь - /delitem")
    g.Add("Text", "x210 y264 h20 +0x200", "/gc - /getcar")
    g.Add("Text", "x210 y184 h20 +0x200", ".пиздец - Мольба о помощи")
    g.Add("Text", "x210 y280 h20 +0x200", ".пс - /getcar")
    g.Add("Text", "x210 y296 h20 +0x200", ".фв - /admins")
    g.Add("Text", "x210 y312 h20 +0x200", "/ad - /admins")
    g.Add("Text", "x210 y328 h20 +0x200", ".з - /players")
    g.Add("Text", "x210 y344 h20 +0x200", "/p - /players")
    g.Add("Text", "x210 y360 h20 +0x200", ".здфнукы - /players")
    g.Add("Text", "x210 y376 h20 +0x200", ".рес - /rescue")
    g.Add("Text", "x210 y392 h20 +0x200", "/htc - /rescue")
    g.Add("Text", "x210 y408 h20 +0x200", ".ез - /tp")
    g.Add("Text", "x210 y424 h20 +0x200", ".ызус - /spec")
    g.Add("Text", "x210 y440 h20 +0x200", ".ызусщаа - /specoff")
    g.Add("Text", "x210 y456 h20 +0x200", ".ф - /a")
    g.Add("Text", "x210 y472 h20 +0x200", ".фыьы - /asms")
    g.Add("Text", "x210 y488 h20 +0x200", "/sp - /spec")
    g.Add("Text", "x210 y504 h20 +0x200", ".ыз - /spec")
    g.Add("Text", "x210 y520 h20 +0x200", "/so - /specoff")
    g.Add("Text", "x210 y536 h20 +0x200", ".ыщ - /specoff")
    g.Add("Text", "x210 y552 h20 +0x200", "/kill - /hp 0")
    g.Add("Text", "x210 y568 h20 +0x200", ".лшдд - /hp 0")
    g.Add("Text", "x210 y584 h20 +0x200", ".пр - /gh")
    g.Add("Text", "x210 y600 h20 +0x200", ".штсфк - /incar")
    g.Add("Text", "x210 y616 h20 +0x200", ".штм - /inv")
    g.Add("Text", "x210 y632 h20 +0x200", ".рз - /hp")
    g.Add("Text", "x210 y648 h20 +0x200", ".шв - /id")
    g.Add("Text", "x210 y664 h20 +0x200", ".од - /ajail")
    g.Add("Text", "x210 y680 h20 +0x200", ".фофшд - /ajail")
    g.Add("Text", "x210 y696 h20 +0x200", ".лшсл - /kick")
    g.Add("Text", "x210 y712 h20 +0x200", ".вд - /dl")
    g.Add("Text", "x210 y728 h20 +0x200", ".уыз - /esp")
    g.Add("Text", "x210 y744 h20 +0x200", ".уыз2 - /esp2")
    g.Add("Text", "x210 y760 h20 +0x200", ".уыз3 - /esp3")

    g.Add("Text", "x410 y8 h20 +0x200", ".пуесфк - /getcar")
    g.Add("Text", "x410 y24 h20 +0x200", ".ифт - /ban")
    g.Add("Text", "x410 y40 h20 +0x200", ".вудмур - /delveh")
    g.Add("Text", "x410 y56 h20 +0x200", ".ьез - /mtp")
    g.Add("Text", "x410 y72 h20 +0x200", ".мур - /veh")
    g.Add("Text", "x410 y88 h20 +0x200", ".фмур - /aveh")
    g.Add("Text", "x410 y104 h20 +0x200", ".рфквифт - /hardban")
    g.Add("Text", "x410 y120 h20 +0x200", ".ьгеу - /mute")
    g.Add("Text", "x410 y136 h20 +0x200", ".пшв - /gid")
    g.Add("Text", "x410 y152 h20 +0x200", ".ср - /chide")
    g.Add("Text", "x410 y168 h20 +0x200", "/ch - /chide")
    g.Add("Text", "x410 y184 h20 +0x200", ".куысгу - /rescue")
    g.Add("Text", "x410 y200 h20 +0x200", ".ыуевшь - /setdim")
    g.Add("Text", "x410 y216 h20 +0x200", "/sd - /setdim")
    g.Add("Text", "x410 y232 h20 +0x200", ".и - /b")
    g.Add("Text", "x410 y248 h20 +0x200", ".ц - /w")
    g.Add("Text", "x410 y264 h20 +0x200", ".ыв - /setdim")
    g.Add("Text", "x410 y280 h20 +0x200", ".сршву - /chide")
    g.Add("Text", "x410 y296 h20 +0x200", ".афк - /a афк мин")
    g.Add("Text", "x410 y312 h20 +0x200", ".фгтсгаа - /auncuff")
    g.Add("Text", "x410 y328 h20 +0x200", ".фсгаа - /acuff")
    g.Add("Text", "x410 y344 h20 +0x200", ".акууямур - /freezveh")
    g.Add("Text", "x410 y360 h20 +0x200", "/scd - /setcardim")
    g.Add("Text", "x410 y376 h20 +0x200", ".ыуесфквшь - /setcardim")
    g.Add("Text", "x410 y392 h20 +0x200", ".ысв - /setcardim")
    g.Add("Text", "x410 y408 h20 +0x200", "/rst - /resettempname")
    g.Add("Text", "x410 y424 h20 +0x200", ".кые - /resettempname")
    g.Add("Text", "x410 y440 h20 +0x200", ".куыуееуьзтфьу - /resettempname")
    g.Add("Text", "x410 y456 h20 +0x200", ".т - /netstat")
    g.Add("Text", "x410 y472 h20 +0x200", "/n - /netstat")
    g.Add("Text", "x410 y488 h20 +0x200", "/dv - /delveh")
    g.Add("Text", "x410 y504 h20 +0x200", ".вм - /delveh")
    g.Add("Text", "x410 y520 h20 +0x200", ".рфкв - /hardban")
    g.Add("Text", "x410 y536 h20 +0x200", "/hard - /hardban")
    g.Add("Text", "x410 y552 h20 +0x200", "/as - /asms")
    g.Add("Text", "x410 y568 h20 +0x200", ".фы - /asms")
    g.Add("Text", "x410 y584 h20 +0x200", ".пез - /gtp")
    g.Add("Text", "x410 y600 h20 +0x200", ".пь - /gm")
    g.Add("Text", "x410 y616 h20 +0x200", ".тс - /noclip")
    g.Add("Text", "x410 y632 h20 +0x200", "/nc - /noclip")
    g.Add("Text", "x410 y648 h20 +0x200", "/acf - /acuff")
    g.Add("Text", "x410 y664 h20 +0x200", ".фса - /acuff")
    g.Add("Text", "x410 y680 h20 +0x200", "/auf - /auncuff")
    g.Add("Text", "x410 y696 h20 +0x200", ".езр - /tph")
    g.Add("Text", "x410 y712 h20 +0x200", ".фга - /auncuff")
    g.Add("Text", "x410 y728 h20 +0x200", ".фмур - /aveh")
    g.Add("Text", "x410 y744 h20 +0x200", ".фдщсл - /alock")
    g.Add("Text", "x410 y760 h20 +0x200", ".гб - /gunban")
    g.Show("h780 w640")
}

PunishGui() {
    g := Gui(, "Наказания")
    g.BackColor := "300b31"
    g.SetFont("s10 cWhite", "Bahnschrift")
    g.Add("Text", "x8 y8 h20 +0x200", ".чит - /hardban 8888 Cheats")
    g.Add("Text", "x8 y24 h20 +0x200", ".запретка - /ban 3.5 ОПС")
    g.Add("Text", "x8 y40 h20 +0x200", ".звук - /mute 120 Мешающие звуки")
    g.Add("Text", "x8 y56 h20 +0x200", ".помеха - /ajail 10 3.6.2 ОПС")
    g.Add("Text", "x8 y72 h20 +0x200", ".кик - /kick 3.6.2 ОПС")
    g.Add("Text", "x8 y88 h20 +0x200", ".бан - /ban")
    g.Add("Text", "x8 y104 h20 +0x200", ".дем - /ajail")
    g.Add("Text", "x8 y120 h20 +0x200", ".мут - /mute")
    g.Add("Text", "x8 y136 h20 +0x200", ".варн - /warn")
    g.Add("Text", "x8 y152 h20 +0x200", ".хард - /hardban")
    g.Add("Text", "x8 y168 h20 +0x200", ".нрд - /ajail 15 nonRP Drive")
    g.Add("Text", "x8 y184 h20 +0x200", ".нрп - /ajail 15 nonRP Поведение")
    g.Add("Text", "x8 y200 h20 +0x200", ".дб - /ajail 30 DB")
    g.Add("Text", "x8 y216 h20 +0x200", ".дм - /gunban 5 DM")
    g.Add("Text", "x8 y232 h20 +0x200", ".дмд - /ajail 120 DM")
    g.Add("Text", "x8 y248 h20 +0x200", ".пг - /ajail 35 PG")
    g.Add("Text", "x8 y264 h20 +0x200", ".муз - /mute 30 Music in ZZ")
    g.Add("Text", "x8 y280 h20 +0x200", ".смник - /ajail 720 Смените Имя_Фамилия...")
    g.Add("Text", "x8 y296 h20 +0x200", ".оскадм - /ban 5 Оскорбление администрации")
    g.Show("h320 w320")
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
::.лвл::При достижении 5-го уровня: 500 MC, при достижении 10-го уровня: 1000 MC, при достижении 15-го уровня: 2000 MC, при достижении 20-го уровня: 3000 MC, при достижении 25-го уровня: 4000 MC, при достижении 30-го уровня: 5000 MC. Каждый следующий уровень после 30-го будешь получать 1500 MC.
::.лвл5::При достижении 5-го уровня: 500 MC.
::.лвл10::При достижении 10-го уровня: 1000 MC.
::.лвл15::При достижении 15-го уровня: 2000 MC.
::.лвл20::При достижении 20-го уровня: 3000 MC.
::.лвл25::При достижении 25-го уровня: 4000 MC
::.лвл30::При достижении 30-го уровня: 5000 MC. Каждый следующий уровень после 30-го будешь получать 1500 MC.
::.пом::Сейчас помогу.
::/gjv::Сейчас помогу.
::.ключ::/ctp -382.57 -126.32 38.24
::.15::/ctp -712.42 -366.30 33.90

; Горячие клавиши автоматического динамика
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

; Телепорты короткие команды (в v2 пишется как обычные горячие строки)
::.лспд::/ctp 429 -980 30.50
::.бол::/ctp 287.70 -578.35 50
::.шд::/ctp -434.87 6024.54 31.50
::.фз::/ctp -2336 3257 32.50
::.мэр::/ctp -534.70 -222.07 37.60
::.визл::/ctp -593 -929 24
::.фиб::/ctp 2527 -377 93
::.бал::/ctp -70.06 -1824.64 26.94
::.ваг::/ctp 967 -1817 31
::.фэм::/ctp -204.29 -1513.69 31.60
::.бладс::/ctp 496 -1330 29.40
::.мара::/ctp 983.018 -2496.230 28.769
::.лкн::/ctp 1385 1154 114.40
::.рм::/ctp -1526 858 181
::.як::/ctp -1556.36 113.07 57
::.мекс::/ctp 381.03 23.12 91.40
::.ам::/ctp -1895.23 2027.19 141
::.лост::/ctp 969.84 -128.40 74.40
::.аод::/ctp 1995.99 3062.44 47.06
::.ириш::/ctp -3022 105 11.30
::.клаб::/ctp 1588.65 6445.38 25
::.рич::/ctp -1302.49 294.52 64.50
::.манор::/ctp -58.20 343.73 111.80
::.конт::/ctp -1865.51 -355.96 57
::.хум::/ctp 3569.54 3789.48 30
::.мейз::/ctp -75 -818 326
::.каз::/ctp 1110.117 217.0512 -49.56448
::.аш::/ctp -620 -2264 6
::.гг::/ctp -257 -2023 30
::.бургер::/ctp -1171.31 -890.20 13.90
::.багама::/ctp -1391.30 -585.35 30
::.кайо::/ctp 4488.58 -4493.52 4
::.авиа::/ctp 3035.21 -4688.55 15
::.мол::/ctp 61.67 -1751.80 47
::.трас::/ctp 7400 3946 1124
::.аук::/ctp -833 -699.50 27
::.бокс::/ctp 8.56 -1658.55 28.71
::.бар::/ctp -305.09 6259.59 30.92
::.бк::/ctp 500.44 109.79 96.49
::.ванила::/ctp 131.33 -1302.93 29.23
::.починка::/ctp -1430.45 -450.5 35.91
::.лск4::/ctp 1175.47 2671.33 37.85
::.порт::/ctp 417 -2501 13.46
::.стр::/ctp 1304 1453 98.87
::.лес::/ctp -321 6093 31.14
::.бмара::/ctp 1302 -1646 51.04
::.самол::/ctp 1473 2730 37.38

::.чит::/hardban 9999 Cheats
::/xbn::/hardban 9999 Cheats
::.варн::/warn
::/dfhy::/warn
::.мут::/mute
::/ven::/mute
::.дем::/ajail
::/ltv::/ajail
::.бан::/ban
::/,fy::/ban
::.хард::/hardban
::/[fhl::/hardban
::.гб::/gunban
::/u,::/gunban
::.пгтифт::/gunban
::.запретка::/ban 3.5 ОПС
::/pfghtnrf::/ban 3.5 ОПС
::.звук::/mute 120 Мешающие звуки
::/pder::/mute 120 Мешающие звуки
::.помеха::/ajail 10 3.6.2 ОПС
::/gjvt[f::/ajail 10 3.6.2 ОПС
::.кик::/kick 3.6.2 ОПС
::/rbr::/kick 3.6.2 ОПС
::.нрд::/ajail 15 nonRP Drive
::.нрп::/ajail 15 nonRP Поведение
::.дб::/ajail 30 DB
::.дм::/gunban 5 DM
::.дмд::/ajail 120 DM
::.пг::/ajail 35 PG
::.муз::/mute 30 Music in ZZ
::.смник::/ajail 720 Смените Имя_Фамилия согласно правилам сервера
::.оскадм::/ban 5 Оскорбление администрации
::.верт::/veh sparrowc 0 0
::/dthn::/veh sparrowc 0 0
::.маш::/veh bdivo 0 0
::/vfi::/veh bdivo 0 0
::.скин::/skin
