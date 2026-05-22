; ========================================================== PR ASSISTANT BINDER ==========================================================
#SingleInstance, Force
#UseHook
#NoEnv
SetWorkingDir %A_ScriptDir%
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0

titlcolor = df005c   ; Цвет заголовка (HEX-код)

;===========================================================================================================================================================
; Основная среда ==============================================================================================================================

SplashTextoff
ListLines Off
Process, Priority, , A
SetMouseDelay, -1
SetDefaultMouseSpeed, 0

SkillsList = Скилы
Cheatsheet = Меню памятки

; Изображения в меню
icon_img = %A_ScriptDir%\img\icon.png
IfExist, %icon_img%
Menu, Tray, Icon, %icon_img%

Gui, 2: -MaximizeBox
Gui, 2: Show, w470 h520, PR-Assistant Binder
Gui, 2: Color, 282b31
Gui, 2: Font, s9,
Gui, 2: Font, cWhite,Bahnschrift

Menu, Tray, add, Показать, Show,
Menu, Tray, Default, Показать,
Menu, Tray, add, Скрыть, Hide,
Menu, Tray, add, Закрыть, Close,
Menu, Tray, NoStandard

IniRead, Radio1, Settings.ini, Settings, /hidecheatinfo
IniRead, Radio2, Settings.ini, Settings, /zzdebug
IniRead, Radio3, Settings.ini, Settings, /gm
IniRead, Radio4, Settings.ini, Settings, /esp3
IniRead, Radio5, Settings.ini, Settings, /templeader
IniRead, Radio6, Settings.ini, Settings, /chide

IniRead, key1, Settings.ini, KeySetup, KEY1
IniRead, key2, Settings.ini, KeySetup, KEY2
IniRead, key3, Settings.ini, KeySetup, KEY3
IniRead, key4, Settings.ini, KeySetup, KEY4
IniRead, key5, Settings.ini, KeySetup, KEY5
IniRead, key6, Settings.ini, KeySetup, KEY6
IniRead, key7, Settings.ini, KeySetup, KEY7
IniRead, key8, Settings.ini, KeySetup, KEY8
IniRead, key9, Settings.ini, KeySetup, KEY9
IniRead, key10, Settings.ini, KeySetup, KEY10
IniRead, key11, Settings.ini, KeySetup, KEY11
IniRead, key12, Settings.ini, KeySetup, KEY12
IniRead, key13, Settings.ini, KeySetup, KEY13
IniRead, key14, Settings.ini, KeySetup, KEY14
IniRead, qdin, Settings.ini, IDStream, qdin
IniRead, tlead, Settings.ini, templeader, tlead
IniRead, qx2, Settings.ini, Coords, qx2
IniRead, qx2, Settings.ini, Coords, qy2
if tlead=ERROR
{
IniWrite, 0, Settings.ini, IDStream, qdin
IniWrite, 5, Settings.ini, templeader, tlead
IniWrite, 10, Settings.ini, Coords, qx2
IniWrite, 500, Settings.ini, Coords, qy2
reload
}

Hotkey, %KEY1%, Off, UseErrorLevel
Hotkey, %KEY1%, asms, On, UseErrorLevel
Hotkey, %KEY2%, Off, UseErrorLevel
Hotkey, %KEY2%, setdim1, On, UseErrorLevel
Hotkey, %KEY3%, Off, UseErrorLevel
Hotkey, %KEY3%, setdim0, On, UseErrorLevel
Hotkey, %KEY4%, Off, UseErrorLevel
Hotkey, %KEY4%, cheat, On, UseErrorLevel
Hotkey, %KEY5%, Off, UseErrorLevel
Hotkey, %KEY5%, banword, On, UseErrorLevel
Hotkey, %KEY6%, Off, UseErrorLevel
Hotkey, %KEY6%, tpmedia, On, UseErrorLevel
Hotkey, %KEY7%, Off, UseErrorLevel
Hotkey, %KEY7%, tleader, On, UseErrorLevel
Hotkey, %KEY8%, Off, UseErrorLevel
Hotkey, %KEY8%, hp, On, UseErrorLevel
Hotkey, %KEY9%, Off, UseErrorLevel
Hotkey, %KEY9%, resc, On, UseErrorLevel
Hotkey, %KEY10%, Off, UseErrorLevel
Hotkey, %KEY10%, spec, On, UseErrorLevel
Hotkey, %KEY11%, Off, UseErrorLevel
Hotkey, %KEY11%, specoff, On, UseErrorLevel
Hotkey, %KEY12%, Off, UseErrorLevel
Hotkey, %KEY12%, repair, On, UseErrorLevel
Hotkey, %KEY13%, Off, UseErrorLevel
Hotkey, %KEY13%, Cheatsheet, On, UseErrorLevel
Hotkey, %KEY14%, Off, UseErrorLevel
Hotkey, %KEY14%, vhod, On, UseErrorLevel

