---------------------------
--基础函数库
--by滨州IT疯子
--------------------------
function F检查分辨率() --检查分辨率函数 from 云耳
	if w == 720 and h==1280 then
		sysLog("分辨率支持！")
		require('data')
	else
		toast("抱歉，仅支持分辨率：720*1280。")
		mSleep(1000)
		lua_exit()
	end
end
function F检查是否是主页()
	
	local page =F获取当前页面();
	sysLog("当前页面:"..page)
	if page ~="游戏主页" then
		toast("请进入游戏主页后运行脚本")
		mSleep(5000)
		lua_exit()
	end
	
end

--返回值>50为静止，这里可以根据实际情况来改变数值
function 检测静止()
	local gc
	local js=0
	local ww,hh
	local w, h= getScreenSize() --获取设备分辨率
	if w>h then ww=w hh=h else ww=h hh=w end
	
	if oc==nil then
		oc={ --检测屏幕是否静止
			{0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0},
			{0,0,0,0,0,0,0,0,0,0},
		}
		
	end
	keepScreen(true)
	setScreenScale(w,h,0)
	for i=1,10 do
		for j=1,10 do
			-- ss=ss+1
			gc=getColor(i*math.ceil(ww/11),j*math.ceil(hh/11))
			if oc[i][j]==gc then
				js=js+1
			end
			oc[i][j]=gc
		end
	end
	keepScreen(false)
	sysLog('屏幕数量：'..js)
	return js
end

function F点击(x, y)  --点击函数
	local x, y = x, y
	math.randomseed(tostring(os.time()):reverse():sub(1, 6))  --设置随机数种子
	local index =0 --math.random(1,5)
	x = x + math.random(-3,3)
	y = y + math.random(-3,3)
	touchDown(index,x, y)
	mSleep(math.random(60,180))                --某些特殊情况需要增大延迟才能模拟点击效果
	touchUp(index, x, y)
	taptime=mTime()
	mSleep(500)
end
function F多点比色(array,s) --多点比色
	s = s or 95
	s = math.floor(0xff*(100-s)*0.01)
	for var = 1, #array do
		local lr,lg,lb = getColorRGB(array[var][1],array[var][2])
		local rgb = array[var][3]
		
		local r = math.floor(rgb/0x10000)
		local g = math.floor(rgb%0x10000/0x100)
		local b = math.floor(rgb%0x100)
		if math.abs(lr-r) > s or math.abs(lg-g) > s or math.abs(lb-b) > s then
			return false
		end
	end
	return true
end
function F多点找色(t)  --多点找色
	return findMultiColorInRegionFuzzy(t[1],t[2], t[3], t[4], t[5], t[6], t[7])
end

function F寻找地图任务(t,s)  --多点找色
	s = s or 96
	return findMultiColorInRegionFuzzy(t[1],t[2],s, t[3], t[4], t[5], t[6])
end
function F获取当前页面() --获取当前页面函数
	local res = '未知页面'
	keepScreen(true)
	if needScale then
		setScreenScale(_w,_h,0)
	end
	for _, v in pairs(界面列表) do
		if F多点比色(v[2]) then
			res = v[1]  --界面名称
			break
		end
	end
	if needScale then
		resetScreenScale()
	end
	keepScreen(false)
	sysLog(res)
	return res
end
function F点击页面元素(page,unit) --点击元素
	sysLog('点击模块当前页面：'..page.n)
	sysLog('点击模块当前元素：'..unit)
	local x,y
	local res=false
	keepScreen(true)
	if needScale then --缩放
		setScreenScale(_w,_h,0)
	end
	for _ , v in pairs(page) do
		if v.w=='CC' then
			--sysLog('循环K：'..v[1])
			if F多点比色(v.c) and v[1]==unit then
				sysLog('当前点击：'..v[1])
				F点击(v.tap[1],v.tap[2])
				res = true
				break
			end
		elseif v.w=='MSC' then
			x,y=F多点找色(v.c)
			sysLog('找:'..v[1]..'x='..x..'y='..y)
			if x>-1 and y>-1 and v[1]==unit then
				F点击(x,y)
				res=true
				break
			end
		end
	end
	if needScale then
		--setScreenScale(_w,_h,0)
		resetScreenScale()
	end
	keepScreen(false)
	return res
end
function F运行(t) --运行任务函数
	B记录时间=mTime()
	while true do
		if mTime()-B记录时间>B超时时间 then
			break
		end
		B当前页面=F获取当前页面() --获取当前页面
		for k,v in pairs(t) do
			sysLog("vvvvvvv1:")
			sysLog(tostring(v[1]))
			if B当前页面==v[1] then
				for _,_v in pairs(v[2]) do
					sysLog('传入点击元素：'.._v)
					if F点击页面元素(v[1],_v) then
						B记录时间=mTime()
						break
					end
				end
			end
		end
		mSleep(1000)
	end
end