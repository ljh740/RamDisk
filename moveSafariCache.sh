# 磁盘名称
DISK_NAME=RamDisk
# 磁盘路径
MOUNT_PATH=/Volumes/$DISK_NAME
USERRAMDISK="${MOUNT_PATH}"
MSG_MOVE_CACHE=". Do you want me to move its cache? Note: It will close the app."
MSG_PROMPT_FOUND="I found "

#
# Checks for the user response.
#
user_response()
{
   echo -ne "$@" "[Y/n]  "
   read -r response

   case ${response} in
      [yY][eE][sS]|[yY]|"")
         true
         ;;
      [nN][oO]|[nN])
         false
         ;;
      *)
         user_response "$@"
         ;;
   esac
}

#
# Closes passed as arg app by name
#
close_app()
{
   osascript -e "quit app \"${1}\""
}

#
# Safari Cache
#
move_safari_cache()
{
   if [ -d "/Users/${USER}/Library/Caches/com.apple.Safari" ]; then
      if user_response "${MSG_PROMPT_FOUND}" 'Safari'"${MSG_MOVE_CACHE}"; then
         close_app "Safari"
         /bin/rm -rf ~/Library/Caches/com.apple.Safari
         /bin/mkdir -p "${USERRAMDISK}"/Apple/Safari
         /bin/ln -s "${USERRAMDISK}"/Apple/Safari ~/Library/Caches/com.apple.Safari
         echo "Moved Safari cache."
      fi
   fi
}