Gui, 2: Add, Edit,   x7 y322 w80 h21 +Number vqdin cblack, %qdin%
Gui, 2: Add, Picture, x7 y15 w80 h41 gTeleports, %A_ScriptDir%\img\tp.png
Gui, 2: Add, Picture, x7 y65 w80 h41 gCommandList, %A_ScriptDir%\img\spis.png
Gui, 2: Add, Picture, x7 y115 w80 h41 gPunish, %A_ScriptDir%\img\nak.png
Gui, 2: Add, Picture, x7 y165 w80 h41 gInfo, %A_ScriptDir%\img\bind.png
Gui, 2: Add, Picture, x7 y352 w80 h30 gSaveID, %A_ScriptDir%\img\save.png

Gui, 2: Add, Picture, x302 y248 w150 h41 ginfopred, %A_ScriptDir%\img\pred.png
Gui, 2: Add, Picture, x302 y300 w150 h30 gFixLog, %A_ScriptDir%\img\spisupdate.png
Gui, 2: Add, Picture, x302 y340 w150 h41 gSaveOption, %A_ScriptDir%\img\saveglobal.png

Gui, 2: Add, Picture, x100 y9 w184 h27, %A_ScriptDir%\img\bindinfo.png
Gui, 2: Add, Picture, x294 y9 w168 h27, %A_ScriptDir%\img\auto.png

Gui, 2: Add, Text, x7 y300 +0x200, ID стримера:
Gui, 2: Add, Edit, x390 y155 w21 h18 +Number vtlead cblack, %tlead%

Gui, 2: Add, Hotkey, x110 y50 w48 h21 vHot1, %KEY1%
Gui, 2: Add, Hotkey, x110 y76 w48 h21 vHot2, %KEY2%
Gui, 2: Add, Hotkey, x110 y102 w48 h21 vHot3, %KEY3%
Gui, 2: Add, Hotkey, x110 y128 w48 h21 vHot4, %KEY4%
Gui, 2: Add, Hotkey, x110 y154 w48 h21 vHot5, %KEY5%
Gui, 2: Add, Hotkey, x110 y180 w48 h21 vHot6, %KEY6%
Gui, 2: Add, Hotkey, x110 y206 w48 h21 vHot7, %KEY7%
Gui, 2: Add, Hotkey, x110 y232 w48 h21 vHot8, %KEY8%
Gui, 2: Add, Hotkey, x110 y258 w48 h21 vHot9, %KEY9%
Gui, 2: Add, Hotkey, x110 y284 w48 h21 vHot10, %KEY10%
Gui, 2: Add, Hotkey, x110 y310 w48 h21 vHot11, %KEY11%
Gui, 2: Add, Hotkey, x110 y336 w48 h21 vHot12, %KEY12%
Gui, 2: Add, Hotkey, x110 y362 w48 h21 vHot13, %KEY13%
Gui, 2: Add, Hotkey, x303 y212 w40 h21 vHot14, %KEY14%

Gui, 2: Add, Text, x163 y53 w120 h14 +0x200, asms media
Gui, 2: Add, Text, x163 y79 w120 h14 +0x200, setdim 1
Gui, 2: Add, Text, x163 y105 w120 h14 +0x200, setdim 0
Gui, 2: Add, Text, x163 y131 w120 h14 +0x200, Бан за читы
Gui, 2: Add, Text, x163 y157 w120 h14 +0x200, Бан за запретку
Gui, 2: Add, Text, x163 y183 w120 h14 +0x200, Телепорт к медиа
Gui, 2: Add, Text, x163 y209 w120 h14 +0x200, Телепорт к себе
Gui, 2: Add, Text, x163 y235 w120 h14 +0x200, Восстановить ХП
Gui, 2: Add, Text, x163 y261 w120 h14 +0x200, Возродить
Gui, 2: Add, Text, x163 y287 w120 h14 +0x200, Spec
Gui, 2: Add, Text, x163 y313 w120 h14 +0x200, Specoff
Gui, 2: Add, Text, x163 y339 w120 h14 +0x200, Починка авто
Gui, 2: Add, Text, x163 y367 w120 h14 +0x200, Памятка
Gui, 2: Add, Text, x350 y216 w120 h14 +0x200, Команды при входе

