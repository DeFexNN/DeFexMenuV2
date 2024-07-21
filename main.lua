require "import"
import "res/init"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "android.graphics.drawable.ColorDrawable"
import "android.graphics.drawable.GradientDrawable"
import "android.provider.Settings"
import "android.content.Context"
import "android.net.Uri"
import "android.graphics.Typeface"
import "android.content.Intent"
import "layout"
import "java.io.File"
import "su"
import "zip4j"
import "java.util.zip.*"
import "java.io.*"

os.execute("su")

activity.setTitle("DeFexInjector")
activity.setContentView(loadlayout(layout))
activity.setTheme(R.AndLua18)
activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(0xB3202428);
--activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
activity.setContentView(loadlayout(layout))

import "layout2"


LayoutVIP1=activity.getSystemService(Context.WINDOW_SERVICE)
HasFocus=false
WmHz1=WindowManager.LayoutParams()
if Build.VERSION.SDK_INT >= 26 then WmHz1.type =WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
 else WmHz1.type =WindowManager.LayoutParams.TYPE_SYSTEM_ALERT
end
import "android.graphics.PixelFormat"
WmHz1.format =PixelFormat.RGBA_8888
WmHz1.flags=WindowManager.LayoutParams().FLAG_NOT_FOCUSABLE
WmHz1.gravity = Gravity.LEFT| Gravity.TOP
WmHz1.x = 0
WmHz1.y = 0
WmHz1.width = WindowManager.LayoutParams.WRAP_CONTENT
WmHz1.height = WindowManager.LayoutParams.WRAP_CONTENT
mainWindow1 = loadlayout(layout2)
isMax1=true

function menu.OnTouchListener(v,event)
  if event.getAction()==MotionEvent.ACTION_DOWN then
    firstX=event.getRawX()
    firstY=event.getRawY()
    wmX=WmHz1.x
    wmY=WmHz1.y
   elseif event.getAction()==MotionEvent.ACTION_MOVE then
    WmHz1.x=wmX+(event.getRawX()-firstX)
    WmHz1.y=wmY+(event.getRawY()-firstY)
    LayoutVIP1.updateViewLayout(mainWindow1,WmHz1)
   elseif event.getAction()==MotionEvent.ACTION_UP then
  end return true
end
function win_move.OnTouchListener(v,event)
  if event.getAction()==MotionEvent.ACTION_DOWN then
    firstX=event.getRawX()
    firstY=event.getRawY()
    wmX=WmHz1.x
    wmY=WmHz1.y
   elseif event.getAction()==MotionEvent.ACTION_MOVE then
    WmHz1.x=wmX+(event.getRawX()-firstX)
    WmHz1.y=wmY+(event.getRawY()-firstY)
    LayoutVIP1.updateViewLayout(mainWindow1,WmHz1)
   elseif event.getAction()==MotionEvent.ACTION_UP then
  end return true
end


function Waterdropanimation(Controls,time)
  import "android.animation.ObjectAnimator"
  ObjectAnimator().ofFloat(Controls,"scaleX",{1,.8,1.3,.9,1}).setDuration(time).start()
  ObjectAnimator().ofFloat(Controls,"scaleY",{1,.8,1.3,.9,1}).setDuration(time).start()
end





function CircleButton(view,InsideColor,radiu,InsideColor1)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setCornerRadii({radiu, radiu, radiu, radiu, radiu, radiu, radiu, radiu})
  drawable.setColor(InsideColor)
  drawable.setStroke(2, InsideColor1)
  view.setBackgroundDrawable(drawable)
end

function CircleButton3(view,InsideColor,radiu,InsideColor1)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setCornerRadii({radiu, radii, radii, radiu, radiu, radiu, radiu, radiu})
  drawable.setColor(InsideColor)
  drawable.setStroke(5, InsideColor1)
  view.setBackgroundDrawable(drawable)
end

function CircleButtonA(view,InsideColor,radiu,InsideColor1)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setCornerRadii({radiu, radiu, radiu, radiu, 0, 0, 0, 0})
  drawable.setColor(InsideColor)
  drawable.setStroke(5, InsideColor1)
  view.setBackgroundDrawable(drawable)
end



function CircleButton1(view,InsideColor,radiu,InsideColor1)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setCornerRadii({radiu, radiu, radiu, radiu, radiu, radii, radii, radiu})
  drawable.setColor(InsideColor)
  drawable.setStroke(4, InsideColor1)
  view.setBackgroundDrawable(drawable)
end


function CircleButton2(view,InsideColor,radiu,InsideColor1)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setCornerRadii({20, 20, 20, 20, 0, 20, 0, 20})
  drawable.setColor(InsideColor)
  drawable.setStroke(2, InsideColor1)
  view.setBackgroundDrawable(drawable)
