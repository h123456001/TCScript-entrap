var gametitle="Freestyle!"
var hwnd,messagehwnd,pid,isturestop_hero,isturestop_Surr
var fsx,fsy,gx,gy,isdonext
var message
var roomstate
var xxx,yyy//移动间隔xxx毫秒移动一次
var keng,time1,time2,time_jg,timegame,timewait,time_gw
var handle_herodo_thread,handle_Surrender_thread,status_herodo,status_surr,handle_herodo_resume,handle_surr_resume
var handle_herodo_stop,handle_Surrender_stop//重要只能暂停一次
var allowstop = true
function Init()//初始化函数  
    handle_herodo_thread=false
    handle_Surrender_thread=false
    time1="2015/4/19 02:54:00"
    time2="2015/4/19 02:54:30"
    timegame="2015/4/19 02:54:30"
    timewait="2015/4/19 02:54:00"
    message=editgettext("编辑框1")
    xxx=cint(editgettext("编辑框2"))
    yyy=cint(editgettext("编辑框3"))
    setdict("rc:tcsoft.txt",0)
    //var second=ocrarea()
    //var third=sendmessage()
    //var ret = dllcall("user32.dll","long","GetWindow","long",hwnd,"long",3)
    //messagebox(ret)
    var first=wndinfo()
end




function wndinfo()//若举报信息获得失败则激活手动获取，反之自动获取窗口坐标
    var ifok
    hwnd=windowfind(gametitle)//查找街头篮球Freestyle句柄
    if(hwnd!=0)//获取成功     提示 并且对fsx,fsy,gx,gy坐标进行填充
        //messagebox("街头篮球窗口已经找到!") 
        //ifok=windowgetpos(hwnd,fsx,fsy)
        messagehwnd=hwnd-2293776
        ifok=windowgetclientrect(hwnd,fsx,fsy,gx,gy)//获取游戏窗体坐标和客户区坐标  （已经去除边框）
        pid=information(hwnd,5)
        var tmptext=editsettext("编辑框0",pid)
        return hwnd 
    else		//获取失败	激活手动输入pid窗口        
        ifok=controlenable("编辑框0",true)
        ifok=controlenable("按钮0",true)
    end
end

function 按钮0_点击()
    //这里添加你要执行的代码
    pid=editgettext("编辑框0")
    if(pid==null||pid=="")
        messagebox("请输入进程pid")
    else
        hwnd=getwndhwnd(pid,1)
        if(hwnd=="")
            messagebox("faild pid")
        else
            return true
        end
    end
    
    
end