Gui, 2: Add, CheckBox, x304 y50 w120 h23 vRadio1 Checked%Radio1%, /hidecheatinfo
Gui, 2: Add, CheckBox, x304 y76 w120 h23 vRadio2 Checked%Radio2%, /zzdebug
Gui, 2: Add, CheckBox, x304 y102 w120 h23 vRadio3 Checked%Radio3%, /gm
Gui, 2: Add, CheckBox, x304 y128 w120 h23 vRadio4 Checked%Radio4%, /esp3
Gui, 2: Add, CheckBox, x304 y154 w85 h23 vRadio5 Checked%Radio5%, /templeader
Gui, 2: Add, CheckBox, x304 y180 w120 h23 vRadio6 Checked%Radio6%, /chide

Gui, 2: Add, GroupBox, x3 y385 w240 h130 cA52A2A,
Gui, 2: Add, GroupBox, x241 y385 w226 h130 cA52A2A,
Gui, 2: Add, Text, x10 y395  h20 +0x200, .ку - Приветствие на "ты"
Gui, 2: Add, Text, x10 y415  h20 +0x200, .привет - Приветствие на "Вы"
Gui, 2: Add, Text, x10 y435  h20 +0x200, .замена - Замена другим ассистентом
Gui, 2: Add, Text, x10 y455  h20 +0x200, .пока - Прощание в конце стрима
Gui, 2: Add, Text, x10 y475  h20 +0x200, .не - "Не нарушайте" игроку
Gui, 2: Add, Text, x305 y395  h20 +0x200, Помощь с м-чатом
Gui, 2: Add, Text, x248 y415  h20 +0x200, .кпз - Выпуск с КПЗ
Gui, 2: Add, Text, x248 y435  h20 +0x200, .авто - Выдача авто
Gui, 2: Add, Text, x248 y455  h20 +0x200, .искин - Выдача скина
Gui, 2: Add, Text, x248 y475  h20 +0x200, .од - Запрос одобрения в ЛС

;===========================================================================================================================================================
; Окна ==============================================================================================================================
SaveID:
Gui 2: Submit, NoHide
    IniWrite, %qdin%, Settings.ini, IDStream, qdin
return

infopred:
    Gui, infopred: Color, 282b31
    Gui, infopred: Font, s12,
    Gui, infopred: Font, cwhite, Bahnschrift

    Gui, infopred: Add, GroupBox, x20 y5 w660 h50 cA52A2A,
    Gui, infopred: Add, Text, cee5180 x250 y23 +0x200, Предупреждения на стриме:

    Gui, infopred: Add, Text,  x25 y70 cYellow, Бинд: .1п/.2п/.3п - нельзя доводить медиа до 3/3 предупреждений.
    Gui, infopred: Add, Text,  x25 y100 cWhite, Так же не забывайте есть и устные предупреждения за мелкие нарушения.
    Gui, infopred: Add, Text,  x25 y130 cYellow, .уст - Устное предупреждение медиа-партнёру.             
    Gui, infopred: Add, Text,  x25 y190 cee5180, 1 предупреждение - нарушение на 80-120 минут деморгана.
    Gui, infopred: Add, Text,  x25 y220 cWhite, Например, DB + PG + NRD + OOC оск - это все стакается в одно предупреждение.
    Gui, infopred: Add, Text,  x25 y250 cWhite, (Предупреждайте словестно за мелкие нарушения перед стаком в 1/3 preads).
    Gui, infopred: Add, Text,  x25 y280 cee5180, 2 предупреждения - нарушение от бана.
    Gui, infopred: Add, Text,  x25 y310 cRed, Прямое оскорбление родных - выдаёте сразу бан (не хард) на 30 дней.
    Gui, infopred: Show, h340 w700, Предупреждения
Return

FixLog:
    Gui, FixLog: Color, 282b31
    Gui, FixLog: Font, s12,
    Gui, FixLog: Font, cwhite, Bahnschrift

    Gui, FixLog: Add, GroupBox, x20 y5 w660 h50 cA52A2A,
    Gui, FixLog: Add, Text, cee5180 x270 y23 +0x200, Список изменений:

    Gui, FixLog: Add, Text,  x25 y80 cWhite, - Актуальная версия V1.1(Изменения 22.05.2026).
    Gui, FixLog: Add, Text,  x25 y100 cWhite, По вопросам и ошибкам Discord: Olezhik.ad или Telegram: @olezhikmanager.

    Gui, FixLog: Show, h160 w700, Список изменений
