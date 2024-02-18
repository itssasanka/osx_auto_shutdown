#!/usr/bin/env bash
CYAN='\x1B[0;36m'
YEL='\x1B[0;33m'
RED='\x1B[0;31m'
NC='\x1B[0m' # No Color
YT_PROMPTED="n"

tryPromptforYtVideo(){
  if [ "$YT_PROMPTED" = "y" ]; then
    return
  fi
  YT_PROMPTED="y"

  echo "${YEL}Do you want to open a Youtube video so your mac will stay awake and discharge faster?${NC}"
  echo "Enter Y/y/n/N and press ENTER"
  read openYtVideo
    
  if [ "$openYtVideo" = "y" ] || [ "$openYtVideo" = "Y" ]; then
      echo "${CYAN} Opening a video in Safari.. ${NC}"
      open -a Safari https://www.youtube.com/watch?v=4dhIvyskkB0
  elif [ "$openYtVideo" = "n" ] || [ "$openYtVideo" = "N" ]; then
      return
  fi
}

if [ "$EUID" -ne 0 ]
  then echo "Please run as root."
  exit
fi

while true
  do 
  output=`pmset -g batt`
  for i in {10..15}
  do
    if [[ $output == *"$i%"* ]]; then
      echo "Shutting down. Battery in reserve."
      shutdown -h now
    fi
  done
  log=`echo $output|grep -i discharging`

  tryPromptforYtVideo
  echo "${CYAN}>>Watching...battery reserve yet to be met.${NC}"
  echo $log
  echo
  echo
  sleep 5
done