end

function CircleButtonY(view,InsideColor,radiu,InsideColor1)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setCornerRadii({radiu, radiu, radiu, radiu, 0, 0, 0, 0})
  drawable.setColor(InsideColor)
  drawable.setStroke(5, InsideColor1)
  view.setBackgroundDrawable(drawable)
end

CircleButton(start,0xFF0068FF,30,0xFF0068FF)

CircleButton(delet,0xffFA8482,20,0xffFA8482)

function start.OnCheckedChangeListener()
  CircleButton(start,0xFF0068FF,30,0xFF0068FF)
  if start.checked then
    CircleButton(start,0xFFFF0000,30,0xFFFF0000)
    HasLaunch=false
    if HasLaunch==true then return else
      if Settings.canDrawOverlays(activity) then else intent=Intent("android.settings.action.MANAGE_OVERLAY_PERMISSION");
        intent.setData(Uri.parse("package:" .. this.getPackageName())); this.startActivity(intent); end HasLaunch=true
      local ret={pcall(function() LayoutVIP1.addView(mainWindow1,WmHz1) end)}
      if ret[1]==false then end end import "java.io.*" file,err=io.open("/data/data/com.acnologia.mod/files/Memory.lua")
   else
    LayoutVIP1.removeView(mainWindow1)
  end
end





import "android.graphics.drawable.BitmapDrawable"



isMax=false
function img1.onClick()
  if isMax==false then
    isMax=true
    img1.setImageDrawable(BitmapDrawable(loadbitmap("ic_to_bottom.png")))
    cheatMenu.setVisibility(View.VISIBLE)
   else
    isMax=false
    img1.setImageDrawable(BitmapDrawable(loadbitmap("ic_to_top.png")))
    cheatMenu.setVisibility(View.GONE)
  end
end

isMax=false
function img2.onClick()
  if isMax==false then
    isMax=true
    img2.setImageDrawable(BitmapDrawable(loadbitmap("ic_to_bottom.png")))
   else
    isMax=false
    img2.setImageDrawable(BitmapDrawable(loadbitmap("ic_to_top.png")))
  end
end

isMax=false
function img3.onClick()
  if isMax==false then
    isMax=true
    img3.setImageDrawable(BitmapDrawable(loadbitmap("ic_to_bottom.png")))
   else
    isMax=false
    img3.setImageDrawable(BitmapDrawable(loadbitmap("ic_to_top.png")))
  end
end

isMax=false
function img4.onClick()
  if isMax==false then
    isMax=true
    img4.setImageDrawable(BitmapDrawable(loadbitmap("ic_to_bottom.png")))
   else
    isMax=false
    img4.setImageDrawable(BitmapDrawable(loadbitmap("ic_to_top.png")))
  end
end

isMax=false
function img5.onClick()
  if isMax==false then
    isMax=true
    img5.setImageDrawable(BitmapDrawable(loadbitmap("ic_to_bottom.png")))
   else
    isMax=false
    img5.setImageDrawable(BitmapDrawable(loadbitmap("ic_to_top.png")))
  end
end

CircleButton(basic,0xffBAD5F3,12,0xffBAD5F3)
CircleButton(aimbot,0xffBAD5F3,12,0xffBAD5F3)
CircleButton(save,0xffBAD5F3,0,0xffBAD5F3)
CircleButton(fire,0xffBAD5F3,0,0xffBAD5F3)
CircleButton(attachments,0xffBAD5F3,12,0xffBAD5F3)
CircleButton(sniper,0xffBAD5F3,12,0xffBAD5F3)
CircleButton(savee,0xffBAD5F3,0,0xffBAD5F3)
CircleButton(res,0xffFA8482,0,0xffFA8482)
CircleButton(fix,0xffFA8482,0,0xffFA8482)
CircleButton(log,0xffBAD5F3,0,0xffBAD5F3)

import "android.graphics.Typeface"
CircleButton2(menu1,0xff96B2E1,20,0xff96B2E1)
pg.showPage(0)
menu1.onClick=function()
  pg.showPage(0)
  CircleButton2(menu1,0xff96B2E1,0,0xff96B2E1)
  CircleButton2(menu2,0xffBFC6D0,0,0xffBFC6D0)
  CircleButton2(menu3,0xffBFC6D0,0,0xffBFC6D0)
end
menu2.onClick=function()
  pg.showPage(1)
  CircleButton2(menu2,0xff96B2E1,0,0xff96B2E1)
  CircleButton2(menu1,0xffBFC6D0,0,0xffBFC6D0)
  CircleButton2(menu3,0xffBFC6D0,0,0xffBFC6D0)
