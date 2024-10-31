# winautohidev2

[(中文介绍)](https://github.com/windwhim/winautohidev2)  [(English Introduction)](https://github.com/windwhim/winautohidev2/blob/main/README_en.md)

## 介绍

使用快捷键将当前窗口隐藏到屏幕边缘。

灵感来自于[Preme for Windows](http://www.premeforwindows.com/) 和 [winautohide](https://github.com/scavin/winautohide)。

它们使用 [AutoHotKeyV1](http://www.autohotkey.com/)，此repo使用AutoHotKeyV2编写，故命名为`winautohidev2`。

在Window 11 26100.2161上运行良好，并且使用[DPI.ahk](https://github.com/Descolada/AHK-v2-libraries/blob/main/Lib/DPI.ahk)优化了多显示器和高DPI缩放下使用的问题。

以下内容部分引用自[winautohide](https://github.com/scavin/winautohide)。

> 如果你经常需要用到某些小窗口（例如记事本、命令行等）又想简单滑动鼠标就可以调出这些小窗口，这小脚本对你会有用。
>
> 在激活想要隐藏的窗口后，按下`Ctrl+Left`，这窗口就会按所按的方向键自动隐藏到屏幕边缘。这自动隐藏窗口会保持最顶并在屏幕边缘留下一像素的窗边。当鼠标指针触及这窗边的时候，该自动隐藏窗口就会重新出现并取得焦点供你使用；当鼠标指针移出该窗口时它又会重新隐藏，当将窗口向外拖动可取消隐藏状态。
>
> 就如你在使用自动贴边隐藏的窗口（如自动隐藏的任务栏、贴边隐藏的QQ主窗口）一样。
>
> 兼容 Windows11。

## 使用

### 方法一

1. 请先安装 [AutoHotKeyV2](http://www.autohotkey.com/)。

2. 下载所有`.ahk`文件。
3. 运行 `winautohidev2.ahk` 。
4. 使用`Ctrl+Left`将窗口屏幕隐藏到左侧，最大化窗口不可隐藏。

### 方法二

1. 前往 [Release](https://github.com/windwhim/winautohidev2/release) 下载最新版。
