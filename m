From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Mon, 13 May 2019 18:01:39 +0000
Subject: [PATCH] nvme/pci: Use host managed power state for suspend
In-Reply-To: <20190513145708.GA25897@lst.de>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143754.GE15318@localhost.localdomain>
 <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM>
 <20190513145708.GA25897@lst.de>
Message-ID: <df020e90e8b54244b37910a2a7965671@AUSX13MPC105.AMER.DELL.COM>



> -----Original Message-----
> From: Christoph Hellwig <hch at lst.de>
> Sent: Monday, May 13, 2019 9:57 AM
> To: Limonciello, Mario
> Cc: kbusch at kernel.org; keith.busch at intel.com; hch at lst.de; sagi at grimberg.me;
> linux-nvme at lists.infradead.org; rafael at kernel.org; linux-kernel at vger.kernel.org;
> linux-pm at vger.kernel.org; kai.heng.feng at canonical.com
> Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
> 
> 
> [EXTERNAL EMAIL]
> 
> On Mon, May 13, 2019@02:54:49PM +0000, Mario.Limonciello@dell.com wrote:
> > The Intel DMA controller suspend callbacks in drivers/dma/idma64.c look to me
> to
> > turn off the controller.
> 
> How is that relevant?  That thing is neither a NVMe controller, nor
> even an PCIe device..

When using HMB the SSD will be writing to some memory mapped region.  Writing to
that region would use DMA to access host memory, no?
If the DMA controller is not functional writing to that region won't work properly as 
it can't access that memory.

> 
> > And NVME spec made it sound to me that while in a low power state it shouldn't
> > be available if the memory isn't available.
> >
> > NVME spec in 8.9:
> >
> > "Host software should request that the controller release the
> > assigned ranges prior to a shutdown event, a Runtime D3 event, or any other
> event
> > that requires host software to reclaim the assigned ranges."
> 
> The last part of the quoted text is the key - if the assigned range
> is reclaimed, that is the memory is going to be used for something else,
> we need to release the ranges.  But we do not release the ranges,
> as we want to keep the memory in use so that we can quickly use it
> again.
