#!/bin/bash
#
# Script to set proper permissions for ZED camera

echo "Setting ZED camera permissions for user ${USERNAME}"

# Make ZED SDK files owned by the user
chown -R ${USERNAME}:${USERNAME} /usr/local/zed

# Ensure proper device permissions
if [ -e /dev/ttyACM0 ]; then
    chown ${USERNAME}:${USERNAME} /dev/ttyACM0
    chmod 666 /dev/ttyACM0
fi

# Add user to groups that might be needed for USB access
if getent group plugdev >/dev/null; then
    usermod -aG plugdev ${USERNAME}
fi

echo "ZED camera permissions setup complete" 