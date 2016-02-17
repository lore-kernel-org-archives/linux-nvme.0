From: keith.busch@intel.com (Keith Busch)
Date: Wed, 17 Feb 2016 18:44:19 +0000
Subject: [PATCH 3/3] nvme: replace the kthread with a per-device
 watchdog timer
In-Reply-To: <1455732194-30790-4-git-send-email-hch@lst.de>
References: <1455732194-30790-1-git-send-email-hch@lst.de>
 <1455732194-30790-4-git-send-email-hch@lst.de>
Message-ID: <20160217184418.GE30059@localhost.localdomain>

On Wed, Feb 17, 2016@07:03:14PM +0100, Christoph Hellwig wrote:
> The only work left in the kthread is the periodic health check for each
> controller.  There is no need to run this from process context or keep
> a thread context around for it, so replace it with a simpler timer.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
