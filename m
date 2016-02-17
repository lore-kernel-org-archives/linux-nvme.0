From: keith.busch@intel.com (Keith Busch)
Date: Wed, 17 Feb 2016 18:44:01 +0000
Subject: [PATCH 2/3] nvme: don't poll the CQ from the kthread
In-Reply-To: <1455732194-30790-3-git-send-email-hch@lst.de>
References: <1455732194-30790-1-git-send-email-hch@lst.de>
 <1455732194-30790-3-git-send-email-hch@lst.de>
Message-ID: <20160217184400.GD30059@localhost.localdomain>

On Wed, Feb 17, 2016@07:03:13PM +0100, Christoph Hellwig wrote:
> There is no reason to do unconditional polling of CQs per the NVMe
> spec.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good. Now we'll find out if anyone was unknowingly relying on
this. :)

The legacy IRQ used for the very first NVMe command after reset tripped
up some devices in the past, but the polling hid the breakage.

Reviewed-by: Keith Busch <keith.busch at intel.com>