end
menu3.onClick=function()
  pg.showPage(2)
  CircleButton2(menu3,0xff96B2E1,0,0xff96B2E1)
  CircleButton2(menu2,0xffBFC6D0,0,0xffBFC6D0)
  CircleButton2(menu1,0xffBFC6D0,0,0xffBFC6D0)
end
pg.addOnPageChangeListener{
  onPageScrolled=function(a,b,c)
  end,
  onPageSelected=function(page)
    if page==0 then
      CircleButton2(menu1,0xff96B2E1,0,0xff96B2E1)
      CircleButton2(menu2,0xffBFC6D0,0,0xffBFC6D0)
      CircleButton2(menu3,0xffBFC6D0,0,0xffBFC6D0)
      --CircleButton(menu6,0x00000000,20,0x00000000)
    end
    if page==1 then
      CircleButton2(menu2,0xff96B2E1,0,0xff96B2E1)
      CircleButton2(menu1,0xffBFC6D0,0,0xffBFC6D0)
      CircleButton2(menu3,0xffBFC6D0,0,0xffBFC6D0)
      --CircleButton(menu6,0x00000000,20,0x00000000)
    end
    if page==2 then
      CircleButton2(menu3,0xff96B2E1,0,0xff96B2E1)
      CircleButton2(menu2,0xffBFC6D0,0,0xffBFC6D0)
      CircleButton2(menu1,0xffBFC6D0,0,0xffBFC6D0)
      --CircleButton(menu6,0x00000000,20,0xFF474A8D)
    end
  end,
  onPageScrollStateChanged=function(state)
  end,
}

function ExecuteELF(file)
  if os.execute("su") then --Root execute
    path=activity.getLuaDir(file)
    os.execute("su -c chmod 777 "..path)
    if pcall(function()Runtime.getRuntime().exec("su -c "..path)end) then
     else
    end
   else
    path=activity.getLuaDir(file) --No Root execute
    os.execute("chmod 777 "..path)
    if pcall(function()Runtime.getRuntime().exec(""..path)end) then
     else
    end
  end
end

exit.onClick=function()
  os.exit()
end

lox.onClick=function()
  if pcall(function() activity.getPackageManager().getPackageInfo("com.herogame.gplay.lastdayrulessurvival",0) end) then
    this.startActivity(activity.getPackageManager().getLaunchIntentForPackage("com.herogame.gplay.lastdayrulessurvival"))
   else
    print("LIOS Not installed")
  end
end


telegram.onClick=function()
  url = "http://t.me/defexhacks"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end


chat.onClick=function()
  url = "https://t.me/defexchatix"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end





function antenna.onClick()
  if antenna.checked==true then
    ExecuteELF("cpp/antenna/antenaon")
  end
  if antenna.checked==false then
    ExecuteELF("cpp/antenna/antenaoff")
  end
end





function rudall.onClick()
  if rudall.checked==true then
    zip4j.unZipDir(
    activity.getLuaDir("/cpp/ruda.zip"),
    activity.getLuaDir("Files/")
    "123")
    ExecuteELF("Files/ruda1")
    ExecuteELF("Files/ruda2")
    ExecuteELF("Files/ruda3")
    ExecuteELF("Files/ruda4")
    ExecuteELF("Files/ruda5")
  end
  if rudall.checked==false then

  end
end





function notexture.onClick()
  if notexture.checked==true then
    ExecuteELF("texture")
    ExecuteELF("iillilililililililuill")
    ExecuteELF("texxture")
  end
  if notexture.checked==false then
    ExecuteELF("textureoff")
    ExecuteELF("iilililililioipoloioiooooooop")
  end
end

function pvp.onClick()
  ExecuteELF ("cpp/bullet/zzk")
  ExecuteELF ("cpp/bullet/zzg")
  ExecuteELF ("cpp/bullet/zmk")
  ExecuteELF ("cpp/bullet/zmg")
  ExecuteELF ("cpp/bullet/kjxk2")
  ExecuteELF ("cpp/bullet/kjxk")
  ExecuteELF ("cpp/bullet/ak")
end



function 执行(二进制)
  if 检测权限==true then
    路径=activity.getLuaDir(二进制)
    os.execute("chmod 777 "..路径)
    os.execute("su -c chmod 777 "..路径)
    Runtime.getRuntime().exec("su -c "..路径)
   else
    路径=activity.getLuaDir(二进制)
    os.execute("chmod 777 "..路径)
    Runtime.getRuntime().exec(路径)
  end
end


function magic.onClick()
  ExecuteELF ("cpp/magicbullet/mgc2")
end


