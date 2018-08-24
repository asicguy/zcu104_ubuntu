#include <stdio.h>
#include <stdint.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <string.h>

#include "mem-io.h"
#include "utils.h"
#include "proto2_hw.h"


int main(int argc,char** argv)
{
    void* pcie_addr;

    uint32_t pcie_bar0_addr=BASE_ADDRESS;
    uint32_t pcie_bar0_size=PROTO_SIZE;

    pcie_addr=phy_addr_2_vir_addr(pcie_bar0_addr,pcie_bar0_size);
    if(pcie_addr==NULL)
    {
       fprintf(stderr,"can't mmap phy_addr 0x%08x with size 0x%08x to viraddr. you must be in root.\n",pcie_bar0_addr,pcie_bar0_size);
       exit(-1);
    }
    fprintf(stdout,"phy_addr 0x%08x with size 0x%08x to viraddr 0x%p.\n",pcie_bar0_addr,pcie_bar0_size, pcie_addr);

    fprintf(stdout,"FPGA ID: 0x%08X\n",read_reg(pcie_addr,FPGA_ID));
    fprintf(stdout,"VERSION: 0x%08X\n",read_reg(pcie_addr,FPGA_VERSION));

    write_reg(pcie_addr, LED_CONTROL, 0x02);

    const int Nmat = 4;
    float write_data[Nmat][Nmat], read_data[Nmat][Nmat];

    for (int row=0; row<Nmat; row++){
	for (int col=0; col<Nmat; col++){
            write_data[row][col] = (float)(row+col*4);
        }
    }

    float* ibram = pcie_addr + MATINV_IBRAM;
    float* obram = pcie_addr + MATINV_OBRAM;

    fprintf(stdout, "loading input bram\n");
    for (int row=0; row<Nmat; row++){
	for (int col=0; col<Nmat; col++){
            ibram[row+col*Nmat] = write_data[row][col];
            obram[row+col*Nmat] = 0.0;
	}
    }

    fprintf(stdout,"MATINV_CONTROL = 0x%08X\n",read_reg(pcie_addr, MATINV_CONTROL));
    fprintf(stdout,"MATINV_STATUS  = 0x%08X\n",read_reg(pcie_addr, MATINV_STATUS ));
    write_reg(pcie_addr, MATINV_CONTROL, 0x01);
    fprintf(stdout,"MATINV_CONTROL = 0x%08X\n",read_reg(pcie_addr, MATINV_CONTROL));
    fprintf(stdout,"MATINV_STATUS  = 0x%08X\n",read_reg(pcie_addr, MATINV_STATUS ));
    write_reg(pcie_addr, MATINV_CONTROL, 0x00);
    fprintf(stdout,"MATINV_CONTROL = 0x%08X\n",read_reg(pcie_addr, MATINV_CONTROL));
    fprintf(stdout,"MATINV_STATUS  = 0x%08X\n",read_reg(pcie_addr, MATINV_STATUS ));

    fprintf(stdout, "reading input bram\n");
    for (int row=0; row<Nmat; row++){
	for (int col=0; col<Nmat; col++){
            read_data[row][col] = ibram[row+col*Nmat] ;
	}
    }
    for (int row=0; row<Nmat; row++){
	for (int col=0; col<Nmat; col++){
            fprintf(stdout, "%f, ", read_data[row][col] );
	}
        fprintf(stdout, "\n");
    }

    fprintf(stdout, "reading output bram\n");
    for (int row=0; row<Nmat; row++){
	for (int col=0; col<Nmat; col++){
            read_data[row][col] = obram[row+col*Nmat] ;
	}
    }
    for (int row=0; row<Nmat; row++){
	for (int col=0; col<Nmat; col++){
            fprintf(stdout, "%f, ", read_data[row][col] );
	}
        fprintf(stdout, "\n");
    }

    munmap(pcie_addr,pcie_bar0_size);

    return 0;
}