//文字识别等待房间 全部  找不到则开始游戏间隔自定义
function checkroom()
    var a=overmsgbox() 
    var gameing,ggx,ggy
    var ret = ocr(fsx+230,fsy+443, fsx+230+250,fsy+443+25,"f3f3f3-404040",1.0)
    if(ret=="全部全部"||ret=="全部")//空槽职业类型All
        //发现房间未满继续等待
        roomstate="未满" 
        timewait=timenow()   
        //房间未满 暂停 handle_herodo 线程----暂停前检测是否已经暂停
        traceprint("未满")
        stopOnce()
        //****start******        
        //        if(handle_herodo!=0)
        //            traceprint("房间未满...英雄线程☑...,暂停线程")
        //            
        //            //herodo状态暂停=threadsuspend(handle_herodo)
        //        else
        //            traceprint("房间未满,英雄线程...状态☑,暂停线程")
        //            //英雄行为线程运行中,则暂停线程
        //            herodo状态暂停=threadsuspend(handle_herodo)
        //            
        //        end
        //        if(handle_Surrender!=0)//投降线程
        //            traceprint("房间未满,投降线程状态✖,请无视")
        //            //Surr状态暂停=threadsuspend(handle_Surrender)
        //        else
        //            traceprint("房间未满,投降线程状态☑,请暂停线程")
        //            Surr状态暂停=threadsuspend(handle_Surrender)
        //        end
        //        
        //        sleep(200)
        //        if(herodo状态暂停==true)
        //            
        //            staticsettext("标签_暂停","true") 
        //        else
        //            staticsettext("标签_暂停","false") 
        //        end
        //        if(Surr状态暂停==true)
        //            staticsettext("标签_暂停1","true") 
        //        else
        //            staticsettext("标签_暂停1","false") 
        //        end
        ////****end******        
        
        //messagebox("未满")
    else
        //房间已经满或者游戏中
        
        gameing=findpic(fsx+1024-140,fsy+768-135,fsx+1024-140+35,fsy+768-135+35,"rc:gameing.bmp","000000",1,0,ggx,ggy)
        if(ggx>0&&ggy>0)//游戏中
            roomstate="游戏中"
            traceprint(" 发现游戏中特征|～|")
            
            timegame=timenow()
            time_gw=cint(mabs(timediff("s",timewait,timegame)))
            if(time_gw>3600)                
                var rett=filelog(timegame,"D:/smill_guy_log.txt")                 
            end
            //如果检测当前状态为比赛中（游戏中）则先检查游戏线程是否已恢复
            traceprint("...游戏中...")
            ressumetherad()
            ////********start********////
            //            status_herodo=threadgetstatus(handle_herodo) 
            //            status_surr=threadgetstatus(handle_Surrender) 
            //            
            //            if(status_herodo==true)//线程存在则恢复线程handle_herodo
            //                traceprint("游戏中...英雄线程存在...恢复线程")
            //                handle_herodo_resume=threadresume(handle_herodo)
            //            end
            //            
            //            if(status_surr==true)//线程存在则恢复线程handle_Surrender
            //                traceprint("游戏中...投降线程存在...恢复线程")
            //                handle_surr_resume=threadresume(handle_Surrender) 
            //            end
            //            if(handle_herodo_resume==true)
            //                traceprint("游戏中...英雄线程...恢复成功☑")
            //                staticsettext("标签_恢复","true")
            //            else
            //                traceprint("游戏中...英雄线程...恢复失败✖")
            //                staticsettext("标签_恢复","false")
            //            end
            //            if(handle_surr_resume==true)
            //                traceprint("游戏中...投降线程...恢复成功☑")
            //                staticsettext("标签_恢复1","true")
            //            else
            //                traceprint("游戏中...投降线程...恢复失败✖")
            //                staticsettext("标签_恢复1","false")
            //            end
            //            
            ////********end********
            
        else
            roomstate="已满"
            traceprint("...已满..未识别界面...")
            timewait=timenow()
            stopOnce()
            //handle_herodo_stop=threadsuspend(handle_herodo)
            //handle_Surrender_stop=threadsuspend(handle_Surrender)
            ////********start********            
            //            if(handle_herodo_stop==false)         
            //                traceprint("已满|未识别.界面..暂停...英雄线程失败✖尝试再次暂停...")
            //                handle_herodo_stop=threadsuspend(handle_herodo)
            //                sleep(200)
            //            else
            //                traceprint("已满|未识别.界面..暂停...英雄线程成功☑")
            //            end
            //            if(handle_Surrender_stop==false)
            //                traceprint("已满|未识别.界面..暂停...投降线程失败✖尝试再次暂停...")
            //                handle_Surrender_stop=threadsuspend(handle_Surrender)
            //                sleep(200)	
            //            else
            //                traceprint("已满|未识别.界面..暂停...英雄线程成功☑")
            //            end
            //            
            //            //UI界面提示
            //            if(handle_herodo_stop==true)
            //                //线程暂停成功更新UI
            //                staticsettext("标签_暂停","true") 
            //            else
            //                staticsettext("标签_暂停","false") 
            //            end
            //            if(handle_Surrender_stop==true)
            //                staticsettext("标签_暂停1","true") 
            //            else
            //                staticsettext("标签_暂停1","false") 
            //            end
            ////********end********
        end   
    end
    //messagebox(ret)
    return roomstate
end

//winapi无法发送英文所以采用读取剪贴板的形式,组合键模式
function sendmessage()
    //获得子窗口句柄
    //var ret = dllcall("user32.dll","long","GetWindow","long",hwnd,"long",5)
    messagehwnd=hwnd-2293776
    //messagehwnd=ret
    var isoka=setclipboard(message)
    //激活聊天框 然后发送
    
    windowactivate(messagehwnd)
    mousemove(fsx+200,fsy+768-170)
    sleep(100)
    mouseleftdclick()
    sleep(100)
    mousemove(fsx+100,fsy+768-140)
    sleep(100)
    mouseleftdclick()
    sleep(500)
    keydown(162)//Ctrl
    keydown(86)//v   
    
    sleep(500)
    
    keyup(162)
    keyup(86)
    sleep(100)
    var rett=rnd(48,90)
    keypress(rett)
    keypress(13) 
    keypress(13)
    sleep(1000)
    return true
    
    
