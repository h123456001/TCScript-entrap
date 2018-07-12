//开始按钮_点击操作
var handleid,handle_herodo,handle_Surrender,init
var herodo状态恢复,Surr状态恢复,herodo状态暂停,Surr状态暂停//
function 开始_点击()
    
    init=threadbegin("Init","")

    handleid=threadbegin("开始刷笑脸","")
    handle_herodo=threadbegin("herodo","") //玩家行为移动扣篮等
    handle_Surrender=threadbegin("Surrender","")//投降
	stopOnce()
    

    if(handle_herodo!=0)
        staticsettext("标签_启动",handle_herodo) 
        
    else
        staticsettext("标签_启动","启动失败") 
    end
    if(handle_Surrender!=0)
        staticsettext("标签_启动1",handle_Surrender) 
    else
        staticsettext("标签_启动1","启动失败") 
    end
    
end



function 开始刷笑脸()
    sleep(1000)
    if(hwnd!=0)
        windowactivate(hwnd)
    end
    
    keng=checkgetstate("复选框0") 
    while(hwnd!=0)
        var aa=checkroom()
        
        if(keng==false)//不坑路人模式
            
            if(roomstate=="未满")
                traceprint("未满")
                //大厅发言 
                var 弹窗确定=overmsgbox()
                sleep(200)
                time1=timenow()
                time_jg=timediff("s",time2,time1) 
                time_jg=mabs(time_jg)
                if(cint(time_jg)>=20)
                    //满足发言时间间隔
                    //messagebox("满足发言时间间隔")
                    var 发言=sendmessage()
                    //记录发言时间time1
                    time2=timenow()
                else
                    //不满足发言时间间隔
                    //messagebox("不满足发言时间间隔")
                    time1=timenow()
                end
                
            elseif(roomstate=="已满")
                traceprint("已满")
                var 弹窗确定=overmsgbox()
                sleep(200)
                time1=timenow()
                time_jg=timediff("s",time2,time1) 
                time_jg=mabs(time_jg)
                if(cint(time_jg)>=20)
                    //满足发言时间间隔
                    //messagebox("满足发言时间间隔")
                    var 发言=sendmessage()
                    //记录发言时间time1
                    time2=timenow()
                else
                    //不满足发言时间间隔
                    //messagebox("不满足发言时间间隔")
                    time1=timenow()
                end
                traceprint("房间中...点击开始游戏")
                sleep(300)
                mousemove(fsx+1024-90,fsy+768-50)
                sleep(100)
                mouseleftclick()
                sleep(2000)
            else
                roomstate=="游戏中"
                traceprint("常规模式游戏中")
                //恢复游戏线程投降线程
                //ressumetherad() 已经再 checkRoom中写入
////********start********
//                herodo状态恢复=threadresume(handle_herodo)
//                sleep(100)
//                Surr状态恢复=threadresume(handle_Surrender)
//                sleep(100)
//                if(herodo状态恢复==true)
//                    staticsettext("标签_恢复","true") 
//                else
//                    staticsettext("标签_恢复1","false") 
//                end
//                if(Surr状态恢复==true)
//                    staticsettext("标签_恢复","true") 
//                else
//                    staticsettext("标签_恢复1","false") 
//                end
////********start********                
            end  
        else//坑路人模式******************************************************
            
            
            if(roomstate=="未满")
                //traceprint("未满1")
                var 弹窗确定=overmsgbox()
                //messagebox("进入已经满模式即将开始游戏")
                sleep(300)
                mousemove(fsx+1024-90,fsy+768-75)
                sleep(100)
                mouseleftclick()
                sleep(2000)
            elseif(roomstate=="已满")
                //traceprint("已满1")
                var 弹窗确定=overmsgbox()
                //messagebox("进入已经满模式即将开始游戏")
                sleep(300)
                mousemove(fsx+1024-90,fsy+768-75)
                sleep(100)
                mouseleftclick()
                sleep(3000)
            else
                roomstate=="游戏中"
                //traceprint("...游戏中...坑1")
                //恢复游戏线程投降线程
                //ressumetherad() 已经再checkroom中写入
////********start********                
//                herodo状态恢复=threadresume(handle_herodo)
//                sleep(100)
//                Surr状态恢复=threadresume(handle_Surrender)
//                sleep(100)
//                if(herodo状态恢复==true)
//                    herodo状态恢复="真"
//                end
////********end********
                //messagebox(herodo状态恢复)
                //handleid1=threadbegin("herodo","")
                //handleid2=threadbegin("Surrender","")//投降
            end
        end
        //messagebox(herodo状态)
        //messagebox(Surr状态)
    end
end
//退出按钮_点击操作
function 退出_点击()
    
    threadclose(handle_herodo)
    threadclose(handle_Surrender)
    threadclose(handleid)
    sleep(50)
    exit()
end





