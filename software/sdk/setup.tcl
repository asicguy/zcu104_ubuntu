# execute this scipt with this command "xsdk -batch -source setup.tcl"
set sdk_dir .

set bsp "bsp"
set hwproject "hw"
set application "sw"
set fsbl "fsbl"
#set pmufw "pmufw"
#set pmubsp "pmubsp"
set hwspec ../../fpga/implement/results/top.hdf
set proc "psu_cortexa53_0"
set os "standalone"

# out with the old
file delete -force $sdk_dir/.metadata
file delete -force $sdk_dir/$bsp
file delete -force $sdk_dir/$hwproject
file delete -force $sdk_dir/$fsbl
#file delete -force $sdk_dir/$pmubsp
#file delete -force $sdk_dir/$pmufw

# Create workspace and import the project into
setws $sdk_dir

createhw -name $hwproject -hwspec $hwspec

createbsp -name $bsp -hwproject $hwproject -proc $proc -os $os
setlib -bsp $bsp -lib xilffs
setlib -bsp $bsp -lib xilsecure
setlib -bsp $bsp -lib xilpm

#createbsp -name "pmu_bsp" -hwproject $hwproject -proc "psu_pmu_0" -os "standalone"
#setlib -bsp "pmu_bsp" -lib xilfpga
#setlib -bsp "pmu_bsp" -lib xilsecure

# Update the microprocessor software spec (MSS) and regenerate the BSP
updatemss -mss $sdk_dir/$bsp/system.mss
regenbsp -bsp $bsp

# Create new application project as Empty Application 
#createapp -name $application -app {Empty Application} -proc $proc -hwproject $hwproject -bsp $bsp -os $os
createapp -name $fsbl  -app {Zynq MP FSBL} -proc $proc -hwproject $hwproject -bsp $bsp -os $os

#createapp -name $pmufw -app {ZynqMP PMU Firmware} -proc "psu_pmu_0" -hwproject $hwproject -bsp "pmu_bsp" -os $os

# add the libm math library to the linker script.
#configapp -app $application libraries m

# Clean and build all projects
projects -clean
projects -build

exec bootgen -arch zynqmp -image output.bif -w -o BOOT.bin

