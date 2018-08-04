- Download and install Xilinx Petalinux 2018.2.

- Set up your environment variables. Something like this depending on where you installed Petalinux.

    source /opt/Xilinx/petalinux/settings.sh

- Download the the zcu104 Petalinux BSP from here

    https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html

    It is called "xilinx-zcu104-v2018.2-final.bsp". Put it somewhere it can be accessed in the next command.

- Now create the petalinux project.

    petalinux-create --force --type project --template zynqMP --source ~/Downloads/xilinx/zcu104/xilinx-zcu104-v2018.2-final.bsp --name proj1

- Now configure the petalinux project with the settings we need to run Ubuntu from the SD card.

    cd proj1

    petalinux-config --get-hw-description=~/github/zcu104_ubuntu/fpga/implement/results/

- This will bring up a configuration menu.  Make the following changes.

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

- Now create the boot files that u-boot expects. 

    petalinux-package --boot --fsbl images/linux/zynqmp_fsbl.elf --u-boot images/linux/u-boot.elf

    BOOT.BIN contains the ATF, PMUFW, FSBL, U-Boot.
    image.ub contains the device tree and Linux kernel.

- Now copy the boot files to the SD card.

    cp images/linux/BOOT.BIN /media/pedro/BOOT/
    cp images/linux/image.ub /media/pedro/BOOT/

    It is assumed that you already partitioned the SD card. 
    - sudo gparted  (make sure you have the correct drive selected!)
    - First partition called BOOT, FAT32, 512MB
    - Second partition called rootfs, ext4, use the rest of the card.

- Now down load the root filesystem. It is 360MB.

    wget https://releases.linaro.org/debian/images/developer-arm64/latest/linaro-stretch-developer-20180416-89.tar.gz

- Uncompress the root filesystem

    tar -zxvf linaro-stretch-developer-20180416-89.tar.gz

- Copy the root filesystem onto the SD card.

    sudo cp -r binary/* /media/pedro/rootfs/

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

    ifconfig

    Then go back to your workstation.

    ssh myuser@<ip address> 

- If your user cannot sudo things you might need to do this command as root.

    chown root:root /usr/bin/sudo && chmod 4755 /usr/bin/sudo

- Good luck.

    
