# winautohidev2

[(中文介绍)](https://github.com/windwhim/winautohidev2)  [(English Introduction)](https://github.com/windwhim/winautohidev2/blob/main/README_en.md)

## Introduction

![introduction](assest\introduction.gif)

Use shortcuts to hide the current window to the edge of the screen.

Inspired by [Preme for Windows](http://www.premeforwindows.com/) and [winautohide](https://github.com/scavin/winautohide).

They use AutoHotKeyV1, this repo is written in AutoHotKeyV2, so it is named `winautohidev2`.

Works well on Windows 11 26100.2161 and optimizes for use with multiple monitors and high DPI scaling using [DPI.ahk](https://github.com/Descolada/AHK-v2-libraries/blob/main/Lib/DPI.ahk).

The following is partially quoted from [winautohide](https://github.com/scavin/winautohide).


>If you often need to use certain small windows (e.g. Notepad, command line, etc.) and want to simply swipe the mouse to bring up these small windows, this small script will be useful for you.
>
>After activating the window you want to hide, press `Ctrl + Left`and the window will be automatically hidden to the edge of the screen by pressing the arrow keys. This automatically hides the window and leaves a pixel window edge at the edge of the screen. When the mouse pointer touches the window edge, the automatically hidden window will reappear and gain focus for your use; when the mouse pointer moves out of the window, it will be hidden again, and when the window is *dragged out*, it can be unhidden.
>
>Just like you are using an auto-welded hidden window (such as an auto-hidden action sheet, a welded hidden QQ main window).
>
>Compatible with Windows 11.

## Usage

### One

1. Please install [AutoHotKeyV2](http://www.autohotkey.com/).

2. Download all `.ahk` files or clone this repo.
3. Run `winautohidev2.ahk`.
4. Use `Ctrl + Left` to hide the window screen to the left, the maximized window cannot be hidden.

### Two

1. Go to [Release](https://github.com/windwhim/winautohidev2/release) and download the latest version.