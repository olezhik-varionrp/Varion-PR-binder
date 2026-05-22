; ========================================================== PR ASSISTANT BINDER ==========================================================

#SingleInstance, Force
#UseHook
#NoEnv
SetWorkingDir %A_ScriptDir%
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0

titlcolor = df005c   ; Цвет заголовка
buildscr = 51        ; Текущая версия (совпадает с version.ini)

; ТВОИ ПРАВИЛЬНЫЕ ССЫЛКИ ДЛЯ ОБНОВЛЕНИЯ:
downlurl := "https://raw.githubusercontent.com/olezhik-varionrp/Varion-PR-binder/main/PR.ahk"
downllen := "https://raw.githubusercontent.com/olezhik-varionrp/Varion-PR-binder/main/version.ini"

; ==================== БЛОК АВТО-ОБНОВЛЕНИЯ ====================
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
try {
    whr.Open("GET", downllen, true)
    whr.Send()
    whr.WaitForResponse()
    VersionText := whr.ResponseText
    RegExMatch(VersionText, "version=(\d+)", Match)
    NewVersion := Match1
    if (NewVersion > buildscr) {
        MsgBox, 4, Обновление, Доступна новая версия биндера v%NewVersion%! Хотите обновить?
        IfMsgBox, Yes
        {
            UrlDownloadToFile, %downlurl%, %A_ScriptDir%\PR_new.ahk
            if !ErrorLevel {
                FileDelete, update.bat
                FileAppend,
                (
                @echo off
                timeout /t 1 /nobreak > nul
                del "%A_ScriptFullPath%"
                ren "%A_ScriptDir%\PR_new.ahk" "%A_ScriptName%"
                start "" "%A_ScriptFullPath%"
                del "`%~f0"
                ), update.bat
                Run, update.bat,, Hide
                ExitApp
            }
        }
    }
} catch {
    ; Если нет интернета, просто запускаемся дальше
}
; ==============================================================

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
;Gui, 2: Add, Picture, x10 y395 w450 h113, %A_ScriptDir%\img\Epik.png

Gui, 2: -MaximizeBox
Gui, 2: Show, w470 h520, PR-Assistant Binder
Gui, 2: Color, 282b31
Gui, 2: Font, s9,

Gui, 2: Font, cWhite,Bahnschrift


Menu, Tray, add, Показать, Show,
Menu, Tray, Default, Показать,
Menu, Tray, add, Перезагрузить, Reload,
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

;; Боковые кнопки
Gui, 2: Add, Edit,   x7 y322 w80 h21 +Number vqdin cblack, %qdin%
;Gui, 2: Add, Button, x7 y352 w80 h30 gSaveID, Cохранить
Gui, 2: Add, Picture, x7 y15 w80 h41 gTeleports, %A_ScriptDir%\img\tp.png
Gui, 2: Add, Picture, x7 y65 w80 h41 gCommandList, %A_ScriptDir%\img\spis.png
Gui, 2: Add, Picture, x7 y115 w80 h41 gPunish, %A_ScriptDir%\img\nak.png
Gui, 2: Add, Picture, x7 y165 w80 h41 gInfo, %A_ScriptDir%\img\bind.png
Gui, 2: Add, Picture, x7 y352 w80 h30 gSaveID, %A_ScriptDir%\img\save.png

;Gui, 2: Add, Button, x7 y15 w80 h41 gCommandList2, Важное к прочтению
;Gui, 2: Add, Button, x7 y65 w80 h41 gTeleports, Телепорты
;Gui, 2: Add, Button, x7 y115 w80 h41 gCommandList, Список команд
;Gui, 2: Add, Button, x7 y165 w80 h41 gPunish, Наказания
;Gui, 2: Add, Button, x7 y215 w80 h41 gInfo , О биндере



Gui, 2: Add, Picture, x302 y248 w150 h41 ginfopred, %A_ScriptDir%\img\pred.png
Gui, 2: Add, Picture, x302 y300 w150 h30 gFixLog, %A_ScriptDir%\img\spisupdate.png
Gui, 2: Add, Picture, x302 y340 w150 h41 gSaveOption, %A_ScriptDir%\img\saveglobal.png


Gui, 2: Add, Picture, x100 y9 w184 h27, %A_ScriptDir%\img\bindinfo.png
Gui, 2: Add, Picture, x294 y9 w168 h27, %A_ScriptDir%\img\auto.png

;Gui 2: Add, GroupBox, x100 y9 w184 h27 cA52A2A,
;Gui 2: Add, GroupBox, x294 y9 w168 h27 cA52A2A,
;Gui, 2: Add, Text, x173 y19 w50 h14 +0x200, Бинды
;Gui, 2: Add, Text, x345 y19 w100 h14 +0x200 , Авторизация

Gui, 2: Add, Text, x7 y300 +0x200, ID стримера:
Gui, 2: Add, Edit, x390 y155 w21 h18 +Number vtlead cblack, %tlead%

