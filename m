From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Jan 2018 17:47:47 +0100
Subject: [PATCH 06/12] IB/core: Add optional PCI P2P flag to
 rdma_rw_ctx_[init|destroy]()
In-Reply-To: <7d276107-d2ae-530b-3d56-e104e22b4eea@deltatee.com>
References: <1f8fb3fb-e3dc-94d3-e837-0cd942cf5b87@deltatee.com>
 <20180104221337.GV11348@ziepe.ca>
 <3e8391a9-8924-be6d-8c43-162a360d75b6@deltatee.com>
 <20180105045031.GX11348@ziepe.ca> <20180108145901.GA10743@lst.de>
 <20180108180917.GF11348@ziepe.ca> <20180108183434.GA15549@lst.de>
 <cffacbee-477a-fbe9-19cc-373cd2ec6fef@deltatee.com>
 <20180108185743.GA15936@lst.de>
 <7d276107-d2ae-530b-3d56-e104e22b4eea@deltatee.com>
Message-ID: <20180109164747.GB12159@lst.de>

On Mon, Jan 08, 2018@12:05:57PM -0700, Logan Gunthorpe wrote:
> Ok, so if we shouldn't touch the dma_map infrastructure how should the 
> workaround to opt-out HFI and QIB look? I'm not that familiar with the RDMA 
> code.

We can add a no_p2p quirk, I'm just not sure what the right place
for it is.  As said they device don't really mind P2P at the PCIe
level, it's just that their RDMA implementation is really strange.

So I'd be tempted to do it in RDMA.
