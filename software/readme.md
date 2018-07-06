# Notes on Software compilation.
These instructions attempt to compile everythng from primary sources (except the ATF). Xilinx calls this the OSL flow.
## Setup Compiler Toolchain
- install Xilinx SDK 2018.2
- source /opt/Xilinx/SDK/2018.2/settings64.sh
- export CROSS_COMPILE=aarch64-linux-gnu-
## Build bl31.elf - Arm Trusted Firmware
! Caution: the build instructions below for bl31.elf do not work! Instead use the bl31.elf in the zip file found here: 
    https://www.xilinx.com/member/forms/download/design-license-xef.html?akdm=1&filename=zcu104-rv-ss-2017-4.zip

That elf file is committed to the sdk folder of this git repository and output.bif is modified to point to it.

ATF is something new with the 64 bit Arm processors. It has something to do with secure access to hardware features of the chip but for most users it is a black box.  ATF must be compiled and included in the ZynqMP boot image.
- cd \<git clone location\>/zcu104_ubuntu/software
- git clone https://github.com/Xilinx/arm-trusted-firmware.git
- cd arm-trusted-firmware
- git checkout xilinx-v2018.2
- make ARCH=aarch64 DEBUG=0 RESET_TO_BL31=1 PLAT=zynqmp bl31
- Output image is ../arm-trusted-firmware/build/zynqmp/release/bl31/bl31.elf
## Build Das U-Boot
- cd \<git clone location\>/zcu104_ubuntu/software
- git clone https://github.com/Xilinx/u-boot-xlnx.git
- cd u-boot-xlnx/
- git checkout xilinx-v2018.2
- make  xilinx_zynqmp_zcu104_revA_defconfig
- make
- "u-boot.elf" is the resulting elf image.
## Create BOOT.bin
BOOT.bin is a collection of compiled software moudules and an FPGA .bit file. It is produced automatically here by a TCL script that runs in XSDK.
- cd \<git clone location\>/zcu104_ubuntu/software/sdk
- xsdk -batch -source setup.tcl
- BOOT.bin is the output file.
## Format MicroSD card
- I use a SanDisk Ultra PLUS 32GB MicrSD card.
- Use USB adapter to connect it to your Linux workstation.
- sudo gparted
- Carefully select the SD card as the device.  It should be obvious by size.
- Delete any existing partitions. (!Make sure you are operating on the SD card!)
- Create FAT32 partion called BOOT, 64MB, starting at the default low address.
- Create ext4 partition called rootfs, using the rest of the SD card.
## Build boot.bin
- cd sdk
- xsdk -batch -source setup.tcl
- The above step automates everything you need to do in XSDK, starting from the .hdf file.
- BOOT.bin is the first stage boot loader (FSBL) combined with u-boot into a single boot image.
- cp BOOT.bin /\<path to boot partition on microSD card\>
## Build the Linux Kernel
- cd \<git clone location\>/zcu104_ubuntu/software
- git clone https://github.com/Xilinx/linux-xlnx.git
- cd linux-xlnx/
- git checkout xilinx-v2018.2
- make ARCH=arm64 xilinx_zynqmp_defconfig
- make ARCH=arm64 menuconfig
- make ARCH=arm64
- ls -lh arch/arm64/boot/Image
- cp arch/arm64/boot/Image /media/pedro/BOOT/
## Get Ubuntu root filesystem
- We'll try to run Ubuntu 16.04 LTS
- wget https://releases.linaro.org/debian/images/developer-arm64/16.04/linaro-jessie-developer-20160428-75.tar.gz
- sudo tar -zxvf linaro-jessie-developer-20160428-75.tar.gz
- sudo cp -r binary/* /\<path to rootfs partition on microSD card\>