Gui, 2: Add, Hotkey, x110 y50 w48 h21 vHot1, %KEY1% ; asms
Gui, 2: Add, Hotkey, x110 y76 w48 h21 vHot2, %KEY2% ; setdim1
Gui, 2: Add, Hotkey, x110 y102 w48 h21 vHot3, %KEY3% ;  setdim0
Gui, 2: Add, Hotkey, x110 y128 w48 h21 vHot4, %KEY4% ; cheat
Gui, 2: Add, Hotkey, x110 y154 w48 h21 vHot5, %KEY5%;  banword
Gui, 2: Add, Hotkey, x110 y180 w48 h21 vHot6, %KEY6% ;  tp in media
Gui, 2: Add, Hotkey, x110 y206 w48 h21 vHot7, %KEY7% ;  tleader
Gui, 2: Add, Hotkey, x110 y232 w48 h21 vHot8, %KEY8% ;   hp
Gui, 2: Add, Hotkey, x110 y258 w48 h21 vHot9, %KEY9% ; resc
Gui, 2: Add, Hotkey, x110 y284 w48 h21 vHot10, %KEY10% ; spec
Gui, 2: Add, Hotkey, x110 y310 w48 h21 vHot11, %KEY11% ;   specoff
Gui, 2: Add, Hotkey, x110 y336 w48 h21 vHot12, %KEY12% ;   repair
Gui, 2: Add, Hotkey, x110 y362 w48 h21 vHot13, %KEY13% ;   ???????
Gui, 2: Add, Hotkey, x303 y212 w40 h21 vHot14, %KEY14% ;   ????

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
    Gui, infopred: Add, Text,  x25 y250 cWhite, (Предупреждайте словестно за мелкие нарушения перед стаком в 1/3 предов).
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

    Gui, FixLog: Add, Text,  x25 y80 cWhite, - Актуализация биндера произвелась 02.09.2024
    Gui, FixLog: Add, Text,  x25 y100 cWhite, by defix

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
	Gui, Info: Add, Text, cYellow x8 y150  h23 +0x200, Ctrl + F9 - Перезапустить.
    Gui, Info: Add, Text, cYellow x8 y170  h23 +0x200, Ctrl + F10 - Закрыть.
    Gui, Info: Font, s14,
    Gui, Info: Add, Text, x8 y210  h23 +0x200, Автор биндера - flayme
    Gui, Info: Add, Text, x8 y230  h23 +0x200, Редактирование и актуализация - defix
    Gui, Info: Add, Text, x8 y250  h23 +0x200, Дизайн иконки - yokkk
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
    Gui, Teleports: Add, Text, x280 y56  h20 +0x200, .каз - /ctp 916 50 81
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
    Gui, CommandList: Color, 282b31
    Gui, CommandList: Font, s10,
    Gui, CommandList: Font, cwhite, Bahnschrift
    Gui, CommandList: Add, Text, x8 y8  h20 +0x200, /bch - /bancheck
    Gui, CommandList: Add, Text, x8 y24  h20 +0x200, .иср - /bancheck
    Gui, CommandList: Add, Text, x8 y40  h20 +0x200, /jch - /ajailcheck
    Gui, CommandList: Add, Text, x8 y56  h20 +0x200, .оср - /ajailcheck
    Gui, CommandList: Add, Text, x8 y72  h20 +0x200, .ифтсрусл - /bancheck
    Gui, CommandList: Add, Text, x8 y88  h20 +0x200, .фофшдсрусл - /ajailcheck
    Gui, CommandList: Add, Text, x8 y104  h20 +0x200, /tf - /tempfamily
    Gui, CommandList: Add, Text, x8 y120  h20 +0x200, .еа - /tempfamily
    Gui, CommandList: Add, Text, x8 y136  h20 +0x200, /sm - /setmaterials
    Gui, CommandList: Add, Text, x8 y152  h20 +0x200, .ыь - /setmaterials
    Gui, CommandList: Add, Text, x8 y168  h20 +0x200, /tn - /tempname
    Gui, CommandList: Add, Text, x8 y184  h20 +0x200, .ет - /tempname
    Gui, CommandList: Add, Text, x8 y200  h20 +0x200, .яяв - /zzdebug
    Gui, CommandList: Add, Text, x8 y216  h20 +0x200, /zzd - /zzdebug
    Gui, CommandList: Add, Text, x8 y232  h20 +0x200, /amph - /addamphitheater
    Gui, CommandList: Add, Text, x8 y248  h20 +0x200, .фьзр - /addamphitheater
    Gui, CommandList: Add, Text, x8 y264  h20 +0x200, /ramph - /removeamphitheater
    Gui, CommandList: Add, Text, x8 y280  h20 +0x200, .кфьзр - /removeamphitheater
    Gui, CommandList: Add, Text, x8 y296  h20 +0x200, /gzone - /togglegreenzone
    Gui, CommandList: Add, Text, x8 y312  h20 +0x200, .пящту - /togglegreenzone
    Gui, CommandList: Add, Text, x8 y328  h20 +0x200, /mcheck - /mutecheck
    Gui, CommandList: Add, Text, x8 y344  h20 +0x200, .ьсрусл - /mutecheck
    Gui, CommandList: Add, Text, x8 y360  h20 +0x200, .ьгеусрусл - /mutecheck
	Gui, CommandList: Add, Text, x8 y376  h20 +0x200, .гтофшд - /unjail
    Gui, CommandList: Add, Text, x8 y392  h20 +0x200, .цфкт - /warn
    Gui, CommandList: Add, Text, x8 y408  h20 +0x200, .дв - /lastdriver
    Gui, CommandList: Add, Text, x8 y424  h20 +0x200, /ld - /lastdriver
    Gui, CommandList: Add, Text, x8 y440  h20 +0x200, /af - /ainfect
    Gui, CommandList: Add, Text, x8 y456  h20 +0x200, .фа - /ainfect
    Gui, CommandList: Add, Text, x8 y472  h20 +0x200, /sk - /skick
    Gui, CommandList: Add, Text, x8 y488  h20 +0x200, .ыл - /skick
    Gui, CommandList: Add, Text, x8 y504  h20 +0x200, /k - /kick
    Gui, CommandList: Add, Text, x8 y520  h20 +0x200, .л - /kick
	Gui, CommandList: Add, Text, x8 y536  h20 +0x200, /ai - /auninvite
    Gui, CommandList: Add, Text, x8 y552  h20 +0x200, .фш - /auninvite
    Gui, CommandList: Add, Text, x8 y568  h20 +0x200, .аи - /fb
    Gui, CommandList: Add, Text, x8 y584  h20 +0x200, /aif - /ainfect
	Gui, CommandList: Add, Text, x8 y600  h20 +0x200, .фша - /ainfect
    Gui, CommandList: Add, Text, x8 y616  h20 +0x200, .с - /c
    Gui, CommandList: Add, Text, x8 y632  h20 +0x200, .си - /cb
    Gui, CommandList: Add, Text, x8 y648  h20 +0x200, .гтьгеу - /unmute
    Gui, CommandList: Add, Text, x8 y664  h20 +0x200, .пшв - /gid
    Gui, CommandList: Add, Text, x8 y680  h20 +0x200, .фвьшты - /admins
    Gui, CommandList: Add, Text, x8 y696  h20 +0x200, .фштаусе - /ainfect
    Gui, CommandList: Add, Text, x8 y712  h20 +0x200, .умутещт - /eventon
    Gui, CommandList: Add, Text, x8 y728  h20 +0x200, .умутещаа - /eventoff
    Gui, CommandList: Add, Text, x8 y744  h20 +0x200, .пц - /gw
    Gui, CommandList: Add, Text, x8 y760  h20 +0x200, .мурыефе - /vehstat

	Gui, CommandList: Add, Text, x210 y8  h20 +0x200, .мур - /veh
    Gui, CommandList: Add, Text, x210 y24  h20 +0x200, .ашчсфк - /fixcar
    Gui, CommandList: Add, Text, x210 y40  h20 +0x200, .уьздуфвук - /templeader
    Gui, CommandList: Add, Text, x210 y56  h20 +0x200, /tl - /templeader
    Gui, CommandList: Add, Text, x210 y72  h20 +0x200, .ед - /templeader
    Gui, CommandList: Add, Text, x210 y88  h20 +0x200, .ылшсл - /skick
    Gui, CommandList: Add, Text, x210 y104  h20 +0x200, .кузфшк - /repair
    Gui, CommandList: Add, Text, x210 y120  h20 +0x200, .фгтшмшеу - /auninvite
    Gui, CommandList: Add, Text, x210 y136  h20 +0x200, .учсфк - /excar
    Gui, CommandList: Add, Text, x210 y152  h20 +0x200, .агуд - /fuel
    Gui, CommandList: Add, Text, x210 y168  h20 +0x200, .акууяу - /freeze
    Gui, CommandList: Add, Text, x210 y200  h20 +0x200, .згддекгтл - /pulltrunk
    Gui, CommandList: Add, Text, x210 y216  h20 +0x200, .езсфк - /tpcar
    Gui, CommandList: Add, Text, x210 y232  h20 +0x200, .дфыевкшмук - /lastdriver
    Gui, CommandList: Add, Text, x210 y248  h20 +0x200, .вудшеуь - /delitem
    Gui, CommandList: Add, Text, x210 y264  h20 +0x200, /gc - /getcar
	Gui, CommandList: Add, Text, x210 y184  h20 +0x200, .пиздец - Мольба о помощи
    Gui, CommandList: Add, Text, x210 y280  h20 +0x200, .пс - /getcar
    Gui, CommandList: Add, Text, x210 y296  h20 +0x200, .фв - /admins
    Gui, CommandList: Add, Text, x210 y312  h20 +0x200, /ad - /admins
    Gui, CommandList: Add, Text, x210 y328  h20 +0x200, .з - /players
    Gui, CommandList: Add, Text, x210 y344  h20 +0x200, /p - /players
    Gui, CommandList: Add, Text, x210 y360  h20 +0x200, .здфнукы - /players
	Gui, CommandList: Add, Text, x210 y376  h20 +0x200, .рес - /rescue
    Gui, CommandList: Add, Text, x210 y392  h20 +0x200, /htc - /rescue
    Gui, CommandList: Add, Text, x210 y408  h20 +0x200, .ез - /tp
    Gui, CommandList: Add, Text, x210 y424  h20 +0x200, .ызус - /spec
    Gui, CommandList: Add, Text, x210 y440  h20 +0x200, .ызусщаа - /specoff
    Gui, CommandList: Add, Text, x210 y456  h20 +0x200, .ф - /a
    Gui, CommandList: Add, Text, x210 y472  h20 +0x200, .фыьы - /asms
    Gui, CommandList: Add, Text, x210 y488  h20 +0x200, /sp - /spec
    Gui, CommandList: Add, Text, x210 y504  h20 +0x200, .ыз - /spec
    Gui, CommandList: Add, Text, x210 y520  h20 +0x200, /so - /specoff
	Gui, CommandList: Add, Text, x210 y536  h20 +0x200, .ыщ - /specoff
    Gui, CommandList: Add, Text, x210 y552  h20 +0x200, /kill - /hp 0
    Gui, CommandList: Add, Text, x210 y568  h20 +0x200, .лшдд - /hp 0
    Gui, CommandList: Add, Text, x210 y584  h20 +0x200, .пр - /gh
	Gui, CommandList: Add, Text, x210 y600  h20 +0x200, .штсфк - /incar
    Gui, CommandList: Add, Text, x210 y616  h20 +0x200, .штм - /inv
    Gui, CommandList: Add, Text, x210 y632  h20 +0x200, .рз - /hp
    Gui, CommandList: Add, Text, x210 y648  h20 +0x200, .шв - /id
    Gui, CommandList: Add, Text, x210 y664  h20 +0x200, .од - /ajail
    Gui, CommandList: Add, Text, x210 y680  h20 +0x200, .фофшд - /ajail
    Gui, CommandList: Add, Text, x210 y696  h20 +0x200, .лшсл - /kick
    Gui, CommandList: Add, Text, x210 y712  h20 +0x200, .вд - /dl
    Gui, CommandList: Add, Text, x210 y728  h20 +0x200, .уыз - /esp
    Gui, CommandList: Add, Text, x210 y744  h20 +0x200, .уыз2 - /esp2
    Gui, CommandList: Add, Text, x210 y760  h20 +0x200, .уыз3 - /esp3

	Gui, CommandList: Add, Text, x410 y8  h20 +0x200, .пуесфк - /getcar
    Gui, CommandList: Add, Text, x410 y24  h20 +0x200, .ифт - /ban
    Gui, CommandList: Add, Text, x410 y40  h20 +0x200, .вудмур - /delveh
    Gui, CommandList: Add, Text, x410 y56  h20 +0x200, .ьез - /mtp
    Gui, CommandList: Add, Text, x410 y72  h20 +0x200, .мур - /veh
    Gui, CommandList: Add, Text, x410 y88  h20 +0x200, .фмур - /aveh
    Gui, CommandList: Add, Text, x410 y104  h20 +0x200, .рфквифт - /hardban
    Gui, CommandList: Add, Text, x410 y120  h20 +0x200, .ьгеу - /mute
    Gui, CommandList: Add, Text, x410 y136  h20 +0x200, .пшв - /gid
    Gui, CommandList: Add, Text, x410 y152  h20 +0x200, .ср - /chide
    Gui, CommandList: Add, Text, x410 y168  h20 +0x200, /ch - /chide
    Gui, CommandList: Add, Text, x410 y184  h20 +0x200, .куысгу - /rescue
    Gui, CommandList: Add, Text, x410 y200  h20 +0x200, .ыуевшь - /setdim
    Gui, CommandList: Add, Text, x410 y216  h20 +0x200, /sd - /setdim
    Gui, CommandList: Add, Text, x410 y232  h20 +0x200, .и - /b
    Gui, CommandList: Add, Text, x410 y248  h20 +0x200, .ц - /w
    Gui, CommandList: Add, Text, x410 y264  h20 +0x200, .ыв - /setdim
    Gui, CommandList: Add, Text, x410 y280  h20 +0x200, .сршву - /chide
    Gui, CommandList: Add, Text, x410 y296  h20 +0x200, .афк - /a афк мин
    Gui, CommandList: Add, Text, x410 y312  h20 +0x200, .фгтсгаа - /auncuff
    Gui, CommandList: Add, Text, x410 y328  h20 +0x200, .фсгаа - /acuff
    Gui, CommandList: Add, Text, x410 y344  h20 +0x200, .акууямур - /freezveh
    Gui, CommandList: Add, Text, x410 y360  h20 +0x200, /scd - /setcardim
	Gui, CommandList: Add, Text, x410 y376  h20 +0x200, .ыуесфквшь - /setcardim
    Gui, CommandList: Add, Text, x410 y392  h20 +0x200, .ысв - /setcardim
    Gui, CommandList: Add, Text, x410 y408  h20 +0x200, /rst - /resettempname
    Gui, CommandList: Add, Text, x410 y424  h20 +0x200, .кые - /resettempname
    Gui, CommandList: Add, Text, x410 y440  h20 +0x200, .куыуееуьзтфьу - /resettempname
    Gui, CommandList: Add, Text, x410 y456  h20 +0x200, .т - /netstat
    Gui, CommandList: Add, Text, x410 y472  h20 +0x200, /n - /netstat
    Gui, CommandList: Add, Text, x410 y488  h20 +0x200, /dv - /delveh
    Gui, CommandList: Add, Text, x410 y504  h20 +0x200, .вм - /delveh
    Gui, CommandList: Add, Text, x410 y520  h20 +0x200, .рфкв - /hardban
	Gui, CommandList: Add, Text, x410 y536  h20 +0x200, /hard - /hardban
    Gui, CommandList: Add, Text, x410 y552  h20 +0x200, /as - /asms
    Gui, CommandList: Add, Text, x410 y568  h20 +0x200, .фы - /asms
    Gui, CommandList: Add, Text, x410 y584  h20 +0x200, .пез - /gtp
	Gui, CommandList: Add, Text, x410 y600  h20 +0x200, .пь - /gm
    Gui, CommandList: Add, Text, x410 y616  h20 +0x200, .тс - /noclip
    Gui, CommandList: Add, Text, x410 y632  h20 +0x200, /nc - /noclip
    Gui, CommandList: Add, Text, x410 y648  h20 +0x200, /acf - /acuff
    Gui, CommandList: Add, Text, x410 y664  h20 +0x200, .фса - /acuff
    Gui, CommandList: Add, Text, x410 y680  h20 +0x200, /auf - /auncuff
    Gui, CommandList: Add, Text, x410 y696  h20 +0x200, .езр - /tph
    Gui, CommandList: Add, Text, x410 y712  h20 +0x200, .фга - /auncuff
    Gui, CommandList: Add, Text, x410 y728  h20 +0x200, .фмур - /aveh
    Gui, CommandList: Add, Text, x410 y744  h20 +0x200, .фдщсл - /alock
    Gui, CommandList: Add, Text, x410 y760  h20 +0x200, .гб - /gunban
    Gui, CommandList: Show, h780 w640, Команды