end

function overmsgbox()
    sleep(200) 
    var QD,qdx,qdy
    QD=findpic(fsx+520,fsy+440,fsx+260+520,fsy+130+440,"rc:确定.bmp|rc:确定1.bmp|rc:确定2.bmp|rc:确定3.bmp","101010",1,0,qdx,qdy)
    if(qdx>0&&qdy>0)
        mousemove(qdx+10,qdy+10)
        sleep(200)
        mouseleftdown()
        sleep(200)
        mouseleftup()
    else
        //messagebox("未发现确定按钮")
    end
end

function Surrender()//投降
    sleep(200)
    //这里添加你要执行的代码
    //gameing=ts.FindPic(1024-140,768-140,1024-100,768-100,"gameing.bmp|gameing1.bmp","101010",1,0,gx,gy)
    while(roomstate=="游戏中")
        
        
        var TX,qdx,qdy
        traceprint("开始查找投降按钮")
        TX=findpic(fsx+15,fsy+768-80,fsx+15+40,fsy+768-80+40,"rc:tt.bmp","101010",1,0,qdx,qdy)
        if(qdx>0&&qdy>0)
            traceprint("发现投降按钮☑")
            mousemove(qdx+25,qdy+8)
            sleep(200)
            mouseleftdown()
            sleep(200)
            mouseleftup()
            mousemove(qdx+200,qdy+5)
        else
            traceprint("无投降按钮✖")
        end
        sleep(2000)
    end
end


function  checkscore()
    var 主队分数=ocr(fsx+406,fsy+10,fsx+406+49,fsy+10+25,"ffc700-404040|f3f1f3-404040",0.9)
    var 客队分数=ocr(fsx+566,fsy+10,fsx+566+49,fsy+10+49,"ffc700-404040|f3f1f3-404040",0.9)
    var 分差=mabs(cint(主队分数)-cint(客队分数))
    if(分差<=10)
        return 1
    else
        
        return 0
    end
end

function herodo()
    //104↑   98↓   100←   102→     65 A    70 F    83 S
    sleep(200)
    while(roomstate=="游戏中")
        isdonext=checkscore()
        if(isdonext==1)//;rrnd!=98||rrnd!=100||rrnd!=102||rrnd!=104; rrnd++        
            //移动得分 ↑2000  按下A 500    ←4 6→ 弹起 A   F    S
            keydown(100)//← 0.5秒
            sleep(yyy)
            keyup(100)
            keydown(87)			//W
            sleep(50)
            keydown(104)		//↑
            
            sleep(xxx) 			//读取  编辑框2 xxx
            keyup(104)  		//秒
            keyup(87)
            
            //A+随机上下左右	
            sleep(150)
            keypress(65)  //A
            sleep(300)
            keypress(70)  //F
            sleep(100)
            keypress(70)
            sleep(200)
            keypress(83)  //s
        else////104↑   98↓   100←   102→      65 A      70 F      83 S
            //移动777  ↙4 和 2同时按下 2000  F    S
            keydown(100)
            sleep(500)        
            keydown(98)
            sleep(3000)
            keyup(100)
            keyup(98)
            keypress(68)
            sleep(200)
            keypress(70)
            sleep(200)
            keypress(83)   
        end
        sleep(500)
        
    end
end

function stopOnce()
    
    if(allowstop)
        handle_herodo_stop=threadsuspend(handle_herodo)
        handle_Surrender_stop=threadsuspend(handle_Surrender)
        allowstop = false
        traceprint("暂停..英雄线程&&投降线程")
        //else
        //traceprint("英雄线程&&投降线程已暂停...无需再次暂停")
    end
    
end
function ressumetherad()

    //未暂停恢复:未暂停则allowstop 值为true
    if(!allowstop)
//        threadresume(handle_herodo)
//        threadresume(handle_Surrender)
//        allowstop = true
//        traceprint("英雄线程&&投降线程已恢复...")
           
    //已经暂停恢复:已暂停则allowstop 值为false
		threadresume(handle_herodo)
        threadresume(handle_Surrender)
        allowstop = true
        traceprint("英雄线程&&投降线程已恢复...")
    end
    
end