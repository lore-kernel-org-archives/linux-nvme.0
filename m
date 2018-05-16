From: bharatku@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 16 May 2018 12:35:15 +0000
Subject: INTMS/INTMC not being used in NVME interrupt handling
Message-ID: <BLUPR0201MB1505371050ED798BE025132BA5920@BLUPR0201MB1505.namprd02.prod.outlook.com>

Hi,

As per NVME specification: 
7.5.1.1 Host Software Interrupt Handling
It is recommended that host software utilize the Interrupt Mask Set and Interrupt Mask Clear (INTMS/INTMC) 
registers to efficiently handle interrupts when configured to use pin based or MSI messages.

In kernel 4.14, drivers/nvme/host/pci.c function nvme_isr 
doesn't  use these registers. 

Any reason why these registers are not used in nvme interrupt handler ?

Why NVMe driver is not using any bottom half and processing all completion queues
in interrupt handler ?

Regards,
Bharat
