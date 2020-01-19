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
# Chrome Canary Cache
#
move_chrome_cache()
{
   if [ -d "/Users/${USER}/Library/Caches/Google/Chrome" ]; then
      if user_response "${MSG_PROMPT_FOUND}" 'Chrome'"${MSG_MOVE_CACHE}" ; then
         close_app "Google Chrome"
         /bin/mkdir -p /tmp/Google
         /bin/mv ~/Library/Caches/Google/* /tmp/Google
         /bin/mkdir -pv "${USERRAMDISK}"/Google
         /bin/mv /tmp/Google/* "${USERRAMDISK}"/Google
         /bin/ln -v -s -f "${USERRAMDISK}"/Google ~/Library/Caches/Google/
         /bin/rm -rf /tmp/Google
         # and let's create a flag for next run that we moved the cache.
         echo "";
      fi
   else
      echo "No Google Chrome folder has been found. Skipping."
   fi
}

move_chrome_cache