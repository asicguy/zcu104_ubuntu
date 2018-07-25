petalinux-create --force --type project --template zynqMP --source ~/Downloads/xilinx/zcu104/xilinx-zcu104-v2018.2-final.bsp --name proj1

petalinux-config --get-hw-description=~/github/zcu104_ubuntu/fpga/implement/results/

    * sd card rootfs
    * earlycon clk_ignore_unused earlyprintk root=/dev/mmcblk0p2 rw rootwait cma=1024M

$ vim project-spec/meta-user/conf/petalinuxbsp.conf

    * IMAGE_INSTALL_remove = "gstreamer-vcu-examples"

petalinux-build -c bootloader -x distclean

petalinux-config -c kernel

petalinux-build

petalinux-package --boot --fsbl images/linux/zynqmp_fsbl.elf --u-boot images/linux/u-boot.elf

cp images/linux/BOOT.BIN /media/pedro/BOOT/
cp images/linux/image.ub /media/pedro/BOOT/
