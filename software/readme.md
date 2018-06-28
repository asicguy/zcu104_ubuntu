# Notes on Software compilation.

## Setup Compiler Toolchain
- install Xilinx SDK 2018.1
- source /opt/Xilinx/Vivado/2018.1/settings64.sh
- export CROSS_COMPILE=aarch64-linux-gnu-
## Build bl31.elf - Arm Trusted Firmware
- cd \<git clone location\>/zcu104_ubuntu/software
- git clone https://github.com/Xilinx/arm-trusted-firmware.git
- cd arm-trusted-firmware
- git checkout xilinx-v2017.4
- make ARCH=aarch64 DEBUG=0 RESET_TO_BL31=1 PLAT=zynqmp bl31
- Output image is ../arm-trusted-firmware/build/zynqmp/release/bl31/bl31.elf
## Build Das U-Boot
- cd \<git clone location\>/zcu104_ubuntu/software
- git clone https://github.com/Xilinx/u-boot-xlnx.git
- cd u-boot-xlnx/
- make  xilinx_zynqmp_zcu104_revA_defconfig
- make
- "u-boot" is the resulting elf image.
## Build the Linux Kernel
- cd \<git clone location\>/zcu104_ubuntu/software
- git clone https://github.com/Xilinx/linux-xlnx.git
- cd linux-xlnx/
- make ARCH=arm64 xilinx_zynqmp_defconfig
- make ARCH=arm64 menuconfig
- make ARCH=arm64
- ls -lh arch/arm64/boot/Image
## Format MicroSD card
- I use a SanDisk Ultra PLUS 32GB MicrSD card.
- Use USB adapter to connect it to your Linux workstation.
- sudo gparted
- Carefully select the SD card as the device.  It should be obvious by size.
- Delete any existing partitions. (!Make sure you are operating on the SD card!)
- Create FAT32 partion called BOOT, 64MB, starting at the default low address.
- Create ext4 partition called rootfs, using rest of SD card.
## Build boot.bin
- cd sdk
- xsdk -batch -source setup.tcl
- The above step automates everything you need to do in XSDK, starting from the .hdf file.
- BOOT.bin is the first stage boot loader (FSBL) combined with u-boot into a single boot image.
- cp BOOT.bin /\<path to boot partition on microSD card\>/BOOT
## Get Ubuntu root filesystem
- We'll try to run Ubuntu 16.04 LTS
- wget https://releases.linaro.org/debian/images/developer-arm64/16.04/linaro-jessie-developer-20160428-75.tar.gz
- sudo tar -zxvf linaro-jessie-developer-20160428-75.tar.gz
- sudo cp -r binary/* /\<path to boot partition on microSD card\>/rootfs/
