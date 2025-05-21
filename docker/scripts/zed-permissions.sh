#!/usr/bin/env bash
# Give the non-root user access to every ZED interface inside the container

set -e
USR=${USERNAME:-admin}
echo "[zed-permissions] setting permissions for $USR"

# SDK tree
chown -R "$USR:$USR" /usr/local/zed

# HID interfaces used by the MCU (IMU, mag, baro, pressure)
for hid in /dev/hidraw*; do
  [ -e "$hid" ] || continue
  chown "$USR:$USR" "$hid"
  chmod 666 "$hid"
done

# Legacy CDC interface (old FW only – harmless otherwise)
if [[ -e /dev/ttyACM0 ]]; then
  chown "$USR:$USR" /dev/ttyACM0
  chmod 666 /dev/ttyACM0
fi

# Make sure the USB bus nodes themselves are accessible
for n in /dev/bus/usb/*/*; do
  chown "$USR:$USR" "$n" 2>/dev/null || true
  chmod 666 "$n"          2>/dev/null || true
done

# Helpful groups
for g in video plugdev dialout; do
  getent group "$g" >/dev/null && usermod -aG "$g" "$USR"
done

echo "[zed-permissions] done"