Return

Cheatsheet:
    Cheatsheet1:=!Cheatsheet1
    If Cheatsheet1
    {
        CustomColor2 = 	EEAA99
        Gui 3: +LastFound +AlwaysOnTop -Caption +ToolWindow
        Gui 3: Color, black
        Gui 3: Font, s8
        Gui 3: Font, w3000
        Gui 3: Font, cFFFFFF, Bahnschrift
        Gui 3: Add, Text,,  Фракции: 1 - LSPD   2 - EMS   3 - SD   4 - SANG   5 - GOV   6 - WN   7 - FIB   8 - Ballas   9 - Vagos   10 - Fam   11 - Bloods   12 - Mara  
        Gui 3: Add, Text, cWhite,
        Gui 3: Font, s10
        Gui 3: Add, Text, cAqua,  Запрещено использовать запрещенные стримерской платформой (twitch, youtube и др.) слова, высказывания, предложения и прочее. | Mute 240 минут / Ban 3-30 дней / HardBan 5-15 дней / Permban
        Gui 3: Add, Text, cWhite, Nigger, nigga, нига, ниггер
        Gui 3: Add, Text, cYellow, Ban 10-30 дней. (Если у человека вырвалось 7-10 дней, если намеренно 30 дней или хард).
        Gui 3: Add, Text, cWhite, Нага, naga, некр
        Gui 3: Add, Text, cYellow, Не нарушение, но если намеренно говорит и спамит - Mute 240 минут.
        Gui 3: Add, Text, cWhite, Faggot, пидор, пидорас, педик, гомик, гомосек
        Gui 3: Add, Text, cYellow, Ban 10-30 дней (если у человека вырвалось 7-10 дней, если намеренно 30 дней или хард).
        Gui 3: Add, Text, cWhite, Даун, аутист
        Gui 3: Add, Text, cYellow, Ban 3-5 дней.(если намеренно спамит 10-15 дней или хард).
        Gui 3: Add, Text, cWhite, Петух, куколд, гидра
        Gui 3: Add, Text, cYellow, Mute 240 минут (если намеренно начнет говорить несколько раз Ban 3-5 дней).
        Gui 3: Add, Text, cWhite,
        Gui 3: Add, Text, cAqua,  Любые завуал. оск. вероисповедания | Ban 15 - 30 дней / Hardban 15-30 дней / Permban.
        Gui 3: Add, Text, cWhite,  Хохол, хач, жид, чинк, пиндос
        Gui 3: Add, Text, cYellow, Hardban 30 дней - оскорбление нации.
        Gui 3: Add, Text, cWhite,  Black, черный (по отношению к человеку) черножопый, черномазый, узкоглазый
        Gui 3: Add, Text, cYellow, Hardban 15-30 дней - Оскорбление расы.
        Gui 3: Add, Text, cWhite,  Религиозная нетерпимость (оски), хиджаб (в негативном контексте)
        Gui 3: Add, Text, cYellow, Hardban 30 дней - Оскорбление религии.
        Gui 3: Add, Text, cWhite,
        Gui 3: Add, Text, cAqua,  Действия, направленные на возбуждение ненависти, либо вражды, в IC и ООС на почве разногласия о гендерной, социальной и т.п. принадлежности. | Demorgan 90 минут / Ban 3 - 15 дней / HardBan 3 - 15 дней.
        Gui 3: Add, Text, cWhite, Пизда, шлюха,cunt. (по отношению к девушке)
        Gui 3: Add, Text, cYellow, Ban 10-15 дней - оскорбление по гендерной принадлежности.
	    Gui 3: Add, Text, cWhite, Принижение за инвалидность.
        Gui 3: Add, Text, cYellow, Hardban 15 дней - Оскорбление по социальной принадлежности.
		Gui 3: Add, Text, cWhite, Мужики/девушки - не люди.
		Gui 3: Add, Text, cWhite, У кого хуй/пизда между ног - тот не человек.
        Gui 3: Add, Text, cWhite,
        Gui 3: Add, Text, cAqua, Стримснайп: Ban 7 - 30 дней / HardBan 15 - 30 дней.
        Gui 3: Add, Text, cWhite, Помеха стримерам / ютуберам, порча им игрового процесса, слишком навязчивая помощь без надобности / просьб и т.п..
        Gui 3: Add, Text, cWhite,

        WinSet, TransColor, %CustomColor2% 190
        Gui 3: Show, x0 y0 NoActivate, window.
    }
    Else
    Gui 3: Destroy