function scope.onClick
  if scope.checked then
    ExecuteELF ("cpp/10x/RR_ON")
   else
    ExecuteELF ("cpp/10x/RR_OFF")

  end
end


function ipad.onClick
  if ipad.checked then
    ExecuteELF ("cpp/ipad/ppoopppp1")
   else
    ExecuteELF ("cpp/ipad/ppoopppp2")

  end
end



function test.onClick
  ExecuteELF ("cpp/bed/antenna")
end

function fastreload.onClick
  ExecuteELF ("cpp/reload/reload")
end

function virt.onClick
  if virt.checked then
    ExecuteELF("cpp/build/visual_build_on")
   else
    ExecuteELF("cpp/build/visual_build_off")
  end
end

function lol.onClick
  os.exit()
end


game.onClick=function()
  if pcall(function() activity.getPackageManager().getPackageInfo("com.herogame.gplay.lastdayrulessurvival",0) end) then
    this.startActivity(activity.getPackageManager().getLaunchIntentForPackage("com.herogame.gplay.lastdayrulessurvival"))
   else
    print("LIOS Not installed")
  end
end


function nomap.onClick
  if nomap.checked then
    ExecuteELF("cpp/map/kjxk")
   else
    ExecuteELF("cpp/build/kjxk2")
  end
end


function bag.onClick
  ExecuteELF ("cpp/bed/antenna")
end

function spalka.onClick
  ExecuteELF ("cpp/spalka/spalka")
end


function 执行(二进制)
  if 检测权限==true then
    路径=activity.getLuaDir(二进制)
    os.execute("chmod 777 "..路径)
    os.execute("su -c chmod 777 "..路径)
    Runtime.getRuntime().exec("su -c "..路径)
   else
    路径=activity.getLuaDir(二进制)
    os.execute("chmod 777 "..路径)
    Runtime.getRuntime().exec(路径)
  end
end

function 执行功能(路径,循环)
  local 执行路径=activity.getLuaDir(路径)
  if os.execute("su")==true then
    import "su"
    su("chmod 777 "..执行路径)
    if 循环=="1" then
      function 线程执行(路径)
        require "import"
        import "su"
        su(路径)
      end
      thread(线程执行,执行路径)
     else
      su(执行路径)
    end
   else
    os.execute("chmod 777 "..执行路径)
    Runtime.getRuntime().exec(""..执行路径)
  end
end


function root执行(路径二,提示二)--中文函数
  调用路径二=activity.getLuaDir(路径二)--自动获取lua文件的执行路径,只需填二进制在插件的目录路径即可
  os.execute("su -c chmod 777 "..调用路径二)--授予777权限
  Runtime.getRuntime().exec("su -c "..调用路径二)--root执行二进制功能
  print(提示二)
end


import "aide"--导入模板
import "aide/draw"

draw.ttf="res/2.ttf"--设置绘制字体

function 绘制.onClick() --监听开关按钮
  if 绘制.checked then
    os.execute("su")
    io.open("/sdcard/x.log","w"):write(屏幕高()):close()
    io.open("/sdcard/y.log","w"):write(屏幕宽()):close()
    io.open("/sdcard/a.log","w"):write(""):close()
    os.remove("/sdcard/stop")
    绘制开关=true
    root执行("jvav/draw")
   else
    绘制开关=false
    io.open("/sdcard/stop","w"):write(""):close()
  end
end

function 方框.onClick
  if 方框.checked==true then
    绘制方框=true
   else
    绘制方框=
    方框.setChecked(false)
  end
end

function 射线.onClick
  if 射线.checked==true then
    绘制射线=true
   else
    绘制射线=false
    射线.setChecked(false)
  end
end


function 信息.onClick
  if 信息.checked==true then
    绘制信息=true
   else
    绘制信息=false
    信息.setChecked(false)
  end
end


function 背敌.onClick
  if 背敌.checked==true then
    绘制背敌=true
   else
    绘制背敌=false
    背敌.setChecked(false)
  end
end


import "java.io.*"
file,err=io.open("/sdcard/hztz")
if err~=nil then
  io.open("/sdcard/hztz","w"):write("0"):close()
end

local file=io.input("/sdcard/hztz")
local str=io.read("*a")
io.close()
X轴纠正=tonumber(str)

X轴纠正=0
调整度.Max=100
调整度.min=-100
调整度.setOnSeekBarChangeListener
{
  onProgressChanged=function()
    调整值.Text=tostring(调整度.Progress)
    X轴纠正=tonumber(调整度.Progress)
    io.open("/sdcard/hztz","w"):write(X轴纠正):close()
  end
}



function aboba.onClick
  ExecuteELF ("cpp/bullettrack/bullettrack")
end