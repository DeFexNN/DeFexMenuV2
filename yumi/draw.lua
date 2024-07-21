import "yumi/tool"


local x,y,w,h,m,hp,--x y 人物宽度 人物高度 敌人距离 敌人血量
ai,zy,dx,name--人机判断 人物动作 敌人队营 倒地血量 敌人名字



local hp_list={}
local num_list={}

local _fps,idx,id1,id2,a,b,_hp
mDraw=LimoDrawable{--创建LuaDrawable对象
  view=window,--设置图层控件
  data=Split_Table,
  调试模式=false,--分析错误日志并给出部分异常的解决方案 (发布前请关闭，否则将会影响帧率)
  onDraw=function(view,画布,画笔,self,fps,data)--控件对象 画布 画笔 LuaDrawable对象 获取FPS 内部数据表
    if 绘制开关--控制是否绘制图形
      _fps,_time=fps()
      if _fps>=50
        setColor("FPS画笔",0xff00ff00)
       elseif _fps<30
        setColor("FPS画笔",0xffff0000)
       else
        setColor("FPS画笔",0xFFFF7F00)
      end

      画布.drawText(tostring(_fps),210,100,FPS画笔)--绘制FPS--  100 126
      画布.drawText("          FPS  : ",100,100,FPS画笔)--绘制FPS

      画布.drawText("               ",860,65,FPS画笔2)--绘制FPS


      id1,id2=0,0--申明用于计算敌人数量的局部变量
      瞄准=0--同级当前瞄准敌人的数量，用于显示名字
      for str io.lines "/sdcard/a.log"--读取b.log的每一行
        string.split(str,",")--将分割后的字符串存入data



        local x,y,w,h,m,hp,--x y 人物宽度 人物高度 敌人距离 敌人血量
        ai,zy,dx,name=--人机判断 敌人队营 倒地血量 敌人名字
        tonumber(data[1]),tonumber(data[2]),
        tonumber(data[3]),tonumber(data[4]),
        tointeger(data[5]),tonumber(data[6]),
        tonumber(data[7]),tonumber(data[8]),
        tonumber(data[9]),data[10]

        if x and y and w and h and m--因数据不是数字，tonumber返回nil
          and hp and ai and zy
          local y_w,y__w,w_2=y-w,y+w,w/2--缓存需要重复运算的数据
          if ai==0 or zy==996--人机判断，适配了地铁模式
            id2=id2+1--人机+1
           else--真人
            id1=id1+1--真人+1
          end

          if w>0--过滤掉背后的敌人
            x=x+(w_2)--[[身位偏移
            x坐标是以人物左侧为基准,而我以中间为基准计算的
            所以需要在这里将坐标矫正，向右挪移半个身位]]
            if zy==996 and hp>=500--适配地铁模式
              setColor("背敌画笔1",0xafffffff)--背敌填充颜色
              setColor("背敌画笔2",0xaf0000ff)--背敌边框颜色
              setColor("背敌文字",0xff0000ff)--背敌文字颜色
              if y>height_2-w-20 and y<height_2+w+20 and x>width_2-w_2-20 and x<width_2+w_2+20--判断是否被瞄准
                setColor("方框画笔",0xaf0000ff)
               else
                setColor("方框画笔",0xafffffff)
              end
              setColor("人机画笔",0xFF00FFFF)--方框下面的文字颜色
              画布.drawText("BOSS",x,y__w+25,人机画笔)--绘制方框下面的文字
             elseif ai==0 or zy==996--人机判断，适配了地铁模式
              setColor("背敌画笔1",0xafffffff)
              setColor("背敌画笔2",0xafff0000)
              setColor("背敌文字",0xffff0000)
              setColor("射线画笔",0xFFFFFFFF)
              setColor("名字画笔2",0xFFFFFFFF)
              setColor("方框画笔4",0xFFFFFFFF)
              if y>height_2-w-20 and y<height_2+w+20 and x>width_2-w_2-20 and x<width_2+w_2+20--判断是否被瞄准
                setColor("方框画笔",0xFF000000)
               else
                setColor("方框画笔",0xafffffff)
              end
              setColor("人机画笔",0xffffffff)
              画布.drawText("人机",x,y__w+25,人机画笔)
             else--真人
              setColor("背敌画笔1",0xafff0000)
              setColor("背敌画笔2",0xAFFFFFFF)
              setColor("背敌文字",0xffffffff)
              setColor("射线画笔",0xFFFBFFFF)
              setColor("名字画笔2",0xFFFF3500)
              setColor("方框画笔4",0xFF00FF00)
              if y>height_2-w-20 and y<height_2+w+20 and x>width_2-w_2-20 and x<width_2+w_2+20--判断是否被瞄准
                瞄准=瞄准+1
                setColor("方框画笔",0xFFFFFFFF)
               else
                setColor("方框画笔",0xFFFFFFFF)
              end
              setColor("人机画笔",0xFFFFFF00)
              画布.drawText("敌人",x,y__w+25,人机画笔)
            end
            if x+(w_2)<0--左侧背敌
              画布.drawRect(0,y-25,90,y+25,背敌画笔1)--背敌填充
              画布.drawRect(-1,y-25-1,91,y+25+1,背敌画笔2)--背敌边框
              画布.drawText(m.."←",45,y+8,背敌文字)--背敌文字
             elseif x-(w_2)>width--右侧背敌
              画布.drawRect(width,y-25,width-90,y+25,背敌画笔1)
              画布.drawRect(width+1,y-25-1,width-91,y+25+1,背敌画笔2)
              画布.drawText(m.."→",width-45,y+8,背敌文字)
             elseif y__w<0--上方背敌
              画布.drawRect(x-45,0,x+45,50,背敌画笔1)
              画布.drawRect(x-45-1,-1,x+45+1,51,背敌画笔2)
              画布.drawText(m.."↑",x,35,背敌文字)
             else--敌人方框



              画布.drawText("▼",x,y_w-6,名字画笔2)

              --9
              --[[画布.drawCircle(头部X,头部Y,w/9,方框画笔4)
              画布.drawLine(胸部X, 胸部Y, 盆骨X, 盆骨Y, 方框画笔4)
              画布.drawLine(胸部X, 胸部Y, 左肩X, 左肩Y, 方框画笔4)
              画布.drawLine(胸部X, 胸部Y, 右肩X, 右肩Y, 方框画笔4)
              画布.drawLine(左肩X, 左肩Y, 左手肘X, 左手肘Y, 方框画笔4)
              画布.drawLine(右肩X, 右肩Y, 右手肘X, 右手肘Y, 方框画笔4)
              画布.drawLine(左手肘X, 左手肘Y, 左手腕X, 左手腕Y, 方框画笔4)
              画布.drawLine(右手肘X, 右手肘Y, 右手腕X, 右手腕Y, 方框画笔4)
              画布.drawLine(盆骨X, 盆骨Y, 左大腿X, 左大腿Y, 方框画笔4)
              画布.drawLine(盆骨X, 盆骨Y, 右大腿X, 右大腿Y, 方框画笔4)
              画布.drawLine(左大腿X, 左大腿Y, 左膝盖X, 左膝盖Y, 方框画笔4)
              画布.drawLine(右大腿X, 右大腿Y, 右膝盖X, 右膝盖Y, 方框画笔4)
              画布.drawLine(左膝盖X, 左膝盖Y, 左脚腕X, 左脚腕Y, 方框画笔4)
              画布.drawLine(右膝盖X, 右膝盖Y, 右脚腕X, 右脚腕Y, 方框画笔4)
]]
              画布.drawLine(x-(w/2),y-(h/2),x-(w/4),y-(h/2),方框画笔)--左上横
              画布.drawLine(x+(w/2),y-(h/2),x+(w/4),y-(h/2),方框画笔)--右上横
              画布.drawLine(x-(w/2),y+(h/2),x-(w/4),y+(h/2),方框画笔)--左下横
              画布.drawLine(x+(w/2),y+(h/2),x+(w/4),y+(h/2),方框画笔)--右下横
              画布.drawLine(x-(w/2),y-(h/2),x-(w/2),y-(h/4),方框画笔)--左上竖
              画布.drawLine(x+(w/2),y-(h/2),x+(w/2),y-(h/4),方框画笔)--右上竖
              画布.drawLine(x-(w/2),y+(h/2),x-(w/2),y+(h/4),方框画笔)--左下竖
              画布.drawLine(x+(w/2),y+(h/2),x+(w/2),y+(h/4),方框画笔)--右下竖

              --画布.drawRect(盆骨X-35,头部Y-10,盆骨X+35,左脚腕Y,方框画笔)
              --原方框. [[ 画布.drawRect(x-(w_2),y_w,x+(w_2),y__w,方框画笔)--绘制方框

              --画布.drawLine(width_2,100+2,x,y_w-64,射线画笔)--绘制射线
              --1075+2
              画布.drawLine(width_2,100+2,x,y_w-64,射线画笔)--绘制射线




              --画布.drawRect(x-120,y_w-65,x+120,y_w-20,路径画笔)--设置方框上方黑色背景的坐标
              -- 画布.drawRect(x-119,y_w-64,x+121,y_w-21,路径方框)--绘制外圈白框
              --画布.drawText(zy.."队",x-110,y_w-50,阵营画笔)--绘制队营文字
              画布.drawText(m.."m",x+110,y_w-50,距离画笔)--绘制距离文字
              画布.drawText(name,x,y_w-80,名字画笔)--绘制人物名字
              画布.drawLine(x-120,y_w-30,x+120,y_w-30,血条画笔1)--绘制分割血条与信息的白线

              _hp=hp
              if hp>100--适配地铁模式
                setColor("血条画笔2",0xff0000ff)--蓝色血条
                画布.drawText(tointeger(hp).."HP",x+130,y_w-41,血条画笔3)--文字血量
                hp=100
               elseif hp<=0--敌人倒地
                setColor("血条画笔2",0xffff0000)--设置红色血条
                hp=dx--设置敌人的倒地血量
               else--健康血量
                setColor("血条画笔2",0xff00ef00)--设置绿色血条
              end
              画布.drawLine(x-116,y_w-25,x-116+(2.32*hp),y_w-25,血条画笔2)--绘制血条
              --      x-116   y_w-25                  y_w-25
              if 击伤开关--击伤特效
                if not hp_list[name]
                  hp_list[name]={_hp,_time}
                end
                local t=hp_list[name]
                if t[1]>_hp
                  t[3]="-"..t[1]-_hp
                  t[4]=0xFFff0000
                  t[5]=t[1]
                  t[6]=x-116+(2.32*hp)
                  t[7]=y_w-25
                  t[8]=x
                  t[1]=_hp
                  t[2]=_time
                  if t[9]
                    t[5]=t[10]-t[9]
                    t[9],t[10]=nil
                  end
                  if t[5]>100
                    t[11]=100
                   elseif t[5]<0
                    t[11]=0
                   else
                    t[11]=t[5]
                  end
                  local _={{t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8]}}
                  for i=1,#num_list
                    _[i+1]=num_list[i]
                  end
                  num_list=_
                 elseif t[1]<_hp
                  t[3]="+".._hp-t[1]
                  t[4]=0xff00ef00
                  t[5]=t[1]
                  t[6]=x-116+(2.32*hp)
                  t[7]=y_w-25
                  t[8]=x
                  t[1]=_hp
                  t[2]=_time
                  if t[9]
                    t[5]=t[10]-t[9]
                    t[9],t[10]=nil
                  end
                  if t[5]>100
                    t[11]=100
                   elseif t[5]<0
                    t[11]=0
                   else
                    t[11]=t[5]
                  end
                  local _={{t[1],t[2],t[3],t[4],t[5],t[6],t[7],t[8]}}
                  for i=1,#num_list
                    _[i+1]=num_list[i]
                  end
                  num_list=_
                end
                if t[3] and _time-t[2]<=1000
                  if t[5]>t[1]
                    画布.drawLine(x-116+(2.32*hp),y_w-25,x-116+(2.32*(t[11]-((t[11]-hp)/1000)*(_time-t[2]))),y_w-25,伤害画笔1)
                    t[9]=((t[11]-t[1])/1000)*(_time-t[2])
                    t[10]=t[11]
                  end
                 else
                  t[9],t[10]=nil
                end
              end


            end
           else--后方背敌
            if zy==996 and hp>=500--适配地铁模式
              setColor("背敌画笔1",0xafffffff)--背敌填充颜色
              setColor("背敌画笔2",0xaf0000ff)--背敌边框颜色
              setColor("背敌文字",0xff0000ff)--背敌文字颜色
             elseif ai==0 or zy==996--人机判断，适配了地铁模式
              setColor("背敌画笔1",0xafffffff)
              setColor("背敌画笔2",0xafff0000)
              setColor("背敌文字",0xffff0000)
             else--真人
              setColor("背敌画笔1",0xafff0000)
              setColor("背敌画笔2",0xafffffff)
              setColor("背敌文字",0xffffffff)
            end
            画布.drawRect(x-45,height,x+45,height-50,背敌画笔1)
            画布.drawRect(x-45-1,height-1,x+45+1,height-51,背敌画笔2)
            画布.drawText(m.."↓",x,height-20,背敌文字)
          end
        end
        table.clear(data)--清空data
      end

      if 击伤开关--击伤特效
        for i=#num_list,1,-1
          local _=num_list
          local t=num_list[i]
          if t[3] and _time-t[2]<=1000
            setColor("伤害画笔1",t[4])
            伤害画笔1.setAlpha((255/1000)*(1000-(_time-t[2])))
            伤害画笔2.setAlpha((255/1000)*(1000-(_time-t[2])))
            画布.drawText(t[3],t[6],t[7]-35-((100/1000)*(_time-t[2])),伤害画笔1)
            画布.drawText(t[3],t[6],t[7]-35-((100/1000)*(_time-t[2])),伤害画笔2)
           else
            _[i]=nil
          end
        end
      end

      a=id1==0
      b=id2==0
      if a
        setColor("人数画笔1",0xfF07BE2E)

        画布.drawRect((width_2)-120,55,(width_2)+120,100,人数画笔1)--绘制人数的背景
        画布.drawText("安全",width_2,87.5,人数画笔2)
       else
        if a
          setColor("人数画笔1",0xFFFF0000)
          画布.drawRect((width_2)-120,55,(width_2)+120,100,人数画笔1)--绘制人数的背景
          画布.drawText("玩家: 0",width_2-60,87.5,人数画笔2)
         else
          setColor("人数画笔1",0xFFFF0000)--0xfFF36500
          画布.drawRect((width_2)-120,55,(width_2)+120,100,人数画笔1)--绘制人数的背景
          画布.drawText("玩家: "..id1,width_2,87.5,人数画笔2)
        end
        --[[if b
          setColor("人数画笔1",0xfF07BE2E)
          画布.drawRect((width_2)+115,55,width_2,100,人数画笔1)--绘制人数的背景
          画布.drawText("人机: 0",width_2+60,87.5,人数画笔2)
         else
          setColor("人数画笔1",0xfF07BE2E)
          画布.drawRect((width_2)+115,55,width_2,100,人数画笔1)--绘制人数的背景
          画布.drawText("人机: "..id2,width_2+60,87.5,人数画笔2)
        end]]
      end
 
    end
  end
}

