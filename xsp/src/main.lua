require "init" --初始化库
require "libs" --函数库
require "data" --函数库

canSearch=true --能否可以搜寻任务

function 搜寻任务()
	xFind,yFind = F寻找地图任务(任务感叹号)
	if xFind ~= -1 then  --如返回的table不为空（至少找到一个符合条件的点）
		sysLog("找到任务感叹号"..xFind..":"..yFind)
		F点击(xFind,yFind+130)
	else
		x金矿,y金矿 = F寻找地图任务(金矿)
		x金矿2,y金矿2 = F寻找地图任务(金矿2)
		x伐木场,y伐木场 = F寻找地图任务(伐木场)
		x魔泉,y魔泉 = F寻找地图任务(魔泉)
		x秘银,y秘银 = F寻找地图任务(秘银)
		x血钻,y血钻 = F寻找地图任务(血钻)
		x血钻2,y血钻2 = F寻找地图任务(血钻2)
		x紫水晶,y紫水晶 = F寻找地图任务(紫水晶,92)
		x紫水晶2,y紫水晶2 = F寻找地图任务(紫水晶2)
		
		x古矮人遗迹,y古矮人遗迹 = F寻找地图任务(古矮人遗迹)
		x废弃教堂,y废弃教堂 = F寻找地图任务(废弃教堂)
		x地下迷宫,y地下迷宫 = F寻找地图任务(地下迷宫)
		x莫森古国遗迹,y莫森古国遗迹 = F寻找地图任务(莫森古国遗迹)
		x闹鬼庄园,y闹鬼庄园 = F寻找地图任务(闹鬼庄园)
		x阴暗洞穴,y阴暗洞穴 = F寻找地图任务(阴暗洞穴)
		x亚拉戈遗迹,y亚拉戈遗迹 = F寻找地图任务(亚拉戈遗迹)
		x地底深渊,y地底深渊 = F寻找地图任务(地底深渊)
		
		if x金矿 ~= -1  then
			sysLog("找到任务x金矿")
			F点击(x金矿,y金矿)
		elseif x伐木场 ~= -1 then
			sysLog("找到任务x伐木场")
			F点击(x伐木场,y伐木场)
		elseif x魔泉 ~= -1 then
			sysLog("找到任务x魔泉")
			F点击(x魔泉,y魔泉)
		elseif x秘银 ~= -1 then
			sysLog("找到任务x秘银")
			F点击(x秘银,y秘银)
		elseif x血钻 ~= -1 then
			sysLog("找到任务x血钻")
			F点击(x血钻,y血钻)
		elseif x血钻2 ~= -1 then
			sysLog("找到任务x血钻2")
			F点击(x血钻2,y血钻2)
		elseif x紫水晶 ~=-1 then
			sysLog("找到任务x紫水晶")
			F点击(x紫水晶,y紫水晶)
		elseif x古矮人遗迹 ~=-1 then
			sysLog("找到任务x古矮人遗迹")
			F点击(x古矮人遗迹,y古矮人遗迹)
		elseif x废弃教堂 ~=-1 then
			sysLog("找到任务x废弃教堂")
			F点击(x废弃教堂,y废弃教堂)
		elseif x地下迷宫 ~=-1 then
			sysLog("找到任务x地下迷宫")
			F点击(x地下迷宫,y地下迷宫)
		elseif x莫森古国遗迹 ~=-1 then
			sysLog("找到任务x莫森古国遗迹")
			F点击(x莫森古国遗迹,y莫森古国遗迹)
		elseif x闹鬼庄园 ~=-1 then
			sysLog("找到任务x莫森古国遗迹")
			F点击(x闹鬼庄园,y闹鬼庄园)
		elseif x阴暗洞穴 ~=-1 then
			sysLog("找到任务x阴暗洞穴")
			F点击(x阴暗洞穴,y阴暗洞穴)
		elseif x亚拉戈遗迹 ~=-1 then
			sysLog("找到任务x亚拉戈遗迹")
			F点击(x亚拉戈遗迹,y亚拉戈遗迹)
		elseif x地底深渊 ~=-1 then
			sysLog("找到任务x地底深渊")
			F点击(x地底深渊,y地底深渊)
			elseif x金矿2 ~=-1 then
			sysLog("找到任务x地底深渊")
			F点击(x金矿2,y金矿2)
			elseif x紫水晶2 ~=-1 then
			sysLog("找到任务x地底深渊")
			F点击(x紫水晶2,y紫水晶2)
		else
			canSearch=false
		end
	end
	
end


function F刷任务()
	local page =F获取当前页面()
	
	mSleep(600)
	
	if page=="空任务界面" then
		F点击(46,29)
		mSleep(500)
		canSearch =false
	elseif page=="游戏主页" then
		if 检测静止()>50 then --界面没移动
			if canSearch then
				搜寻任务()
			else
				canSearch=true
				F点击(63,665)
			end
		else --界面移动中
			mSleep(2000)
		end
	elseif page=="任务界面" then
		math.randomseed(tostring(os.time()):reverse():sub(1, 6))
		n=math.random(1,4)
		if n==1 then
			F点击(873,166)
		elseif n==2 then
			F点击(876,314)
		elseif n==3 then
			F点击(868,463)
		elseif n==4 then
			F点击(876,608)
		end
	elseif page=="地图界面" then
		x前往,y前往=findMultiColorInRegionFuzzy(地图前往小范围[1],地图前往小范围[2],
			地图前往小范围[3], 地图前往小范围[4], 地图前往小范围[5], 地图前往小范围[6],地图前往小范围[7])
		if x前往~=-1 then
			F点击(x前往,y前往)
		else
			x前往2,y前往2=findMultiColorInRegionFuzzy(地图前往大范围[1],地图前往大范围[2],
				地图前往大范围[3], 地图前往大范围[4], 地图前往大范围[5], 地图前往大范围[6],地图前往大范围[7])
			if x前往2~=-1 then
				F点击(x前往2,y前往2)
			else
				F点击(46,29)
			end
		end
	elseif page=="拉矿选项界面" then
		canSearch=false
		F点击(807,453)
	elseif page=="遗迹选项界面" then
		F点击(807,459)
	elseif page=="任务进攻界面" then
		F点击(815,553)
	elseif page=="战斗选阵容界面" then
		F点击(1181,643)
		mSleep(1500)
		if math.random()>0.5 then
			F点击(1009,335)
		else
			F点击( 1194,333)
		end
		mSleep(2000)
	elseif page=="战斗准备界面" then
		F点击(1097,57)
		mSleep(2000)
	elseif page=="战斗暂停界面" then
		F点击(659,250)
	elseif page=="英雄升级界面" then
		F点击( 875,635)
	elseif page=="战斗结算界面" then
		F点击(846,656)
	elseif page=="英雄结算界面" then
		F点击(651,664)
	elseif page=="奖励结算界面" then
		canSearch=false
		F点击(627,636)
	elseif page=="补体力界面" then
		F点击(775,473)
	elseif page=="补血界面" then
		F点击(781,480)
	elseif page=="战斗中界面" then
		mSleep(10000)
	elseif page=="仓库奖励界面" then
		F点击(656,493)
	else
		F点击(46,29)
		mSleep(500)
	end
	mSleep(1500)
	F刷任务()
end

function main()
	F检查分辨率()
	F检查是否是主页()
	F刷任务()
end

main()

