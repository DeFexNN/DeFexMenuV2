function SandiHZ(file)
  if os.execute("su") then --Root execute
    path=activity.getLuaDir(file)
    os.execute("chmod 777 " .. path)
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

--
--
--





function FitureA1.OnCheckedChangeListener()
  import("yumi/draw")
  if FitureA1.checked then
    io.open("/sdcard/x", "w"):write(_ENV["屏幕高"]()):close()
    io.open("/sdcard/y", "w"):write(_ENV["屏幕宽"]()):close()
    io.open("/sdcard/a.log", "w"):write(""):close()
    io.open("/storage/emulated/0/1", "w"):write():close()
    io.open("/sdcard/stop", "w"):write(""):close()
    os.remove("/sdcard/stop")
    _ENV["绘制开关"] = true
    SandiHZ("V")
    FitureA1.setBackgroundColor(0xff00d512)
   else
    io.open("/sdcard/stop", "w"):write(""):close()
    _ENV["绘制开关"] = false
    FitureA1.setBackgroundColor(0xFF000000)
  end
end