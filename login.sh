#!/bin/sh

# 磁盘名称
DISK_NAME=RamDisk
# 磁盘路径
MOUNT_PATH=/Volumes/$DISK_NAME
# 备份路径
BAK_PATH=/Users/darkedge/ramdisk/bak/$DISK_NAME.tar.gz
# 磁盘大小，单位GB
DISK_SPACE=8
if [ ! -e $MOUNT_PATH ] ; then
    echo "创建磁盘"
    diskutil erasevolume HFS+ $DISK_NAME `hdiutil attach -nomount ram://$(($DISK_SPACE*1024*1024*2))`
fi
# 隐藏分区
chflags hidden $MOUNT_PATH

if [ -s $BAK_PATH ]; then
    echo "从备份进行恢复"
    tar -zxf $BAK_PATH -C $MOUNT_PATH
fi