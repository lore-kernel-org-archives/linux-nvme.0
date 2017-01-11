From: hch@lst.de (hch@lst.de)
Date: Wed, 11 Jan 2017 10:06:11 +0100
Subject: phys_addr_t instead of dma_addr_t for nvme_dev->cmb_dma_addr
In-Reply-To: <1484122522.26936.9.camel@mellanox.com>
References: <1d5efe82-0654-3217-ffde-fb6ad499170a@mellanox.com>
 <1ce2030c-d31f-0ad4-02db-410abfc87c06@mellanox.com>
 <20170105183933.GA4724@localhost.localdomain>
 <0846672a-484d-ab80-aa1c-751042405f29@mellanox.com>
 <20170109215422.GA5286@localhost.localdomain>
 <1484122522.26936.9.camel@mellanox.com>
Message-ID: <20170111090611.GC7350@lst.de>

On Wed, Jan 11, 2017@08:15:23AM +0000, Haggai Eran wrote:
> If the BAR is smaller than (offset + size) then any address that is
> outside the BAR must be treated by the device as if it is not in the
> CMB (otherwise some other devices / host memory will simply be
> inaccessible by the NVMe device).?

Yes.  I so wish the CMB design wasn't so messed up and we'd just have
a separate BAR with a relative index for it.  Maybe we'll need to
propose a CMBv2 in the working group, at least for the proposed new
extensions :)

> > I think this would only happen if we're behind a bridge with a
> > smaller
> > window than BAR.
> 
> I'm pretty sure that the bridge window must contain the underlying
> device BARs. If it can't contain them, they can be simply left
> disabled.

Exactly.

> I'm not talking about DMA translation. I'm talking about MMIO
> translation. From what I understand this can happen on POWER systems.
> The physical addresses for MMIO that are used by the CPU are different
> from the ones that are used on the PCIe bus.

As far as I know MMIO translation is absolutely usual for IOMMUs.
That being said my knowledge of IOMMUs is mostly form before Intel
and AMD chipset added them and thus from the RISC/IA64 world.
