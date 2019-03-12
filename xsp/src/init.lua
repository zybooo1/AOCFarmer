init("0", 1); --以当前应用 Home 键在右边初始化
w,h=getScreenSize()--获取当前分辨率
sysLog("分辨率："..w.."*"..h)
B当前页面='' --全局变量当前页面
B记录时间=0  --超时判定
B超时时间=30000 --超时时间判定为30秒

flag = appIsRunning("com.lilithgame.sgame.gp.oss.test"); --检测QQ是否在运行
if flag == 0 then --如果没有运行
	runApp("com.lilithgame.sgame.gp.oss.test") --运行QQ
end