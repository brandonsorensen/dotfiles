#!/bin/bash
set -e

sudo tee /boot/refind_linux.conf > /dev/null << 'EOF'
"Boot with standard options" "root=/dev/nvme1n1p3 rw nvidia-drm.modeset=1"
EOF

sudo tee /usr/local/bin/start-sway > /dev/null << 'EOF'
#!/bin/sh
export WLR_NO_HARDWARE_CURSORS=1
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export LIBVA_DRIVER_NAME=nvidia
export XDG_SESSION_TYPE=wayland
exec sway --unsupported-gpu "$@"
EOF
