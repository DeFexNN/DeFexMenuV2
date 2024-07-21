import "yumi/drawable"
import "android.provider.Settings"
import "android.util.DisplayMetrics"
import "android.content.Context"
import "android.graphics.PixelFormat"
import "android.graphics.Paint"
import "android.graphics.Paint$Cap"
import "android.animation.ArgbEvaluator"
import "android.graphics.*"

function 初始化(l,v,dia)
  local a,t,w
  if not dia
    a,t,w=l.flags,l.title,this.getSystemService(Context.WINDOW_SERVICE)
   else
    w=this.getSystemService(Context.WINDOW_SERVICE)
  end
  return {
    隐藏=function()
      if v
        w.removeView(v)
      end
      if not dia
        l.flags=a|WindowManager.LayoutParams().FLAG_DITHER | 1048576 | 262696 | 131072 | 4136
       else
        l.addFlags(WindowManager.LayoutParams().FLAG_DITHER | 1048576 | 262696 | 131072 | 4136)
        l.setDimAmount(0)
      end
      if RomUtil.isMiui()
        l.title="com.miui.screenrecorder"
       elseif RomUtil.isEmui()
        l.title="ScreenRecoderTimer"
       elseif RomUtil.isVivo()
        l.title="screen_record_menu"
       elseif RomUtil.isOppo()
        l.title="com.coloros.screenrecorder.FloatView"
       elseif RomUtil.isSmartisan()
        l.title=""
       elseif RomUtil.isFlyme()
        pcall(function()
          l.title="SysScreenRecorder"
          $MeizuParamsClass = Class.forName("android.view.MeizuLayoutParams");
          $flagField = MeizuParamsClass.getDeclaredField("flags");
          flagField.setAccessible(true);
          $MeizuParams = MeizuParamsClass.newInstance();
          flagField.setInt(MeizuParams, WindowManager.LayoutParams().FLAG_DITHER | 1048576 | 262696 | 131072 | 4136);
          $mzParamsField = l.getClass().getField("meizuParams");
          mzParamsField.set(l, MeizuParams);
        end)
      end
      if v
        w.addView(v,l)
      end
    end,
    显示=function()
      if v
        w.removeView(v)
      end
      l.flags=a
      l.title=t
      if v
        w.addView(v,l)
      end
    end
  }
end
dm = DisplayMetrics();
activity.getWindowManager().getDefaultDisplay().getRealMetrics(dm);
function 屏幕高()
  local a = dm.widthPixels;
  local b = dm.heightPixels;
  if tonumber(a)>tonumber(b) then
    b=a
   else
    b=b
  end
  return tonumber(b)
end
function 屏幕宽()
  local a = dm.widthPixels;
  local b = dm.heightPixels;
  if tonumber(a)>tonumber(b) then
    a=b
   else
    a=a
  end
  return tonumber(a)
end


画布管理 = activity.getSystemService(Context.WINDOW_SERVICE)
wmManagers=画布管理
画布容器 = WindowManager.LayoutParams()
wmParam=画布容器
if tonumber(Build.VERSION.SDK) >= 26 then
  wmParam.type = WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
 else
  wmParam.type = WindowManager.LayoutParams.TYPE_SYSTEM_ALERT
end

wmParam.format = PixelFormat.RGBA_8888

wmParam.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
| WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE
| WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL
--| WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED--硬件加速
| WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN
| WindowManager.LayoutParams.FLAG_FULLSCREEN
| WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS

wmParam.gravity = Gravity.LEFT | Gravity.TOP
wmParam.width = 屏幕高()
wmParam.height = -1
window=View(this)
wmManagers.addView(window,wmParam)
画布伪装=初始化(wmParam,window)
方框画笔=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setStyle(Paint.Style.STROKE)
.setStrokeWidth(3)
--.setShadowLayer(12,0,0,0xff00FFFF)


人数画笔1=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)


人数画笔2=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setColor(0xffffffff)
.setTextAlign(Paint.Align.CENTER)
.setTextSize(30)
.setFakeBoldText(true)
.setColor(0xffffffff)






射线画笔=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setStrokeWidth(3)
.setColor(0xbfffffff)


背敌画笔1=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)


背敌画笔2=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setStyle(Paint.Style.STROKE)
.setStrokeWidth(2)


背敌文字=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setTextSize(30)
.setFakeBoldText(true)
.setTextAlign(Paint.Align.CENTER)



路径画笔=Paint()
.setAntiAlias(true)
.setColor(0xaf303030)


路径方框=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setStyle(Paint.Style.STROKE)
.setStrokeWidth(2)
.setColor(0xffffffff)

方框画笔4=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setStyle(Paint.Style.STROKE)
.setStrokeWidth(2)
--.setColor(0xffffffff)





距离画笔=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setTextSize(30)
.setFakeBoldText(true)
.setColor(0xffffffff)
.setTextAlign(Paint.Align.RIGHT)


阵营画笔=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setTextSize(30)
.setFakeBoldText(true)
.setColor(0xffffffff)

