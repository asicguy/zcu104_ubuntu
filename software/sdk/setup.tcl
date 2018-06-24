# execute this scipt with this command "xsdk -batch -source setup.tcl"
set sdk_dir .

set bsp "bsp"
set hwproject "hw"
set application "sw"
set fsbl "fsbl"
set pmufw "pmufw"
set pmubsp "pmubsp"
set hwspec ../../fpga/implement/results/top.hdf
set os "standalone"

# delete the old
file delete -force $sdk_dir/.metadata
file delete -force $sdk_dir/$bsp
file delete -force $sdk_dir/$hwproject
file delete -force $sdk_dir/$fsbl
file delete -force $sdk_dir/$pmubsp
file delete -force $sdk_dir/$pmufw

# Create workspace and import the project into
setws $sdk_dir

createhw -name $hwproject -hwspec $hwspec

# Create Arm bsp
createbsp -name $bsp -hwproject $hwproject -proc "psu_cortexa53_0" -os $os
setlib -bsp $bsp -lib xilffs
setlib -bsp $bsp -lib xilsecure
setlib -bsp $bsp -lib xilpm

# Update the microprocessor software spec (MSS) and regenerate the BSP
updatemss -mss $sdk_dir/$bsp/system.mss
regenbsp -bsp $bsp

# create PMU bsp
createbsp -name $pmubsp -hwproject $hwproject -proc "psu_pmu_0" -os "standalone"
setlib -bsp $pmubsp -lib xilfpga
setlib -bsp $pmubsp -lib xilsecure

# Update the microprocessor software spec (MSS) and regenerate the BSP
updatemss -mss $sdk_dir/$pmubsp/system.mss
regenbsp -bsp $pmubsp

# Create new application project as Empty Application 
createapp -name $fsbl  -app {Zynq MP FSBL} -proc "psu_cortexa53_0" -hwproject $hwproject -bsp $bsp -os $os
configapp -app  $fsbl define-compiler-symbols FSBL_DEBUG_INFO

createapp -name $pmufw -app {ZynqMP PMU Firmware} -proc "psu_pmu_0" -hwproject $hwproject -bsp $pmubsp -os $os

# Clean and build all projects
projects -clean
projects -build

puts "generating BOOT.bin from images"
exec bootgen -arch zynqmp -w on -log trace -image output.bif -w -o BOOT.bin

