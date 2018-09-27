From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 27 Sep 2018 11:12:30 -0600
Subject: [PATCH v8 13/13] nvmet: Optionally use PCI P2P memory
In-Reply-To: <20180927165420.5290-14-logang@deltatee.com>
References: <20180927165420.5290-1-logang@deltatee.com>
 <20180927165420.5290-14-logang@deltatee.com>
Message-ID: <20180927171230.GE19589@localhost.localdomain>

On Thu, Sep 27, 2018@10:54:20AM -0600, Logan Gunthorpe wrote:
> We create a configfs attribute in each nvme-fabrics target port to
> enable p2p memory use. When enabled, the port will only then use the
> p2p memory if a p2p memory device can be found which is behind the
> same switch hierarchy as the RDMA port and all the block devices in
> use. If the user enabled it and no devices are found, then the system
> will silently fall back on using regular memory.
> 
> If appropriate, that port will allocate memory for the RDMA buffers
> for queues from the p2pmem device falling back to system memory should
> anything fail.
> 
> Ideally, we'd want to use an NVME CMB buffer as p2p memory. This would
> save an extra PCI transfer as the NVME card could just take the data
> out of it's own memory. However, at this time, only a limited number
> of cards with CMB buffers seem to be available.
> 
> Signed-off-by: Stephen Bates <sbates at raithlin.com>
> Signed-off-by: Steve Wise <swise at opengridcomputing.com>
> [hch: partial rewrite of the initial code]
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>

I haven't the necessary hardware to try this out, but looking forward
to it in the future. Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
