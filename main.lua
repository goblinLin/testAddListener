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
background.id = "bg"
background:setFillColor( 1,1,0)
background.anchorX = 0
background.anchorY = 0

local btn1 = display.newImageRect(  "images/go.png", 90, 90 )
btn1.id = "btn1"
btn1.x = _VIEWSPACE.CENTER.X
btn1.y = _VIEWSPACE.HEIGHT / 6 * 1

local btn2 = display.newImageRect(  "images/stop.png", 90, 90 )
btn2.id = "btn2"
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
	print('touch2')
	print('target id:' .. target.id)
	if (e.phase == "began") then
		print('target id:' .. target.id)
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

--多個元件共同使用的第二種版本，可得到自身元件
local function touch3(self ,e)
	local target = e.target
	print('target id:' .. target.id)
	print('self id:' .. self.id)
	if (e.phase == "began") then
		print('target id:' .. target.id)
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

--由程式來發動事件
timer.performWithDelay( 3100, function ( )
	print( 'click by program' )
	local event = { name="touch" , target=btn1 , phase ="began"} --觸發按下去事件
	btn1:dispatchEvent( event )
end )

timer.performWithDelay( 3200, function ( )
	print( 'click by program' )
	local event = { name="touch" , target=btn1 , phase ="ended"} --觸發放開事件
	btn1:dispatchEvent( event )
end )


--區域事件函式的第一種偵聽方法
--btn2:addEventListener("touch",touch2)
--區域事件函式的第二種偵聽方法
--btn2.touch = touch3
--btn2:addEventListener("touch",btn2)
--background:addEventListener("touch",touch2)

--移除偵聽器
--btn1:removeEventListener( "touch")
--btn2:removeEventListener( "touch" , touch2)