Return

Punish:
    Gui, Punish: Color, 300b31
    Gui, Punish: Font, s10,
    Gui, Punish: Font, cwhite
    Gui, Punish: Add, Text, x8 y8  h20 +0x200, .чит - /hardban  8888 Cheats
    Gui, Punish: Add, Text, x8 y24  h20 +0x200, .запретка - /ban  3.5 ОПС
    Gui, Punish: Add, Text, x8 y40  h20 +0x200, .звук - /mute  120 Мешающие звуки
    Gui, Punish: Add, Text, x8 y56  h20 +0x200, .помеха - /ajail  10 3.6.2 ОПС
    Gui, Punish: Add, Text, x8 y72  h20 +0x200, .кик - /kick  3.6.2 ОПС
    Gui, Punish: Add, Text, x8 y88  h20 +0x200, .бан - /ban
    Gui, Punish: Add, Text, x8 y104  h20 +0x200, .дем - /ajail
    Gui, Punish: Add, Text, x8 y120  h20 +0x200, .мут - /mute
    Gui, Punish: Add, Text, x8 y136  h20 +0x200, .варн - /warn
    Gui, Punish: Add, Text, x8 y152  h20 +0x200, .хард - /hardban
    Gui, Punish: Add, Text, x8 y168  h20 +0x200, .нрд - /ajail 15 nonRP Drive
    Gui, Punish: Add, Text, x8 y184  h20 +0x200, .нрп - /ajail 15 nonRP Поведение
    Gui, Punish: Add, Text, x8 y200  h20 +0x200, .дб - /ajail 30 DB
    Gui, Punish: Add, Text, x8 y216  h20 +0x200, .дм - /gunban 5 DM
    Gui, Punish: Add, Text, x8 y232  h20 +0x200, .дмд - /ajail 120 DM
    Gui, Punish: Add, Text, x8 y248  h20 +0x200, .пг - /ajail 35 PG
    Gui, Punish: Add, Text, x8 y264  h20 +0x200, .муз - /mute 30 Music in ZZ
    Gui, Punish: Add, Text, x8 y280  h20 +0x200, .смник - /ajail 720 Смените Имя_Фамилия...
    Gui, Punish: Add, Text, x8 y296  h20 +0x200, .оскадм - /ban 5 Оскорбление администрации
          Gui, Punish: Show, h320 w320, Наказания
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
SendMessage, 0x50,, 0x4090409
SendInput, {T}
Sleep 300
SendInput, /gm{Enter}
Sleep 300
if (Radio4==1)
{
SendInput, {T}
Sleep 300
SendInput, /esp3{Enter}
Sleep 300
}
if (Radio6==1)
{
SendInput, {T}
Sleep 300
SendInput, /chide{Enter}
Sleep 300
}
if (Radio2==1)
{
SendInput, {T}
Sleep 300
SendInput, /zzdebug{Enter}
Sleep 300
}
if (Radio1==1)
{
SendInput, {T}
Sleep 300
SendInput, /hidecheatinfo{Enter}
Sleep 300
}
if (Radio3==1)
{
SendInput, {T}
Sleep 300
SendInput, /gm{Enter}
Sleep 300
}
if (Radio5==1)
{
SendInput, {T}
Sleep 300
SendInput, /templeader %tlead%{Enter}
}
return
;===========================================================================================================================================================
; Команды ==============================================================================================================================

