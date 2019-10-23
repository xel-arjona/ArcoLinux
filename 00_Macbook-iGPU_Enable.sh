mkdir gpu-switch
cd gpu-switch

# Enable the iGPU at boot
curl -O -L https://github.com/0xbb/apple_set_os.efi/releases/download/v1/apple_set_os.efi

sudo mkdir /boot/efi/EFI/custom
sudo cp apple_set_os.efi /boot/efi/EFI/custom

config_dir=$(dirname $(sudo find /boot -name grub.cfg))
cat <<EOF | sudo tee "$config_dir"/custom.cfg > /dev/null
insmod chain
chainloader (\${root})/EFI/custom/apple_set_os.efi
boot
EOF

# Switch the default gpu on boot to iGPU
curl -O -L https://raw.githubusercontent.com/0xbb/gpu-switch/master/gpu-switch
chmod +x gpu-switch

./gpu-switch -i

# Service to disable the dGPU
cat <<EOF | sudo tee /etc/systemd/system/disable-dgpu.service > /dev/null
[Unit]
Description=Disable the dGPU

[Service]
Type=oneshot
ExecStart=/bin/sh -c 'echo OFF > /sys/kernel/debug/vgaswitcheroo/switch'
ExecStop=/bin/sh -c 'echo ON > /sys/kernel/debug/vgaswitcheroo/switch'
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

sudo chmod 644 /etc/systemd/system/disable-dgpu.service

cd -
