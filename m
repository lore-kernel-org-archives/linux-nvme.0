From: bharatku@xilinx.com (Bharat Kumar Gogada)
Date: Thu, 17 May 2018 11:15:59 +0000
Subject: INTMS/INTMC not being used in NVME interrupt handling
In-Reply-To: <20180516144240.GA20223@localhost.localdomain>
References: <BLUPR0201MB1505371050ED798BE025132BA5920@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <20180516144240.GA20223@localhost.localdomain>
Message-ID: <BLUPR0201MB1505BF5E68D05F25A53D3B96A5910@BLUPR0201MB1505.namprd02.prod.outlook.com>

> > Hi,
> >
> > As per NVME specification:
> > 7.5.1.1 Host Software Interrupt Handling It is recommended that host
> > software utilize the Interrupt Mask Set and Interrupt Mask Clear
> > (INTMS/INTMC) registers to efficiently handle interrupts when configured
> to use pin based or MSI messages.
> >
> > In kernel 4.14, drivers/nvme/host/pci.c function nvme_isr doesn't  use
> > these registers.
> >
> > Any reason why these registers are not used in nvme interrupt handler ?
> 
> I think you've answered your own question: we process completions in the
> interrupt context. The interrupt is already masked at the CPU level in this
> context, so there should be no reason to mask them at the device level.
> 
> > Why NVMe driver is not using any bottom half and processing all
> > completion queues in interrupt handler ?
> 
> Performance.
Thanks keith. 
Currently driver isn't setting any Coalesce count.  
So the NVMe card will raise interrupt for every single completion queue ?

For legacy interrupt for each CQ 
CQ-> ASSERT_INTA-> DOORBELL-> DEASSERT_INTA is this flow correct ?

Is the following flow valid
CQ1->ASSERT_INTA->CQ2/CQ3->Doorbell->DEASSERT_INTA ?

When using legacy interrupts, if CQ1 is sent followed by ASSERT_INTA, can the EP send 
another CQ2,CQ3.. before DEASSERT_INTA of CQ1 is generated?

Regards,
Bharat