:?:.лспд::/ctp 429 -980 30.50
:?:.бол::/ctp 287.70 -578.35 50
:?:.шд::/ctp -434.87 6024.54 31.50
:?:.фз::/ctp -2336 3257 32.50
:?:.мэр::/ctp -534.70 -222.07 37.60
:?:.визл::/ctp -593 -929 24
:?:.фиб::/ctp 2527 -377 93

:?:.бал::/ctp -70.06 -1824.64 26.94
:?:.ваг::/ctp 967 -1817 31
:?:.фэм::/ctp -204.29 -1513.69 31.60
:?:.бладс::/ctp 496 -1330 29.40
:?:.мара::/ctp 983.018 -2496.230 28.769

:?:.лкн::/ctp 1385 1154 114.40
:?:.рм::/ctp -1526 858 181
:?:.як::/ctp -1556.36 113.07 57
:?:.мекс::/ctp 381.03 23.12 91.40
:?:.ам::/ctp -1895.23 2027.19 141

:?:.лост::/ctp 969.84 -128.40 74.40
:?:.аод::/ctp 1995.99 3062.44 47.06

:?:.ириш::/ctp -3022 105 11.30
:?:.клаб::/ctp 1588.65 6445.38 25
:?:.рич::/ctp -1302.49 294.52 64.50
:?:.манор::/ctp -58.20 343.73 111.80
:?:.конт::/ctp -1865.51 -355.96 57

