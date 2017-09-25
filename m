From: keith.busch@intel.com (Keith Busch)
Date: Mon, 25 Sep 2017 10:19:09 -0600
Subject: [PATCH 9/9] nvme: also expose the namespace identification sysfs
 files for mpath nodes
In-Reply-To: <20170925134031.10548-10-hch@lst.de>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-10-hch@lst.de>
Message-ID: <20170925161908.GE8463@localhost.localdomain>

On Mon, Sep 25, 2017@03:40:31PM +0200, Christoph Hellwig wrote:
> We do this by adding a helper that returns the ns_head for a device that
> can belong to either the per-controller or per-subsystem block device
> nodes, and otherwise reuse all the existing code.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