return

SaveOption:
    Gui, Submit, NoHide
    IniWrite, %Radio1%, Settings.ini, Settings, /hidecheatinfo
    IniWrite, %Radio2%, Settings.ini, Settings, /zzdebug
    IniWrite, %Radio3%, Settings.ini, Settings, /gm
    IniWrite, %Radio4%, Settings.ini, Settings, /esp3
    IniWrite, %Radio5%, Settings.ini, Settings, /templeader
    IniWrite, %Radio6%, Settings.ini, Settings, /chide
    IniWrite, %Hot1%, Settings.ini, KeySetup, KEY1
    IniWrite, %Hot2%, Settings.ini, KeySetup, KEY2
    IniWrite, %Hot3%, Settings.ini, KeySetup, KEY3
    IniWrite, %Hot4%, Settings.ini, KeySetup, KEY4
    IniWrite, %Hot5%, Settings.ini, KeySetup, KEY5
    IniWrite, %Hot6%, Settings.ini, KeySetup, KEY6
    IniWrite, %Hot7%, Settings.ini, KeySetup, KEY7
    IniWrite, %Hot8%, Settings.ini, KeySetup, KEY8
    IniWrite, %Hot9%, Settings.ini, KeySetup, KEY9
    IniWrite, %Hot10%, Settings.ini, KeySetup, KEY10
    IniWrite, %Hot11%, Settings.ini, KeySetup, KEY11
    IniWrite, %Hot12%, Settings.ini, KeySetup, KEY12
    IniWrite, %Hot13%, Settings.ini, KeySetup, KEY13
    IniWrite, %Hot14%, Settings.ini, KeySetup, KEY14

    IniWrite, %tlead%, Settings.ini, templeader, tlead
    Reload
return

Info:
    Gui, Info: Show, h280 w540, Информация о биндере
    Gui, Info: Color, 282b31
    Gui, Info: Font, s12,
    Gui, Info: Font, cwhite, Bahnschrift
	Gui, Info: Add, Text, cee5180 x8 y8  h23 +0x200, Данный Binder создан для облегчения работы PR ассистентов.
    Gui, Info: Font, s11,
    Gui, Info: Add, Text, x8 y40 +0x200, Все команды, телепорты, наказания можно вводить транслитом.
    Gui, Info: Add, Text, x8 y60  h23 +0x200, В окно "ID стримера" вводите динамик медиа, за которым следите.
    Gui, Info: Add, Text, x8 y100  h23 +0x200, Доступные команды для автоматического динамика:
    Gui, Info: Add, Text, x8 y120  h23 +0x200, /asms; /setdim 1/0; .1п; .2п; .3п;
	Gui, Info: Add, Text, cYellow x8 y150  h23 +0x200, Ctrl + F9 - Моментально обновить биндер с GitHub.
    Gui, Info: Add, Text, cYellow x8 y170  h23 +0x200, Ctrl + F10 - Полностью закрыть биндер.
    Gui, Info: Font, s14,
    Gui, Info: Add, Text, x8 y210  h23 +0x200, Автор биндера - olezhik
    Gui, Info: Add, Text, x8 y230  h23 +0x200, Редактирование и актуализация - olezhik
    Gui, Info: Add, Text, x8 y250  h23 +0x200, Дизайн иконки - olezhik
Return

