From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 16 May 2018 08:42:40 -0600
Subject: INTMS/INTMC not being used in NVME interrupt handling
In-Reply-To: <BLUPR0201MB1505371050ED798BE025132BA5920@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <BLUPR0201MB1505371050ED798BE025132BA5920@BLUPR0201MB1505.namprd02.prod.outlook.com>
Message-ID: <20180516144240.GA20223@localhost.localdomain>

On Wed, May 16, 2018@12:35:15PM +0000, Bharat Kumar Gogada wrote:
> Hi,
> 
> As per NVME specification: 
> 7.5.1.1 Host Software Interrupt Handling
> It is recommended that host software utilize the Interrupt Mask Set and Interrupt Mask Clear (INTMS/INTMC) 
> registers to efficiently handle interrupts when configured to use pin based or MSI messages.
> 
> In kernel 4.14, drivers/nvme/host/pci.c function nvme_isr 
> doesn't  use these registers. 
> 
> Any reason why these registers are not used in nvme interrupt handler ?

I think you've answered your own question: we process completions in the
interrupt context. The interrupt is already masked at the CPU level in
this context, so there should be no reason to mask them at the device
level.
 
> Why NVMe driver is not using any bottom half and processing all completion queues
> in interrupt handler ?

Performance.
