# zcu104_ubuntu
## A project to demonstrate Xilinx MPSOC running Ubuntu

The Xilinx Multi-Processor System On Chip (MPSOC) devices provide agile solutions to a large class of problems. One application that is rarely discussed is their use as design verification engines. Many custom logic blocks contain so much complexity that it is impossible to adequately verify them using traditional simulation techniques.  A fast microprocessor, tightly coupled to a high performance FPGA fabric is ideal for running logic through vast test sets. Once running, hardware verification can have a six order of magnitude speed increase compared to simulation.

When testing logic it is ideal to have a complete desktop Linux distribution running on the control computer. Rich development and analysis tools become available such as subversion, git, make, Octave, python, gcc, vim, ssh, Apache, bash, ....  

This goal of this project is to demonstrate Ubuntu running on MPSOC for the purpose of logic verification.

### ToDo:
- **Create an FPGA Test Design** - This is mostly complete. CPU can access a BRAM and a register file.
- **Create the First Stage Boot Loader** - The FSBL is automatically generated and is more or less required to get the Arm cores running. We have an XSCT script that automatically builds the FSBL from the hdf file. Go to .../software/sdk and run "xsdk -batch -source setup.tcl".
- **Install Das U-Boot** - This is the the bootloader most commonly used for embedded systems. It is really a small operating system in itself that can be used to run programs, access networks, test memory and boot other operating systems.  In this installation it functions as a Second Stage Boot Loader.
- **Install SSD** - The ZCU104 provides a slot for an SSD. The format is M.2 2242 which is unusual but readily available.  It would be very nice to run Ubuntu from a true SSD.  The small SD Card on the board can be used to run Linux well but those little memory cards have neither wear levelling nor other things that SSD drives have to provide reliability.
- **Install GRUB2** - If we are able to use U-Boot to load and run programs from the SSD we should be able to install GRUB2. Running GRUB2 would allow Ubuntu software update services to update the kernel itself. Everything would run like a real x86 Ubuntu desktop machine.
- **Demonstrate large-scale hardware verification** - We need suggestions on this.