:?:.хум::/ctp 3569.54 3789.48 30
:?:.мейз::/ctp -75 -818 326
:?:.каз::/ctp 1110.117 217.0512 -49.56448
:?:.аш::/ctp -620 -2264 6
:?:.гг::/ctp -257 -2023 30
:?:.бургер::/ctp -1171.31 -890.20 13.90
:?:.багама::/ctp -1391.30 -585.35 30
:?:.кайо::/ctp 4488.58 -4493.52 4
:?:.авиа::/ctp 3035.21 -4688.55 15
:?:.мол::/ctp 61.67 -1751.80 47
:?:.трас::/ctp 7400 3946 1124
:?:.аук::/ctp -833 -699.50 27
:?:.бокс::/ctp 8.56 -1658.55 28.71
:?:.бар::/ctp -305.09 6259.59 30.92
:?:.бк::/ctp 500.44 109.79 96.49
:?:.ванила::/ctp 131.33 -1302.93 29.23
:?:.починка::/ctp -1430.45 -450.5 35.91
:?:.лск4::/ctp 1175.47 2671.33 37.85
:?:.порт::/ctp 417 -2501 13.46
:?:.стр::/ctp 1304 1453 98.87
:?:.лес::/ctp -321 6093 31.14
:?:.бмара::/ctp 1302 -1646 51.04
:?:.самол::/ctp 1473 2730 37.38

