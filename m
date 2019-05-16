From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 13:02:02 -0600
Subject: [PATCH 3/4] nvme: merge nvme_ns_ioctl into nvme_ioctl
In-Reply-To: <20190516185036.17394-3-hch@lst.de>
References: <20190516185036.17394-1-hch@lst.de>
 <20190516185036.17394-3-hch@lst.de>
Message-ID: <20190516190202.GC23669@localhost.localdomain>

On Thu, May 16, 2019@08:50:35PM +0200, Christoph Hellwig wrote:
> Merge the two functions to make future changes a little easier.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