Teleports:
    Gui, Teleports: Color, 282b31
    Gui, Teleports: Font, s10,
    Gui, Teleports: Font, cwhite, Bahnschrift
    Gui, Teleports: Add, Text, cee5180 x8 y450  h20 +0x200, Ключи
    Gui, Teleports: Add, Text, x8 y466  h20 +0x200, .ключ - /ctp -361.424 -129.636 38.696
    Gui, Teleports: Add, Text, x8 y482  h20 +0x200, .клг - /ctp -40.529 -1077.648 26.653
    Gui, Teleports: Add, Text, x8 y498  h20 +0x200, .клс - /ctp 1728.313 3717.568 34.109
    Gui, Teleports: Add, Text, x8 y514  h20 +0x200, .клп - /ctp -196.836 6218.708 31.491

    Gui, Teleports: Add, Text, cee5180 x8 y8  h20 +0x200, Респавны фракций
    Gui, Teleports: Add, Text, x8 y24  h20 +0x200, .лспд - /ctp 429 -980 30.50
    Gui, Teleports: Add, Text, x8 y40  h20 +0x200, .бол - /ctp 287.70 -578.35 50
    Gui, Teleports: Add, Text, x8 y56  h20 +0x200, .шд - /ctp -434.87 6024.54 31.50
    Gui, Teleports: Add, Text, x8 y72  h20 +0x200, .шд2 - /ctp 1843.770 3666.384 33.760
    Gui, Teleports: Add, Text, x8 y88  h20 +0x200, .фз - /ctp -2336 3257 32.50
    Gui, Teleports: Add, Text, x8 y104  h20 +0x200, .мэр - /ctp -534.70 -222.07 37.60
    Gui, Teleports: Add, Text, x8 y120  h20 +0x200, .визл - /ctp -593 -929 24
    Gui, Teleports: Add, Text, x8 y136  h20 +0x200, .фиб - /ctp 2527 -377 93
    Gui, Teleports: Add, Text, x8 y152  h20 +0x200, .бал - /ctp -70.06 -1824.64 26.94
    Gui, Teleports: Add, Text, x8 y168  h20 +0x200, .ваг - /ctp 967 -1817 31
    Gui, Teleports: Add, Text, x8 y184  h20 +0x200, .фэм - /ctp -204.29 -1513.69 31.60
    Gui, Teleports: Add, Text, x8 y200  h20 +0x200, .бладс - /ctp 496 -1330 29.40
    Gui, Teleports: Add, Text, x8 y216  h20 +0x200, .мара - /ctp 1437.61 -1509.64 62.40
    Gui, Teleports: Add, Text, x8 y232  h20 +0x200, .лкн - /ctp 1385 1154 114.40
    Gui, Teleports: Add, Text, x8 y248  h20 +0x200, .рм - /ctp -1526 858 181
    Gui, Teleports: Add, Text, x8 y264  h20 +0x200, .як - /ctp -1556.36 113.07 57
    Gui, Teleports: Add, Text, x8 y280  h20 +0x200, .мекс - /ctp 381.03 23.12 91.40
    Gui, Teleports: Add, Text, x8 y296  h20 +0x200, .ир - /ctp -3028.926 100.118 11.614
    Gui, Teleports: Add, Text, x8 y312  h20 +0x200, .лост - /ctp 969.84 -128.40 74.40
    Gui, Teleports: Add, Text, x8 y328  h20 +0x200, .аод - /ctp 1995.99 3062.44 47.06
    Gui, Teleports: Add, Text, x8 y344  h20 +0x200, .ам - /ctp -1895.23 2027.19 141
    Gui, Teleports: Add, Text, x8 y360  h20 +0x200, .груб - /ctp -3022 105 11.30
	Gui, Teleports: Add, Text, x8 y376  h20 +0x200, .клаб - /ctp 1588.65 6445.38 25
    Gui, Teleports: Add, Text, x8 y392  h20 +0x200, .рич - /ctp -1302.49 294.52 64.50
    Gui, Teleports: Add, Text, x8 y408  h20 +0x200, .манор - /ctp -58.20 343.73 111.80
    Gui, Teleports: Add, Text, x8 y424  h20 +0x200, .15 - /ctp -712.42 -366.30 33.90

    Gui, Teleports: Add, Text, cee5180 x280 y8  h20 +0x200, Места
	Gui, Teleports: Add, Text, x280 y24  h20 +0x200, .хум - /ctp 3569.54 3789.48 30
    Gui, Teleports: Add, Text, x280 y40  h20 +0x200, .мейз - /ctp -75 -818 326
    Gui, Teleports: Add, Text, x280 y56  h20 +0x200, .каз - /ctp 1110.117 217.0512 -49.56448
    Gui, Teleports: Add, Text, x280 y72  h20 +0x200, .аш - /ctp -620 -2264 6
    Gui, Teleports: Add, Text, x280 y88  h20 +0x200, .гг - /ctp -257 -2023 30
    Gui, Teleports: Add, Text, x280 y104  h20 +0x200, .бургер - /ctp -1171.31 -890.20 13.90
    Gui, Teleports: Add, Text, x280 y120  h20 +0x200, .багама - /ctp -1391.30 -585.35 30
    Gui, Teleports: Add, Text, x280 y136  h20 +0x200, .кайо - /ctp 4488.58 -4493.52 4
    Gui, Teleports: Add, Text, x280 y152  h20 +0x200, .авиа - /ctp 3035.21 -4688.55 15
    Gui, Teleports: Add, Text, x280 y168  h20 +0x200, .мол - /ctp 61.67 -1751.80 47
    Gui, Teleports: Add, Text, x280 y184  h20 +0x200, .трас - /ctp 7400 3946 1124
    Gui, Teleports: Add, Text, x280 y200  h20 +0x200, .трасс - /ctp 7400 -656 1124
    Gui, Teleports: Add, Text, x280 y216  h20 +0x200, .аук - /ctp -833 -699.50 27
    Gui, Teleports: Add, Text, x280 y232  h20 +0x200, .бокс - /ctp 8.56 -1658.55 28.71
    Gui, Teleports: Add, Text, x280 y248  h20 +0x200, .бар - /ctp -305.09 6259.59 30.92
    Gui, Teleports: Add, Text, x280 y264  h20 +0x200, .бк - /ctp 500.44 109.79 96.49
    Gui, Teleports: Add, Text, x280 y280  h20 +0x200, .ванила - /ctp 131.33 -1302.93 29.23
    Gui, Teleports: Add, Text, x280 y296  h20 +0x200, .починка - /ctp -1430.45 -450.5 35.91
    Gui, Teleports: Add, Text, x280 y312  h20 +0x200, .сэнди - /ctp 1843.770 3666.384 33.760
    Gui, Teleports: Add, Text, x280 y328  h20 +0x200, .порт - /ctp 417 -2501 13.46
    Gui, Teleports: Add, Text, x280 y344  h20 +0x200, .стр - /ctp 1304 1453 98.87
    Gui, Teleports: Add, Text, x280 y360  h20 +0x200, .лес - /ctp -321 6093 31.14
	Gui, Teleports: Add, Text, x280 y376  h20 +0x200, .бмара - /ctp 1302 -1646 51.04
    Gui, Teleports: Add, Text, x280 y392  h20 +0x200, .самол - /ctp 1473 2730 37.38
    Gui, Teleports: Add, Text, x280 y408  h20 +0x200, .чил - /ctp 498 5592 795
    Gui, Teleports: Add, Text, x280 y424  h20 +0x200, .палето - /ctp -434.87 6024.54 31.50
    Gui, Teleports: Show, h540 w550, Телепорты
