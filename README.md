# myHotKey

> 我只想看看还有多少人用 window 系统办公，像我一样在太阳下低头。

工欲善其事，必先利其器。买 mac 和 [HHKB](https://xiaozhou.net/got_hhkb_pro_2-2013-06-03.html)，但作为一名收入还不是很稳定的前端，公司又不标配这些，又不想用自己的 mac 办公。工作难免会用 window 系统 ，那就学点 `autohotkey` ， 效率贼 6。毕竟现在文档已经很成熟了，想搞事情还是可以的。什么 mac 键，抛弃 ctrl，工作流，都依你，开心就好!

* [官网](https://www.autohotkey.com/)
* [下载](https://www.autohotkey.com/download/)
* [中文](https://wyagd001.github.io/zh-cn/docs/AutoHotkey.htm)

可以参考下，[我的配置](https://github.com/leer0911/myHotKey)。先来看下我都用`autohotkey` 做了什么。虽然可以用很多工具实现，但我还是会选择不安装过多软件，能自己实现不是很好么~ window 下我只推荐[listary](http://www.listary.com/)。

用的舒服的话，可以把 `myHotKey.ahk` 文件放在开机自动启动即可。

## myHotKey 能做什么

下面是我整合的一些常用操作： [github 地址](https://github.com/leer0911/myHotKey) PS: 当然不一定是你想要的。而且很可能不习惯，所以在用之前你可以先大概看一下，最后修改为你自己想要的 ahk 脚本。

* 快速打开常用网址，如按下 f4 即可打开我的 github

```ahk
f4::Run http://github.com/leer0911/
```

* 搜索引擎整合，如按下 f1 可以用谷歌搜索选中的文本，f6 可以触发搜索 前端常用的[devdocs](http://devdocs.io/) 如 mac 里面的`dash`

```ahk
f1::
current_clipboard = %Clipboard%
Send ^c
ClipWait, 1
Run http://www.google.com/search?q=%Clipboard%
Clipboard = %current_clipboard%
return
```

* 光标快速移动，映射了键盘上的方向键。(把 alt 键当 mac 键用) 但是如果是用 vscode 编辑器。我还是觉得 `jumpy` 插件最好跳转了。用的不开心还能改源码~

  * alt+i 触发 向上键
  * alt+j 触发 向左键
  * alt+k 触发 向下键
  * alt+l 触发 向右键

```ahk
; 键盘键位替换,如 上下左右 删除 全选
<!i::send {Up}
<!k::send {Down}
<!j::send {Left}
<!l::send {Right}
<!u::send {Backspace}
<!a::send ^a
```

* 快速选择文本，用过 `vim` 的应该都喜欢光标快速跳转，文本快速选中。只要你想要。完全能打造成任意编辑器下的 vim 。

  * alt+shift+i 触发 向上选中文本
  * alt+shift+j 触发 向左选中文本
  * alt+shift+k 触发 向下选中文本
  * alt+shift+l 触发 向右选中文本

```ahk
+!i::send +{up}
+!j::send +{left}
+!l::send +{right}
+!k::send +{down}
+!;::send +{end}
+!h::send +{home}
```

* 一些常用但是按起来特别变扭的符号 如 `#` `.` 等，用别的按键映射。这个完全看个人习惯。如我不常用 `CapsLock(大小写键)` 则将其修改为 右`shift`键。

  * CapsLock + j 对应 `#`
  * CapsLock + d 对应 `.`
  * CapsLock + k 对应 `()`
  * CapsLock + l 对应 `{}`

```ahk
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
```

* 我最常用的功能应该是 任意软件 置顶 ， 改变软件透明度。对于我们前端来说。总觉得屏幕不够用，老板又不肯买两个屏幕。怎么办。编辑器半透明呗，这样就可以边敲代码边看设计稿了。看 API 的时候也是。可以让编辑器置顶，半透明再配合 浏览器的 `vimium` 插件，你就可以边敲代码边看文档了。

  * 双击 shift 实现软件置顶
  * alt + + 实现降低软件透明度
  * alt + - 实现增加软件透明度

* 更多的功能，待你们去挖掘。记得分享~

**觉得可以的话，可以继续看下教程。**

## 快速入门

毕竟学习一门新语言是需要时间的，下面只是简单描述下我用 autohotkey 接触到的东西，这样当你想用我这套 hotkey 的时候能看懂并能修改成自己想要的。当然，想系统学习的同学可以直接参考[官方文档](https://wyagd001.github.io/zh-cn/docs/Tutorial.htm)

* 下载&安装 autohotkey
* 新建 后缀为.ahk 的文件并运行

### 热键

首先了解，代码中修饰符都代表了键盘中的哪些按键，你只要知道了修饰符边可以通过代码来让按键搞事情(脚本动作)。热键是通过一对 :: 创建的. 按键名或组合按键名必须在 :: 左边. 代码则跟在后面, 以 Return 结束。(单行可省略 return) 比如

```ahk
^j::
   Send, My First Script
Return
```

当你的 autohotkey 正常运行你编写的代码时。按下 `ctrl+j` 会输出 `My First Script` 这么一段文字。

| 符号 | 说明           |
| ---- | -------------- |
| #    | win            |
| !    | alt            |
| ^    | control        |
| +    | shift          |
| &    | 用于组合按键   |
| <    | 左按键         |
| >    | 右按键         |
| \*   | 通配符         |
| ~    | 保留按键原功能 |
| UP   | 释放时触发热键 |

[详细](https://wyagd001.github.io/zh-cn/docs/Hotkeys.htm)

#### 禁用按键

通过不为按键或按键组合的热键指定任何操作可以在整个系统中完全禁用它们. 下面的例子中禁用了右 Windows 键:

```ahk
RWin::return
```

#### 上文相关按键

当需要在某些特定软件中设定热键则需要了解，上下文按键

[#IfWinActive/Exist](https://wyagd001.github.io/zh-cn/docs/commands/_IfWinActive.htm) 和 [#if](https://wyagd001.github.io/zh-cn/docs/commands/_If.htm)指令可以用来让热键根据不同的条件执行不同的动作例如:

```ahk
#IfWinActive, ahk_class Notepad
^a::MsgBox 你在记事本中按下了 Ctrl-A . 而在其他窗口中按下 Ctrl-A 将原样发送.
#c::MsgBox 你在记事本中按下了 Win-C 组合键.

#IfWinActive
#c::MsgBox 你在非记事本程序中按下了 Win-C .

#If MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp::Send {Volume_Up}     ; 在任务栏上滚动滚轮:增加/减小音量.
WheelDown::Send {Volume_Down} ;
```

### 热字符串

热字串主要用于扩展你的缩写库(自动替换). 当然, 它也可以用来映射任何脚本动作。比如

```ahk
::ftw::Free the whales
```

热字串会将你输入的"ftw"转换为"Free the whales"。

## 搞事情啦

知道了热键和热字符串，肯定想知道能用他来搞什么事情。

### 发送按键

现在你决定发送一些按键到一个程序中. 你可以使用 Send 命令. Send 表示发送按键, 模拟打字或按键操作.如

```ahk
Send !+a
```

会按下 ALT+SHIFT+a

[更多 send 命令](https://wyagd001.github.io/zh-cn/docs/commands/Send.htm)

### 运行程序和网页

想要运行画图(mspaint.exe), 计算器(calc.exe), 脚本`.ahk` 等程序或要打开一个文件夹, 你可以使用 Run 命令. 你还可以用这个命令打开一个网址, 比如打开 `https://autohotkey.com/` . 如果你想打开一个已经安装好的程序, 也很简单, 就像这样:

```ahk
; 运行一个程序. 注: 大部分的程序可能需要完整路径.
Run, %A_ProgramFiles%\Some_Program\Program.exe

; 打开一个网址
Run, https://autohotkey.com
```

[更多 run 命令](https://wyagd001.github.io/zh-cn/docs/commands/Run.htm)

### 命令和函数索引

AutoHotkey 有两个重要的工具供开发者使用:命令和函数

[官方文档](https://wyagd001.github.io/zh-cn/docs/commands/index.htm)
