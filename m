From: keith.busch@intel.com (Keith Busch)
Date: Wed, 6 Sep 2017 17:49:09 -0400
Subject: [PATCH 3/4] nvme-pci: propagate (some) errors from host memory
 buffer setup
In-Reply-To: <20170906135532.21358-4-hch@lst.de>
References: <20170906135532.21358-1-hch@lst.de>
 <20170906135532.21358-4-hch@lst.de>
Message-ID: <20170906214909.GI17331@localhost.localdomain>

On Wed, Sep 06, 2017@03:55:31PM +0200, Christoph Hellwig wrote:
> We want to catch command execution errors when resetting the device, so
> propagate errors from the Set Features when setting up the host memory
> buffer.  We keep ignoring memory allocation failures, as the spec
> clearly says that the controller must work without a host memory buffer.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Cc: stable at vger.kernel.org

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