; Команды
:?:/bch::/bancheck
:?:.иср::/bancheck
:?:/jch::/ajailcheck
:?:.оср::/ajailcheck
:?:.ифтсрусл::/bancheck
:?:.фофшдсрусл::/ajailcheck
:?:/tf::/tempfamily
:?:.еа::/tempfamily
:?:/sm::/setmaterials
:?:.ыь::/setmaterials
:?:/tn::/tempname
:?:.ет::/tempname
:?:.еуьзтфьу::.еуьзтфьу
:?:.яяв::/zzdebug
:?:/zzd::/zzdebug
:?:/amph::/addamphitheater
:?:.фьзр::/addamphitheater
:?:/ramph::/removeamphitheater
:?:.кфьзр::/removeamphitheater
:?:/gzone::/togglegreenzone
:?:.пящту::/togglegreenzone
:?:/mcheck::/mutecheck
:?:.ьсрусл::/mutecheck
:?:.ьгеусрусл::/mutecheck
:?:.гтофшд::/unjail
:?:.цфкт::/warn
:?:/ld::/lastdriver
:?:.дв::/lastdriver
:?:/af::/ainfect
:?:.фа::/ainfect
:?:/sk::/skick
:?:.ыл::/skick
:?:/k::/kick
:?:.л::/kick
:?:/ai::/auninvite
:?:.фш::/auninvite
:?:.аи::/fb
:?:/aif::/ainfect
:?:.фша::/ainfect
:?:.с::/c
:?:.си::/cb
:?:.гтьгеу::/unmute
:?:.пшв::/gid
:?:.фвьшты::/admins
:?:.фштаусе::/ainfect
:?:.умутещт::/eventon
:?:.умутещаа::/eventoff
:?:.пц::/gw
:?:.мур::/veh
:?:.ашчсфк::/fixcar
:?:.уьздуфвук::/templeader
:?:/tl::/templeader
:?:.ед::/templeader
:?:.ылшсл::/skick
:?:.кузфшк::/repair
:?:.фгтшмшеу::/auninvite
:?:.учсфк::/excar
:?:.агуд::/fuel
:?:.згддекгтл::/pulltrunk
:?:.акууя::/freez
:?:.езсфк::/tpcar
:?:.дфыевкшмук::/lastdriver
:?:.вудшеуь::/delitem
:?:/gc::/getcar
:?:.пс::/getcar
:?:.фв::/admins
:?:/ad::/admins
:?:.з::/players
:?:/p::/players
:?:.здфнукы::/players
:?:.рес::/rescue
:?:/htc::/rescue
:?:.ез::/tp
:?:.ызус::/spec
:?:.ызусщаа::/specoff {Enter} {F5}
:?:.фыьы::/asms
:?:.ф::/a
:?:/sp::/spec
:?:.ыз::/spec
:?:/so::/specoff {Enter} {F5}
:?:.ыщ::/specoff {Enter} {F5}
:?:/kill::/hp 0{left 2}
:?:.лшдд::/hp 0{left 2}
:?:.штсфк::/incar
:?:.пр::/gh
:?:.штм::/inv
:?:.шв::/id
:?:.рз::/hp
:?:.од::/ajail
:?:.фофшд::/ajail
:?:.лшсл::/kick
:?:.ылшсл::/skick
:?:.кузфшк::/repair
:?:.вд::/dl
:?:.уыз::/esp
:?:.уыз2::/esp2
:?:.уыз3::/esp3
:?:.мурыефе::/vehstat
:?:.пуесфк::/getcar
:?:.ифт::/ban
:?:.вудмур::/delveh
:?:.ьез::/mtp
:?:.мур::/veh
:?:.фмур::/aveh
:?:.рфквифт::/hardban
:?:.ьгеу::/mute
:?:.пшв::/gid
:?:.ср::/chide
:?:/ch::/chide
:?:.куысгу::/rescue
:?:.ыуевшь::/setdim
:?:/sd::/setdim
:?:.и::/b
:?:.ц::/w
:?:.ыв::/setdim
:?:.сршву::/chide
:?:.афк::/a афк мин{left 4}
:?:.фгтсгаа::/auncuff
:?:.фсгаа::/acuff
:?:.акууяф::/freeza
:?:/scd::/setcardim
:?:.ыуесфквшь::/setcardim
:?:.ысв::/setcardim
:?:/rst::/resettempname
:?:.кые::/resettempname
:?:.куыуееуьзтфьу::/resettempname
:?:.т::/netstat
:?:/ns::/netstat
:?:.вм::/delveh
:?:/dv::/delveh
:?:/hard::/hardban
:?:.рфкв::/hardban
:?:/as::/asms
:?:.фы::/asms
:?:.пез::/gtp
:?:.пь::/gm
:?:.тс::/noclip
:?:/nc::/noclip
:?:/acf::/acuff
:?:.фса::/acuff
:?:/auf::/auncuff
:?:.фга::/auncuff
:?:.а::/f
:?:.ылшт::/skin
:?:.езр::/tph
:?:.фмур::/aveh
:?:.фдщсл::/alock
:?:.ск::/skick 
:?:.cr::/skick 


