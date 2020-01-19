# RamDisk
osx自定义内存缓存盘

# 使用
将脚本复制到~/ramdisk 下

执行 
```
sudo chmod a+x login.sh
sudo chmod a+x logout.sh

sudo defaults write com.apple.loginwindow LoginHook ~/ramdisk/login.sh
sudo defaults write com.apple.loginwindow LogoutHook ~/ramdisk/logout.sh
```

