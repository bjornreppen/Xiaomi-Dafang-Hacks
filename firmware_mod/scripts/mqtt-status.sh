#!/bin/sh
. /system/sdcard/scripts/common_functions.sh

## Uptime
boottime=$(cat /proc/stat | grep btime | awk '{ print $2 }')

## Wifi
ssid=$(/system/bin/iwconfig 2>/dev/null | grep ESSID | sed -e "s/.*ESSID:\"//" | sed -e "s/\".*//")
bitrate=$(/system/bin/iwconfig 2>/dev/null | grep "Bit R" | sed -e "s/   S.*//" | sed -e "s/.*\\://" | sed -e "s/Mb.*//")
quality=$(/system/bin/iwconfig 2>/dev/null | grep "Quali" | sed -e "s/  *//")
noise_level=$(echo "$quality" | awk '{ print $6}' | sed -e 's/.*=//' | sed -e 's/\/100/.0/')
link_quality=$(echo "$quality" | awk '{ print $2}' | sed -e 's/.*=//' | sed -e 's/\/100/.0/')
signal_level=$(echo "$quality" | awk '{ print $4}' | sed -e 's/.*=//' | sed -e 's/\/100/.0/')

echo "{
\"boottime\":$boottime, \
\"wifi\": { \
\"ssid\":\"$ssid\", \
\"bitrate\":$bitrate, \
\"signal_level\":$signal_level, \
\"link_quality\":$link_quality, \
\"noise_level\":$noise_level \
}, "led": { \
\"blue\":\"$(blue_led status)\", \
\"yellow\":\"$(yellow_led status)\", \
\"ir\":\"$(ir_led status)\" \
}, \
\"camera\": { \
\"ir_cut\":\"$(ir_cut status)\", \
\"brightness\":\"$(ldr status)\", \
\"rtsp_h264_server\":\"$(rtsp_h264_server status)\", \
\"rtsp_mjpeg_server\":\"$(rtsp_mjpeg_server status)\", \
\"night_mode\":\"$(night_mode status)\", \
\"night_mode_auto\":\"$(auto_night_mode status)\", \
\"motion_detection\":\"$(motion_detection status)\", \
\"motion_tracking\":\"$(motion_tracking status)\", \
\"pan_tilt\": [$(motor status horizontal), $(motor status vertical)] \
} \
}"