:?:.чит::/hardban 9999 Cheats{left 12}
:?:/xbn::/hardban 9999 Cheats{left 12}
:?:.варн::/warn
:?:/dfhy::/warn
:?:.мут::/mute
:?:/ven::/mute
:?:.дем::/ajail
:?:/ltv::/ajail
:?:.бан::/ban
:?:/,fy::/ban
:?:.хард::/hardban
:?:/[fhl::/hardban
:?:.гб::/gunban
:?:/u,::/gunban
:?:.пгтифт::/gunban
:?:.запретка::/ban 3.5 ОПС{left 8}
:?:/pfghtnrf::/ban 3.5 ОПС{left 8}
:?:.звук::/mute 120 Мешающие звуки{left 19}
:?:/pder::/mute 120 Мешающие звуки{left 19}
:?:.помеха::/ajail 10 3.6.2 ОПС{left 13}
:?:/gjvt[f::/ajail 10 3.6.2 ОПС{left 13}
:?:.кик::/kick 3.6.2 ОПС{left 10}
:?:/rbr::/kick 3.6.2 ОПС{left 10}

:?:.нрд::/ajail 15 nonRP Drive{Left 15}
:?:.нрп::/ajail 15 nonRP Поведение{Left 19}
:?:.дб::/ajail 30 DB{Left 6}
:?:.дм::/gunban 5 DM{Left 5}
:?:.дмд::/ajail 120 DM{Left 7}
:?:.пг::/ajail 35 PG{Left 6}
:?:.муз::/mute 30 Music in ZZ{Left 15}
:?:.смник::/ajail 720 Смените Имя_Фамилия согласно правилам сервера{Left 50}
:?:.оскадм::/ban 5 Оскорбление администрации{left 28}

:?:.верт::/veh sparrowc 0 0
:?:/dthn::/veh sparrowc 0 0
:?:.маш::/veh bdivo 0 0
:?:/vfi::/veh bdivo 0 0
:?:.скин::/skin {space}

:?:.ку::Привет, сегодня я слежу за тобой. Хорошего стрима
:?:.привет::Приветствую, на сегодня я ваш ассистент, по любым игровым вопросам - обращайтесь ко мне.
:?:.кпз::Напомню, что как либо контактировать с игроками которые вели процессуальные действия - запрещено.
:?:.авто::Напомню, что краймить на выданном авто нельзя, если заглохнет, то завести можно будет только отверткой.
:?:.искин::Правила не нарушать, RP моменты существенные для скина поддерживать. Будут жалобы - Вас кикнут/накажут. После окончания записи, нужно перезайти на сервер, чтобы снять скин.
:?:.замена::К сожалению, мне нужно тебя покинуть, меня заменит другой Ассистент. Хорошего продолжения стрима
:?:.пока::Спасибо за стрим, хорошего настроения.
:?:.од::Предоставьте одобрение в личные сообщения.

:?:/re::Привет, сегодня я слежу за тобой. Хорошего стрима
:?:/ghbdtn::Приветствую, на сегодня я ваш ассистент, по любым игровым вопросам - обращайтесь ко мне.
:?:/gjrf::Спасибо за стрим, хорошего настроения.
:?:/rgp::Напомню, что как либо контактировать с игроками которые вели процессуальные действия - запрещено.
:?:/bcrby::Правила не нарушать, RP моменты существенные для скина поддерживать. Будут жалобы - Вас кикнут/накажут. После окончания записи, нужно перезайти на сервер, чтобы снять скин.
:?:/pfvtyf::К сожалению, мне нужно тебя покинуть, меня заменит другой Ассистент. Хорошего продолжения стрима
:?:.jl::Предоставьте одобрение в личные сообщения.

:?:.промо::При достижении 3 уровня по твоему промо игроки будут получать: 7 дней PLATINUM VIP и 50.000$.
:?:.лвл::При достижении 5-го уровня: 500 MC, при достижении 10-го уровня: 1000 MC, при достижении 15-го уровня: 2000 MC, при достижении 20-го уровня: 3000 MC, при достижении 25-го уровня: 4000 MC, при достижении 30-го уровня: 5000 MC. Каждый следующий уровень после 30-го будешь получать 1500 MC.
:?:.лвл5::При достижении 5-го уровня: 500 MC.
:?:.лвл10::При достижении 10-го уровня: 1000 MC.
:?:.лвл15::При достижении 15-го уровня: 2000 MC.
:?:.лвл20::При достижении 20-го уровня: 3000 MC.
:?:.лвл25::При достижении 25-го уровня: 4000 MC
:?:.лвл30::При достижении 30-го уровня: 5000 MC. Каждый следующий уровень после 30-го будешь получать 1500 MC.
:?:.пом::Сейчас помогу.
:?:/gjv::Сейчас помогу.
:?:.ключ::/ctp -382.57 -126.32 38.24
:?:.15::/ctp -712.42 -366.30 33.90


:?:.1п::
SendMessage, 0x50,, 0x4190419,, A
SendInput, /asms %qdin% 1/3 предупреждений за {space}
return

:?:.2п::
SendMessage, 0x50,, 0x4190419,, A
SendInput, /asms %qdin% 2/3 предупреждений за {space}
return

:?:.3п::
SendMessage, 0x50,, 0x4190419,, A
SendInput, /asms %qdin% 3/3 предупреждений за .Если продолжешь нарушать, будет полноценное наказание. {left 56}
return

:?:.не::
SendMessage, 0x50,, 0x4190419,, A
SendInput, /asms Не нарушайте, иначе Вы получите наказание.{left 43}
return

:?:/ye::
SendMessage, 0x50,, 0x4190419,, A
SendInput, /asms Не нарушайте, иначе Вы получите наказание. {left 43}
return

:?:.уст::
SendMessage, 0x50,, 0x4190419,, A
SendInput, /asms %qdin% Не стоит нарушать правила сервера.
return

:?:/ecn::
SendMessage, 0x50,, 0x4190419,, A
SendInput, /asms %qdin% Не нарушай, иначе ты получишь предупреждение.
return

;===========================================================================================================================================================
; Остальные функции ==============================================================================================================================

Reload:
reload
return

^F9::reload
^F10::Exitapp

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
