From: keith.busch@intel.com (Keith Busch)
Date: Tue, 25 Jul 2017 11:50:36 -0400
Subject: [PATCH] nvme-pci: fix HMB size calculation
In-Reply-To: <20170725154134.23338-1-hch@lst.de>
References: <20170725154134.23338-1-hch@lst.de>
Message-ID: <20170725155036.GE11979@localhost.localdomain>

On Tue, Jul 25, 2017@05:41:34PM +0200, Christoph Hellwig wrote:
> It's possible the preferred HMB size may not be a multiple of the
> chunk_size. This patch moves len to function scope and uses that in
> the for loop increment so the last iteration doesn't cause the total
> size to exceed the allocated HMB size.
> 
> Based on an earlier patch from Keith Busch.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reported-by: Dan Carpenter <dan.carpenter at oracle.com>
> Fixes: 87ad72a59a38 ("nvme-pci: implement host memory buffer support")

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
