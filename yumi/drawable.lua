import "socket"
function FPS(num)
  $curTime=socket.gettime()
  if not fps_tab
    fps_tab={[num]={
        fps=0,
        lastTime=curTime,
        frameCount=0
      }}
  end
  if not fps_tab[num]
    fps_tab[num]={
      fps=0,
      lastTime=curTime,
      frameCount=0
    }
  end
  $obj=fps_tab[num]
  obj.frameCount=obj.frameCount+1
  if (curTime - obj.lastTime >= 1)
    obj.fps = obj.frameCount;
    obj.frameCount = 0;
    obj.lastTime = curTime;
  end
  return obj.fps,curTime*1000
end

function LimoDrawable(callback)
  if not callback.data
    callback.data={}
  end
  if callback.硬件加速==false
    callback.view.setLayerType(View.LAYER_TYPE_SOFTWARE,nil)
  end
  $m=string.format("%p",callback)
  $Fps=lambda:FPS(m)
  local draw
  if callback.调试模式
    $fun=callback.onDraw
    local is,err,err0
    callback.onDraw=function(...)
      is,err0=pcall(fun,...)
      if not is
        err=err0
        local 文件,行数,异常=err:match"/%s-([^/]-%.lua)%s-:%s-(%d-)%s-:%s-(.-)%s-$"
        if 文件
          if 异常:find"attempt to perform arithmetic on a nil value "
            local 类型,变量名=异常:match"attempt to perform arithmetic on a nil value %((.-) '(.-)'%)"
            if 类型=="upvalue"
              异常="名为 \""..变量名.."\" 的数据为空\n\n检查您的cpp数据格式是否与绘制程序匹配，如数据匹配，请前往输出文件检查数据是否异常，或者实际输出数据的数量是否与绘制程序数据格式的数量相同。"
             else
              异常="名为 \""..变量名.."\" 的全局变量为空\n\n对比模板，检查您是否误删了某些代码或变量。"
            end
           elseif 异常:find"attempt to compare %w- with %w-"
            local a,b=异常:match"attempt%s-to%s-compare%s-(%w-)%s-with%s-(%w-)$"
            异常="该数值为"..b.."类型，请将它转换为"..a.."类型"
           elseif 异常:find"attempt to call a nil value"
            异常="名为 \""..异常:match("attempt to call a nil value %(.- '(.-)'%)").."\" 的函数不存在\n\n请检查您是否申明了该函数。"
          end
          err=文件.." 第"..行数.."行:\n    "..异常
         elseif err:find"%.draw%w-%(" and err:find"java%.lang%.NullPointerException"
          err="canvas调用异常:\n    "..err:match"%.(draw%w-)%(".."方法的参数不允许空值\n\n检查您的cpp数据格式是否与绘制程序匹配，如数据匹配，请前往输出文件检查数据是否异常，或者实际输出数据的数量是否与绘制程序数据格式的数量相同。"
        end

        send("程序异常，正在分析错误原因","I")
        GlobalDialog(this)
        .setTitle("程序异常")
        .setMessage(err)
        .setCancelable(false)
        .setButton1("我知道了")
        .setButton3("查看数据",function()
          GlobalDialog(this)
          .setTitle("查看数据")
          .setMessage(dump(callback.data))
          .setCancelable(false)
          .setButton("确定")
          .show()
        end)
        .show()
        print(err0)
        send(err0,"E")
        error()
      end
    end
  end
  if callback.自动刷新~=false
    draw=(lambda a,b,c:callback.onDraw(callback.view,a,b,c,Fps,callback.data),c.invalidateSelf())
   else
    draw=lambda a,b,c:callback.onDraw(callback.view,a,b,c,Fps,callback.data)
  end
  $drawble=LuaDrawable(draw)
  callback.view.post(lambda:callback.view.setBackground(drawble))
  return setmetatable({data=callback.data,刷新=lambda:drawble.invalidateSelf()},{__call=(lambda:drawble),__tostring=(lambda:"draw: 0x"..string.format("%p",callback))})
end