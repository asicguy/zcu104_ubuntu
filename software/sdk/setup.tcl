# execute this scipt with this command "xsdk -batch -source setup.tcl"

set sdk_dir .


set application "sw"
set bsp "bsp"
set hwproject "hw"
set fsbl "fsbl"

file delete -force $sdk_dir/.metadata
file delete -force $sdk_dir/$bsp
file delete -force $sdk_dir/$hwproject
file delete -force $sdk_dir/$fsbl

set hwspec ../../fpga/implement/results/top.hdf
set proc "psu_cortexa53_0"
set os "standalone"

# Create workspace and import the project into
setws $sdk_dir

createhw -name $hwproject -hwspec $hwspec

createbsp -name $bsp -hwproject $hwproject -proc $proc -os $os
setlib -bsp $bsp -lib xilffs
setlib -bsp $bsp -lib xilsecure
setlib -bsp $bsp -lib xilpm

# Update the microprocessor software spec (MSS) and regenerate the BSP
updatemss -mss $sdk_dir/$bsp/system.mss
regenbsp -bsp $bsp

# Create new application project as Empty Application 
#createapp -name $application -app {Empty Application} -proc $proc -hwproject $hwproject -bsp $bsp -os $os
createapp -name $fsbl -app {Zynq MP FSBL} -proc $proc -hwproject $hwproject -bsp $bsp -os $os

# add the libm math library to the linker script.
#configapp -app $application libraries m

# Clean and build all projects
projects -clean
projects -build

exec bootgen -arch zynqmp -image output.bif -w -o BOOT.bin

