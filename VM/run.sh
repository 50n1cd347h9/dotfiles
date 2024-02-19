sudo qemu-system-x86_64 \
-hda archlinux.qcow2 \
-boot d \
-m 4096 \
-machine q35 \
-cpu max \
-smp cpus=4,sockets=1,cores=4,threads=1 \
-nic vmnet-shared \
-display none