Return

CommandList:
... Код со списком команд остался без изменений ...
Return

Cheatsheet:
... Код шпаргалки остался без изменений ...
Return

Punish:
... Код списка наказаний остался без изменений ...
Return

;===========================================================================================================================================================
; Бинды ==============================================================================================================================

asms:
sleep 150
SendInput, {t}
sleep 150
SendInput, /asms %qdin%{space}
return

setdim1:
sleep 150
SendInput, {t}
sleep 150
SendInput, /setdim %qdin% 1
return

setdim0:
sleep 150
SendInput, {t}
sleep 150
SendInput, /setdim %qdin% 0
return

cheat:
sleep 150
SendInput, {t}
sleep 150
SendInput, /hardban 8888 Cheats{left 12}
return

banword:
sleep 150
SendInput, {t}
sleep 150
SendInput, /ban 3.5 ОПС{left 8}
return

tpmedia:
Sleep 150
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 150
SendInput, /tp %qdin%{enter}
return

tleader:
Sleep 150
BlockInput, SendAndMouse
SendInput, {sc14}
Sleep 150
SendInput, /gh {space}
return

hp:
Sleep 150
SendInput, {sc14}
Sleep 150
SendInput, /hp %qdin% 100
return

spec:
sleep 150
SendInput, {t}
sleep 150
SendInput, /spec %qdin% {enter}
return

specoff:
sleep 150
SendInput, {t}
sleep 150
SendInput, /specoff {enter}
sleep 150
SendInput, {f5}
return

repair:
Sleep 150
SendInput, {sc14}
Sleep 150
SendInput, /repair {Enter}
return

vhod:
... Функции входа без изменений ...
return

;===========================================================================================================================================================
; Команды и Отыгрыши фракций ===============================================================================================================
... Все твои RP-команды (.лспд, .чит, .ку и т.д.) лежат ниже без изменений ...

Reload:
reload
return

Close:
exitapp

Hide:
Gui,2: Hide
return

Show:
Gui,2: Show
return

guiclose2:
gui 2:hide
