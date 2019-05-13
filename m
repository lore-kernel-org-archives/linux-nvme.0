From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Mon, 13 May 2019 14:54:49 +0000
Subject: [PATCH] nvme/pci: Use host managed power state for suspend
In-Reply-To: <20190513143754.GE15318@localhost.localdomain>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <0080aaff18e5445dabca509d4113eca8@AUSX13MPC105.AMER.DELL.COM>
 <955722d8fc16425dbba0698c4806f8fd@AUSX13MPC105.AMER.DELL.COM>
 <20190513143754.GE15318@localhost.localdomain>
Message-ID: <7ab8274ef1ce46fcae54a50abc76ae4a@AUSX13MPC105.AMER.DELL.COM>

> -----Original Message-----
> From: Keith Busch <kbusch at kernel.org>
> Sent: Monday, May 13, 2019 9:38 AM
> To: Limonciello, Mario
> Cc: keith.busch at intel.com; hch at lst.de; sagi at grimberg.me; linux-
> nvme at lists.infradead.org; rafael at kernel.org; linux-kernel at vger.kernel.org; linux-
> pm at vger.kernel.org; kai.heng.feng at canonical.com
> Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
> 
> 
> [EXTERNAL EMAIL]
> 
> On Mon, May 13, 2019@02:24:41PM +0000, Mario.Limonciello@dell.com wrote:
> > This was not a disk with HMB, but with regard to the HMB I believe it needs to be
> > removed during s0ix so that there isn't any mistake that SSD thinks it can access
> HMB
> > memory in s0ix.
> 
> Is that really the case, though? Where may I find that DMA is not
> allowed in this state? I just want an authoritative reference to attach
> to the behavior.

The Intel DMA controller suspend callbacks in drivers/dma/idma64.c look to me to
turn off the controller.

And NVME spec made it sound to me that while in a low power state it shouldn't
be available if the memory isn't available.

NVME spec in 8.9:

"Host software should request that the controller release the
assigned ranges prior to a shutdown event, a Runtime D3 event, or any other event
that requires host software to reclaim the assigned ranges."
