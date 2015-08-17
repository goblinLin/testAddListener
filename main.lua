-----------------------------------------------------------------------------------------
--  這個範例解說如何為按鈕加上一個Touch Event Listener
--  這個範例示範的Event為touch，相關更多該Event的資訊請參考以下網址
--  https://docs.coronalabs.com/api/event/touch/index.html
--	Author: Zack Lin
--	Time: 2015/8/17
-----------------------------------------------------------------------------------------

_VIEWSPACE = {
	HEIGHT = display.viewableContentHeight,
	WIDTH = display.viewableContentWidth
}

_VIEWSPACE.CENTER = {
	X = display.contentCenterX,
	Y = display.contentCenterY
}

--設定背景為黃色
local background = display.newRect( 0 , 0, _VIEWSPACE.WIDTH, _VIEWSPACE.HEIGHT )
background:setFillColor( 1,1,0)
background.anchorX = 0
background.anchorY = 0

local btn1 = display.newImageRect(  "images/go.png", 90, 90 )
btn1.x = _VIEWSPACE.CENTER.X
btn1.y = _VIEWSPACE.HEIGHT / 6 * 1

local btn2 = display.newImageRect(  "images/stop.png", 90, 90 )
btn2.x = _VIEWSPACE.CENTER.X
btn2.y = _VIEWSPACE.HEIGHT / 6 * 3

--宣告當按鈕觸發touch事件所要執行的內容
--這種寫法只能供某一個元件使用，且需宣告為全域函數
function btn1:touch(e)
	--e最常用的兩個屬性，target為事件觸發物件，phase為事件階段
	--按鈕事件概分為began.moved.canceled以及ended
	if (e.phase == "began") then
		print( "onClick Go began" );
		e.target.xScale = 1.2
		--btn1.xScale = 1.2
		btn1.yScale = 1.2
	elseif(e.phase == "moved") then
	elseif(e.phase == "ended" or e.phase == "canceled") then	
		print("onClick Go ended");
		btn1.xScale = 1
		btn1.yScale = 1
	end
	return true;
end

--這種寫法可讓多個元件共同使用
local function touch2(e)
	local target = e.target
	if (e.phase == "began") then
		print( "onClick Stop began" );
		target.xScale = 1.2
		target.yScale = 1.2
		-- 設定專注
        display.getCurrentStage():setFocus( target )
        target.isFocus = true
	elseif(e.phase == "moved") then
	elseif(e.phase == "ended" or e.phase == "canceled") then	
		print("onClick Stop ended");
		target.xScale = 1
		target.yScale = 1
		-- 取消專注
        display.getCurrentStage():setFocus( nil )
        target.isFocus = nil
	end
	--是否攔截Event Queue
	return true;
end

--加入偵聽器
btn1:addEventListener( "touch" )
btn2:addEventListener("touch",touch2)

--移除偵聽器
--btn1:removeEventListener( "touch")
--btn2:removeEventListener( "touch" , touch2)