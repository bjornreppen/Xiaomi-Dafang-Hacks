#!/bin/sh
. /system/sdcard/config/mqtt.conf
. /system/sdcard/scripts/common_functions.sh

if [ "$STATUSINTERVAL" -lt 30 ]; then
  STATUSINTERVAL=30
fi

while true
do
  /system/sdcard/bin/mosquitto_pub.bin -h "$HOST" -p "$PORT" -u "$USER" -P "$PASS" -t "${TOPIC}/status/${HOSTNAME}" ${MOSQUITTOOPTS} ${MOSQUITTOPUBOPTS} -r -m "$(/system/sdcard/scripts/mqtt-status.sh)"
  sleep $STATUSINTERVAL
done
