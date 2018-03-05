From: keith.busch@intel.com (Keith Busch)
Date: Mon, 5 Mar 2018 13:42:12 -0700
Subject: [PATCH v2 07/10] nvme-pci: Use PCI p2pmem subsystem to manage
 the CMB
In-Reply-To: <20180305201053.GK11337@mellanox.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-8-logang@deltatee.com>
 <CAOSf1CEj1vmLLd27-642=XSnL9ODkpEC0qLHA2_W5_7rV5+4Pg@mail.gmail.com>
 <20180305160004.GA30975@localhost.localdomain>
 <36c78987-006a-a97f-1d18-b0a08cbea9d4@grimberg.me>
 <20180305201053.GK11337@mellanox.com>
Message-ID: <20180305204212.GD30975@localhost.localdomain>

On Mon, Mar 05, 2018@01:10:53PM -0700, Jason Gunthorpe wrote:
> So when reading the above mlx code, we see the first wmb() being used
> to ensure that CPU stores to cachable memory are visible to the DMA
> triggered by the doorbell ring.

IIUC, we don't need a similar barrier for NVMe to ensure memory is
visibile to DMA since the SQE memory is allocated DMA coherent when the
SQ is not within a CMB.
 
> The mmiowb() is used to ensure that DB writes are not combined and not
> issued in any order other than implied by the lock that encloses the
> whole thing. This is needed because uar_map is WC memory.
> 
> We don't have ordering with respect to two writel's here, so if ARM
> performance was a concern the writel could be switched to
> writel_relaxed().
> 
> Presumably nvme has similar requirments, although I guess the DB
> register is mapped UC not WC?

Yep, the NVMe DB register is required by the spec to be mapped UC.
