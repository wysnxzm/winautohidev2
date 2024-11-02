#Requires AutoHotkey v2.0
#include Array.ahk
#include DPI.ahk
; 实现窗口平滑移动，越小越平滑，最小为-1
SetWinDelay(5)

; 隐藏时留出的长度以及显示时距离屏幕边缘的长度
; 由于DPI关系，margin设置，不同DPI可能不同
margin := 20
showMargin := 0
global margin
global showMargin
; 移动范围
moveDistance := 30
global moveDistance

; 隐藏的窗口
hiddenWindowIds := []
global hiddenWindowIds
; 中间态窗口，鼠标放置暂时显示的窗口
suspendWindowIds := []
global suspendWindowIds

maxHeight := 1000

; 加入右键菜单
myMenu := A_TrayMenu
myMenu.Add()
myMenu.Add("Reset all hidden windows", Reset)


Reset(*){
	results := getSide()
	leftMonitor := results[1]
	leftEdge := results[3]
	MonitorGet leftMonitor,,&topEdge
	dpiValue := getDPI(leftMonitor)
	; 多显示器支持
	global leftEdge
	global dpiValue
	global topEdge
	for i,v in hiddenWindowIds{
		WinMove(showMargin+leftEdge,showMargin+topEdge,,,"ahk_id" v)
	}
}



SetTimer WatchCursor, 200

WatchCursor(){
	; 某些时候会出错
	Try 
	{
		DPI.MouseGetPos , , &id, &control
	    ; 判断是否为中间态，是则不需要移动
	    isSuspend := suspendWindowIds.Find((v) => (v =id))
	    if isSuspend > 0{
	    	;拖动窗口去除隐藏
	    	if (isWindowMove(id)=1){
	    		isHidden := hiddenWindowIds.Find((v) => (v =id))
	    		hiddenWindowIds.RemoveAt(isHidden)
	    		suspendWindowIds.RemoveAt(isSuspend)
	    		WinSetAlwaysOnTop(0,"ahk_id" id)
	    		; ToolTip("去除隐藏")
	    		; sleep(1000)
	    		; ToolTip
	    	}
	    }
	    else{
	    	; 不为中间态时，则若为其他隐藏窗口则不隐藏，接着判断是否为隐藏的窗口
		    isHidden := hiddenWindowIds.Find((v) => (v =id))
		    ; 隐藏窗口则显示
		    if isHidden>0 {
		    	showWindow(id)
		    }
		    else{
		    	;按顺序隐藏
		    	if suspendWindowIds.Length > 0{
		    		suspendId := suspendWindowIds.Get(suspendWindowIds.Length)
			    	suspendWindowIds.RemoveAt(suspendWindowIds.Length)
			    	hideWindow(suspendId)
	    		} 
		    }
	    }
	    ; else{
	    ; 	; 不为中间态时，则直接隐藏，接着判断是否为隐藏的窗口
		;     isHidden := hiddenWindowIds.Find((v) => (v =id))
		;     ; 切换到其他窗口继续隐藏
	    ; 	if suspendWindowIds.Length > 0{
	    ; 		suspendId := suspendWindowIds.Get(1)
		;     	suspendWindowIds.RemoveAt(1)
		;     	hideWindow(suspendId)
	    ; 	} 
		;     ; 隐藏窗口则显示
		;     if isHidden>0 {
		;     	showWindow(id)
		;     }
	    ; }
	}
}



^Left::{
	results := getSide()
	leftMonitor := results[1]
	leftEdge := results[3]
	MonitorGet leftMonitor,,&topEdge
	dpiValue := getDPI(leftMonitor)
	; 多显示器支持
	global leftEdge
	global dpiValue
	global topEdge

	id := WinGetID("A")
	hideWindow(id)
}
F4::{
	; getWinPos
	; 多显示器支持
	
	id := WinGetID("A")
	window := "ahk_id" id

	; Get window position and size
	DPI.WinGetPos(&X, &Y, &W, &H, window)
	MsgBox "Window Position: " X ", " Y "`nWindow Size: " W " x " H
}

F8::{
	getSide()
}


hideWindow(id){
	
	window := "ahk_id" id
	;最大化窗口不可隐藏
	if WinExist(window) and WinGetMinMax(window) != 1{
		DPI.WinGetPos(&X, &Y, &W, &H,window)
		; 乘以dpi 使用DPI缩放
		NewX := -Round(W*dpiValue)+leftEdge+margin
		; WinMove(NewX, Y,,,window) 
		Y :=Max(Y,topEdge)
		if H>maxHeight{
			WinMove(,Y,,H,window)
		}
		winSmoothMove(newX,Y,window)
		WinSetAlwaysOnTop(1, window)
		pushTo(hiddenWindowIds,id)
	}
}

showWindow(id){
	window := "ahk_id" id
	DPI.WinGetPos(&X, &Y, &W, &H,window)
	NewX := showMargin+leftEdge
	; WinMove(NewX, Y,,,window)
	winSmoothMove(newX,Y,window)
	pushTo(suspendWindowIds,id)
}
isWindowMove(id){
	window := "ahk_id" id
	DPI.WinGetPos(&X, &Y, &W, &H,window)
	; 当窗口横坐标大于margin一定程度，认为移动
	if (X>showMargin+moveDistance){
		return 1
	}
	else{
		return 0
	}
}
; 列表不允许存在相同的值
pushTo(array,value){
	if array.Find((v) => (v =value)) <= 0{
		array.push(value)
	}
}
;从a到b的数组
createArray(a, b,length) {
	; Calculate the step to divide the range into length parts
    arr := []
    step := (b - a) / (length-1)  
    value := a
    Loop length {
        arr.Push(Round(value))
        value += step  ; Increase each value by step
    }
    arr.Push(b)
    return arr
}
; 平滑移动
winSmoothMove(newX,newY,window){
	DPI.WinGetPos(&X,, ,, window)
	arr := createArray(X,NewX,10)
	for i,v in arr{
		WinMove(v,newY,,,window)
	}
}

;多显示器支持
;获取左右边界和显示器索引
getSide(){
	leftEdge := 1
	rightEdge := -1
	leftMonitor :=0
	rightMonitor :=0
	i:=1
	while i<=MonitorGetCount(){
		MonitorGet i, &leftEdgeTemp,,&rightEdgeTemp
		if leftEdge > leftEdgeTemp{
			leftEdge := leftEdgeTemp
			leftMonitor := i
		}
		if rightEdge<rightEdgeTemp{
			rightEdge:=rightEdgeTemp
			rightMonitor:=i
		}
		i+=1
		; MsgBox(i "," leftEdgeTemp "," rightEdgeTemp)
	}
	return [leftMonitor,rightMonitor,leftEdge,rightEdge]
}

getDPI(monitorIndex){
	monitorHandles := DPI.GetMonitorHandles()
	dpiValue := DPI.GetForMonitor(monitorHandles.Get(monitorIndex))
	dpiValue := dpiValue / 120 * 125 / 100
	return dpiValue
}

