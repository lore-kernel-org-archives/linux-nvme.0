From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Jan 2018 17:46:40 +0100
Subject: [PATCH 06/12] IB/core: Add optional PCI P2P flag to
 rdma_rw_ctx_[init|destroy]()
In-Reply-To: <20180108194950.GK11348@ziepe.ca>
References: <1f8fb3fb-e3dc-94d3-e837-0cd942cf5b87@deltatee.com>
 <20180104221337.GV11348@ziepe.ca>
 <3e8391a9-8924-be6d-8c43-162a360d75b6@deltatee.com>
 <20180105045031.GX11348@ziepe.ca> <20180108145901.GA10743@lst.de>
 <20180108180917.GF11348@ziepe.ca> <20180108183434.GA15549@lst.de>
 <cffacbee-477a-fbe9-19cc-373cd2ec6fef@deltatee.com>
 <20180108185743.GA15936@lst.de> <20180108194950.GK11348@ziepe.ca>
Message-ID: <20180109164640.GA12159@lst.de>

On Mon, Jan 08, 2018@12:49:50PM -0700, Jason Gunthorpe wrote:
> Pretty sure P2P capable IOMMU hardware exists.
> 
> With SOC's we also have the scenario that an DMA originated from an
> on-die device wishes to target an off-die PCI BAR (through the IOMMU),
> that definitely exists today, and people care about it :)

Then people will have to help and contribute support for it.