伤害画笔1=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setTextSize(45)
.setFakeBoldText(true)
.setColor(0xFF00FF00)
.setStrokeWidth(4)
.setTextAlign(Paint.Align.CENTER)

伤害画笔2=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setTextSize(45)
.setFakeBoldText(true)
.setColor(0xFF000000)
.setStyle(Paint.Style.STROKE)
.setStrokeWidth(2)
.setTextAlign(Paint.Align.CENTER)


名字画笔=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setTextSize(30)
.setFakeBoldText(true)
.setColor(0xffffffff)
.setTextAlign(Paint.Align.CENTER)


名字画笔2=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setTextSize(20)
.setFakeBoldText(true)
.setTextAlign(Paint.Align.CENTER)






人机画笔=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setTextSize(20)
.setFakeBoldText(true)
.setTextAlign(Paint.Align.CENTER)

血条画笔1=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setStyle(Paint.Style.STROKE)
.setStrokeWidth(2)
.setColor(0xffffffff)


血条画笔2=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setStyle(Paint.Style.STROKE)
.setStrokeWidth(4)


血条画笔3=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setFakeBoldText(true)
.setTextSize(20)
.setColor(0xffffffff)

准星画笔=Paint()
.setAntiAlias(true)
.setStrokeCap(Cap.ROUND)
.setColor(0xffff0000)

FPS画笔=Paint()
.setAntiAlias(true)--抗锯齿
.setStrokeCap(Cap.ROUND)--圆润边角
.setTextSize(30)--字体大小
.setTextAlign(Paint.Align.CENTER)--字体居中
.setFakeBoldText(true)



FPS画笔2=Paint()
.setAntiAlias(true)--抗锯齿
.setStrokeCap(Cap.ROUND)--圆润边角
.setTextSize(30)--字体大小
.setTextAlign(Paint.Align.CENTER)--字体居中
.setFakeBoldText(true)
.setColor(0xFFFF5402)



width=屏幕高()
height=屏幕宽()
width_2=width/2
height_2=height/2

$list={}
function setColor(a,b)
  local d,p
  if not list[a]
    list[a]={}
  end
  d=list[a]
  p=d[b]
  if p
    if _ENV[a]~=p
      _ENV[a]=p
    end
   else
    d[b]=Paint()
    d[b].set(_ENV[a])
    d[b].color=b
    _ENV[a]=d[b]
    paint[#paint+1]=d[b]
  end
end

paint={伤害画笔1,伤害画笔2,FPS画笔,准星画笔,方框画笔,人数画笔1,人数画笔2,射线画笔,背敌画笔1,背敌画笔2,背敌文字,路径画笔,路径方框,距离画笔,阵营画笔,名字画笔,人机画笔,血条画笔1,血条画笔2,血条画笔3}

split1=import "demo".split

function split2(szFullString, szSeparator)
  local nFindStartIndex = 1
  local nSplitIndex = 1
  local nSplitArray = Split_Table
  while true
    local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
    if not nFindLastIndex then
      nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
      break
    end
    nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
    nFindStartIndex = nFindLastIndex + string.len(szSeparator)
    nSplitIndex = nSplitIndex + 1
  end
  return nSplitArray
end

function split3(a,b)
  $idx=0
  a:gsub("[^"..b.."]+",function(w)
    idx=idx+1
    Split_Table[idx]=w
  end)
end

string.split=split1
Split_Table={}

draw=setmetatable({},{
  __newindex=function(self,key,value)
    if key=="ttf"
      $a=Typeface.createFromFile(File(activity.getLuaDir(tostring(value))))
      for k,v pairs(paint)
        v.setTypeface(a)
      end
    end
  end
})

function 屏幕方向()
  $a=activity.getWindowManager().getDefaultDisplay().getSize(Point());
  local 状态=tostring(a):match("rotation%s-(%d-)%s-,%s-density")
  return 状态=="1"
end


window.getViewTreeObserver().addOnGlobalLayoutListener(ViewTreeObserver.OnGlobalLayoutListener{
  onGlobalLayout=function()
    if 矫正
      if not 屏幕方向()
        width_2=(屏幕高()/2.0)
       else
        width_2=(width/2.0)
      end
    end
  end
});

function 振动(d)
  $a=activity.getSystemService(Context.VIBRATOR_SERVICE)
  $b=long{0,d}
  return lambda:a.vibrate(b,-1)
end

function MD提示(str,color,color2,ele,rad)
  if time then toasttime=Toast.LENGTH_SHORT else toasttime= Toast.LENGTH_SHORT end
  toasts={
    CardView;
    id="toastb",
    CardElevation=ele;
    radius=rad;
    backgroundColor=color;
    {
      TextView;
      layout_margin="7dp";
      textSize="13sp";
      TextColor=color2,
      text=str;
      layout_gravity="center";
      id="mess",
    };
  };
  local toast=Toast.makeText(activity,nil,toasttime);
  toast.setView(loadlayout(toasts))
  toast.show()
end

击伤开关=true