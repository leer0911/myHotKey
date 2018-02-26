; 常用网址 ----------------------------------------------

f4::Run http://github.com/leer0911/


; 搜索相关 ----------------------------------------------

; 用谷歌搜索选中文本
f1::
current_clipboard = %Clipboard% 
Send ^c
ClipWait, 1 
Run http://www.google.com/search?q=%Clipboard%
Clipboard = %current_clipboard% 
return

; 用百度搜索选中文本
f7::
current_clipboard = %Clipboard% 
Clipboard = 
Send ^c
ClipWait, 1 
Run https://www.baidu.com/s?wd=%Clipboard%
Clipboard = %current_clipboard% 
return

; devdocs搜索
f6::
Send ^c
Run http://devdocs.io/
sleep 1000
Send ^v
Send {enter}
return

; 用MDN搜索选中文本
f3::
current_clipboard = %Clipboard% ;
Clipboard = ;
Send ^c
ClipWait, 1 ;
Run https://developer.mozilla.org/zh-CN/search?q=%Clipboard%
Clipboard = %current_clipboard% ;
return

; 有道翻译 ps 必须将有道翻译设置为对应快捷键
!y::
Send ^c
sleep 100
Send !^x
sleep 200
Send ^v
return

; 热字符串 -----------------------------------------------

:*:gitc::git clone +{Insert}
; bash命令
:*:cdd::cd ~/Desktop
:*:cpp::cp ~/Desktop ~/Desktop
:*:rmm::rm -rf

; 更改大小写键位为 alt + Capslock , Capslock 修改为 Rshift
!Capslock::Capslock
Capslock::Rshift

; 常用符号快捷键生成 如 < $ # * > + ^ - = ! {} () . , 
>+h::send <
>+s::send $
>+j::send {#}
>+x::send *
>+u::send >
>+o::send {^}
>+i::send {+}
>+n::send -
>+m::send {=}
>+l::send {{}
>+k::send (
>+g::send {!}
>+d::send .
>+f::send {,}
>+space::send {=}

; 鼠标事件 -----------------------------------------------

#z::LButton
#h::LButton
#w::send {WheelUp}
#s::send {WheelDown}

; 快捷键修改 ---------------------------------------------

; 键盘键位替换,如 上下左右 删除 全选
<!i::send {Up}
<!k::send {Down}
<!j::send {Left}
<!l::send {Right}
<!u::send {Backspace}
<!a::send ^a

; 让 window 快捷键 更像 mac
  <!c::send ^c
  <!v::send ^v
  <!s::send ^s
  <!x::send ^x
  <!z::send ^z
  <!d::send ^d
  <!f::send ^f

; 快速选择
  +!i::send +{up}
  +!j::send +{left}
  +!l::send +{right}
  +!k::send +{down}
  +!;::send +{end}
  +!h::send +{home}

; 变态到连 tab 和 esc 都要 映射
IfWinActive, ahk_class SunAwtFrame
{
    !w::send {Esc}
    !e::send {Tab}
}

; win10桌面切换 win+j，k 代表左右 ，win+3主要是打开 chrome 的 调试工具的选择器
#j::send ^#{right}
#k::send ^#{left}
#1::send {F11}
#2::send {F12}
#3::
send {F12}
send ^+c
return
#x::send !{F4}
#d::WinMinimizeAll

; 程序运行快捷键 ---------------------------------------------------------

!g::
Run C:\Program Files (x86)\Google\Chrome\Application\chrome.exe
Return

; 窗口置顶，半透明 -----------------------------------------------
<Shift::
    if (A_PriorHotKey = "<Shift" AND A_TimeSincePriorHotKey < 500)
    {
        WinGet ow, id, A
        WinTopToggle(ow)
    }
    return
#0::
!0::
    WinGet ow, id, A
    WinTopToggle(ow)
    return
WinTopToggle(w) {

    WinGetTitle, oTitle, ahk_id %w%
    Winset, AlwaysOnTop, Toggle, ahk_id %w%
    WinGet, ExStyle, ExStyle, ahk_id %w%
    if (ExStyle & 0x8)  ; 0x8 为 WS_EX_TOPMOST.在WinGet的帮助中
        oTop = Ture
    else
        oTop = False
    tooltip %oTitle% %oTop%
    SetTimer, RemoveToolTip,1000
    return

    RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return
}

#=::
!=:: ;; alt-=
    WinGet, ow, id, A
    WinTransplus(ow)
    return
#-::
!-:: ;; alt--
    WinGet, ow, id, A
    WinTransMinus(ow)
    return
;; WinTransplus WinTransMinus 对ahk_id为w的窗口
;; 进行透明度增减，每次幅度为10
WinTransplus(w){

    WinGet, transparent, Transparent, ahk_id %w%
    if transparent < 255
        transparent := transparent+10
    else
        transparent =
    if transparent
        WinSet, Transparent, %transparent%, ahk_id %w%
    else
        WinSet, Transparent, off, ahk_id %w%
    return
}
WinTransMinus(w){

    WinGet, transparent, Transparent, ahk_id %w%
    if transparent
        transparent := transparent-10
    else
        transparent := 240
    WinSet, Transparent, %transparent%, ahk_id %w%
    return
}