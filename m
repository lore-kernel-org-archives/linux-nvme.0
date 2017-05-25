From: keith.busch@intel.com (Keith Busch)
Date: Thu, 25 May 2017 06:21:57 -0400
Subject: [PATCH 3/3] nvme: only setup block integrity if supported by the
 driver
In-Reply-To: <20170520131445.16078-3-hch@lst.de>
References: <20170520131445.16078-1-hch@lst.de>
 <20170520131445.16078-3-hch@lst.de>
Message-ID: <20170525102157.GC24894@localhost.localdomain>

On Sat, May 20, 2017@03:14:45PM +0200, Christoph Hellwig wrote:
> Currently only the PCIe driver supports metadata, so we should not claim
> integrity support for the other drivers.  This prevents nasty crashes
> with targets that advertise metadata support on fabrics.
> 
> Also use the opportunity to factor out some code into a separate helper
> that isn't even compiled if CONFIG_BLK_DEV_INTEGRITY is disabled.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
