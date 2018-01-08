From: jgg@ziepe.ca (Jason Gunthorpe)
Date: Mon, 8 Jan 2018 12:49:50 -0700
Subject: [PATCH 06/12] IB/core: Add optional PCI P2P flag to
 rdma_rw_ctx_[init|destroy]()
In-Reply-To: <20180108185743.GA15936@lst.de>
References: <20180104192225.GS11348@ziepe.ca>
 <1f8fb3fb-e3dc-94d3-e837-0cd942cf5b87@deltatee.com>
 <20180104221337.GV11348@ziepe.ca>
 <3e8391a9-8924-be6d-8c43-162a360d75b6@deltatee.com>
 <20180105045031.GX11348@ziepe.ca> <20180108145901.GA10743@lst.de>
 <20180108180917.GF11348@ziepe.ca> <20180108183434.GA15549@lst.de>
 <cffacbee-477a-fbe9-19cc-373cd2ec6fef@deltatee.com>
 <20180108185743.GA15936@lst.de>
Message-ID: <20180108194950.GK11348@ziepe.ca>

On Mon, Jan 8, 2018@11:57 AM, Christoph Hellwig <hch@lst.de> wrote:

>> (c) setup/manage any security permissions on mappings
>> Which P2P may at some point be concerned with.
>
> Maybe once root complexes with iommus actually support P2P.  But until
> then we have a lot more more important problems to solve.

Pretty sure P2P capable IOMMU hardware exists.

With SOC's we also have the scenario that an DMA originated from an
on-die device wishes to target an off-die PCI BAR (through the IOMMU),
that definitely exists today, and people care about it :)

Jason
