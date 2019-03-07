# QSPI to SSD boot instructions.
This document describes the operations necessary to boot Linux from the QSPI memory but use the sata SSD as the non-volatile filesystem.

This setup is very nice since sata SSD are designed for OS support with built in wear leveling and fault management.  Using an SDCard for filesystem storage can be slow and fail spontaneously. Also, sata SSD are blazing fast and available in capacities up to 2TB. 

The idea is to use the soldered down QSPI flash device to hold the Petalinux FSBL, U-Boot and the Linux kernel. Then a Linaro Ubuntu filesystem is copied to the sata SSD. Finally, a small change is made to the u-boot boot command to tell Linux to use the sata SSD as the root filesystem.  

This setup should be ideal for a platform that needs a non-volatile filesystem but runs continuously or needs to log or process big data at a high rate.

## Petalinux

The petalinux steps for this are more or less the same as for any other embedded linux application. There are just a couple of changes to the configuration settings.






    petalinux-create --force --type project --template zynqMP --source ~/Downloads/xilinx/zcu104/xilinx-zcu104-v2018.3-final-v2.bsp --name proj1

    cd proj1

    petalinux-config --get-hw-description=../../../fpga/implement/results/

- At the configuration menu make the following changes.

    * Under "Image Packaging Configuration" -> 
        "Root filesystem type" -> 
        Select "SD Card"
    * Under "DTG Settings" -> 
        "Kernel Bootargs" -> 
        Un-select "generate boot args automatically" -> 
        Enter "user set kernel bootargs" -> Paste in the following line
            earlycon clk_ignore_unused earlyprintk root=/dev/mmcblk0p2 rw rootwait cma=1024M
    * Save and exit the configuration menu. Wait for configuration to complete.

- Now edit a file to patch a bug in the Petalinux BSP for the zcu104.

    vim project-spec/meta-user/conf/petalinuxbsp.conf

    * Add the followint line
        IMAGE_INSTALL_remove = "gstreamer-vcu-examples"

- Now build the bootloader

    petalinux-build -c bootloader -x distclean

- Now run another configu menu.

    petalinux-config -c kernel
    
    You don't need to change anything. Just exit.

- Now build the linux kernel

    petalinux-build

    It takes a while to run.

- Now create the boot BOOT.BIN file that u-boot expects. 

    petalinux-package --boot --force --fsbl --u-boot --kernel --fpga ../../../fpga/implement/results/top.bit

    Now BOOT.BIN contains the FSBL, U-Boot, device tree, Linux kernel and minimal root filesystem.

- Now burn the BOOT.BIN into the QSPI flash. 
    - Set the jumpers JP3, JP2 and JP1 to up, up, up. This puts the board into JTAG boot mode. (Note: the board won't boot from QSPI in this mode.)
    - Open Vivado Hardware Manager and connect to the target.
    - Add the QSPI flash memory. Its an S25FL, 3.3V, 4 bits wide.
    - Add .elf file for the FSBL and the BOOT.BIN as the programming file.
    - Select program device and check erase, program and verify.
    - Burn QSPI.
    - Set the jumpers for QSPI boot mode, down, up, up.

- Boot the OS
    - Connect to the usb-uart of the board using a terminal emulator, putty, screen, minicom or similar.
    - Settings are 115200 baud, 8-1-none.
    - Hit the reset button and watch for text. First, u-boot starts. You can stop in u-boot by hitting any key.
    - After a timeout u-boot will start the linux kernel.  The petalinux-configure command creates the right boot command to 
      point to the ram filesystem, etc.
- Now create the boot files that u-boot expects. 





## U-Boot 

















- Now copy the boot files to the SD card.

    cp images/linux/BOOT.BIN /media/pedro/BOOT/
    cp images/linux/image.ub /media/pedro/BOOT/

    It is assumed that you already partitioned the SD card. 
    - sudo gparted  (make sure you have the correct drive selected!)
    - First partition called BOOT, FAT32, 512MB
    - Second partition called rootfs, ext4, use the rest of the card.

- Now down load the root filesystem. It is 360MB.

    wget https://releases.linaro.org/debian/images/developer-arm64/latest/linaro-stretch-developer-20180416-89.tar.gz

- Uncompress the root filesystem preserving file attributes and ownership.

    sudo tar --preserve -zxvf linaro-stretch-developer-20180416-89.tar.gz

- Copy the root filesystem onto the SD card preserving file attributes and ownership.

    sudo cp --recursive --preserve binary/* /media/pedro/rootfs/


- Eject the SD card from your workstation and install it in the ZCU104.

- Connect to the USB Uart port on the zcu104 and start a terminal emulator. I use screen sometimes.

    sudo screen /dev/ttyUSB1 115200

- Power on the board and watch the boot sequence. U-boot will time out and start linux. You should end up at the command prompt as root.

    If you connect an ethernet cable to your network you should be able to update the OS with

    apt update
    apt upgrade

- You can start installing things.

    apt install man
    apt install subversion

- It is a good idea to create a user for yourself and give it sudoer privileges.

    adduser myuser
    usermod -aG sudo myuser

- The serial  terminal is limiting so I like to ssh into the board. First, find the ip address of the zcu104.

    ifconfig (or "ip address")

    Then go back to your workstation.

    ssh myuser@<ip address> 

- Configure the PL side of the Zynq with an FPGA design. This has changed with this newer Linux on Zynq+.

    Modify your FPGA build script to produce a .bin file in addition to the normal .bit file. The FPGA example in this project has that command in compile.tcl.
    
    Go to your terminal on the Zynq+ Linux command line.

    Do a "git pull" to get the latest .bin file from the FPGA side of the repo.

    Copy .../fpga/implement/results/top.bit.bin to /lib/firmware. I think you need to do this as sudo.

    Change to root with "sudo su".

    echo top.bit.bin > /sys/class/fpga_manager/fpga0/firmware

    This last command should make the "Done" LED go green indicating success.

- Good luck.

    

