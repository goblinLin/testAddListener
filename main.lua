-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

--[[
	這個範例解說如何為按鈕加上一個Touch Event Listener，並說明如何用程式來發出事件
	Author: Zack Lin
	Time: 2015/3/13
]]

_VIEWSPACE = {
	HEIGHT = display.viewableContentHeight,
	WIDTH = display.viewableContentWidth
}

_VIEWSPACE.CENTER = {
	X = display.contentCenterX,
	Y = display.contentCenterY
}

local background = display.newRect( 0 , 0, _VIEWSPACE.WIDTH, _VIEWSPACE.HEIGHT )
background:setFillColor( 1,1,0)
background.anchorX = 0
background.anchorY = 0

local btn1 = display.newImageRect(  "images/start.png", 54, 39 )
btn1.x = _VIEWSPACE.CENTER.X
btn1.y = _VIEWSPACE.HEIGHT / 6 * 1

local btn2 = display.newImageRect(  "images/start.png", 54, 39 )
btn2.x = _VIEWSPACE.CENTER.X
btn2.y = _VIEWSPACE.HEIGHT / 6 * 3

--宣告當按鈕觸發touch事件所要執行的內容
--這種寫法只能供某一個元件使用
function btn1:touch(e)
	print( 'btn1:touch' )
	if (e.phase == "began") then
		print( "onClick began" );
		btn1.xScale = 1.2
		btn1.yScale = 1.2
	elseif(e.phase == "moved") then
	elseif(e.phase == "ended" or e.phase == "canceled") then	
		print("onClick ended");
		btn1.xScale = 1
		btn1.yScale = 1
	end
	return true;
end

--這種寫法可讓多個元件共同使用
local function touch2(e)
	print( 'touch2' )
	local target = e.target
	if (e.phase == "began") then
		print( "onClick began" );
		target.xScale = 1.2
		target.yScale = 1.2
	elseif(e.phase == "moved") then
	elseif(e.phase == "ended" or e.phase == "canceled") then	
		print("onClick ended");
		target.xScale = 1
		target.yScale = 1
	end
	return true;
end

--加入偵聽器
btn1:addEventListener( "touch" )
btn2:addEventListener("touch",touch2)

--由程式來發動事件
timer.performWithDelay( 3100, function ( )
	print( 'click by program' )
	local event = { name="touch" , phase ="began"} --觸發按下去事件
	btn1:dispatchEvent( event )
end )

timer.performWithDelay( 3200, function ( )
	print( 'click by program' )
	local event = { name="touch" , target=btn1 , phase ="ended"} --觸發放開事件
	btn1:dispatchEvent( event )
end )




