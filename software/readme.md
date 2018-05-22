# Notes on Software compilatiion.

## Setup Compiler Toolchain
- install Xilinx SDK 2018.1
- source /opt/Xilinx/Vivado/2018.1/settings64.sh
- export CROSS_COMPILE=aarch64-linux-gnu-
## Build Das U-Boot
- git clone https://github.com/Xilinx/u-boot-xlnx.git
- cd u-boot-xlnx/
- make  xilinx_zynqmp_zcu104_revA_defconfig
- make
- "u-boot" is the resulting elf image.
## Build the Linux Kernel
- git clone https://github.com/Xilinx/linux-xlnx.git
- cd linux-xlnx/
- make ARCH=arm64 xilinx_zynqmp_defconfig
- make ARCH=arm64 menuconfig
- make ARCH=arm64
- ls -lh arch/arm64/boot/Image



