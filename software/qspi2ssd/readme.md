# QSPI to SSD boot instructions.
This document describes the operations necessary to boot Linux from the QSPI memory but use the sata SSD as the non-volatile filesystem.

This setup is very nice since sata SSD are designed for OS support with built in wear leveling and fault management.  Using an SDCard for filesystem storage can be slow and fail spontaneously. Also, sata SSD are blazing fast and available in capacities up to 2TB. 




