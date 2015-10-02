From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Oct 2015 21:13:22 +0000 (UTC)
Subject: [PATCH 1/7] nvme: delete dev from dev_list in nvme_reset
In-Reply-To: <1443808699-4738-2-git-send-email-hch@lst.de>
References: <1443808699-4738-1-git-send-email-hch@lst.de>
 <1443808699-4738-2-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1510022041060.23840@localhost.lm.intel.com>

On Fri, 2 Oct 2015, Christoph Hellwig wrote:
> Device resets need to delete the device from the device list before
> kicking of the reset an re-probe, otherwise we get the device added
> to the list twice.  nvme_reset is the only side missing this deletion
> at the moment, and this patch adds it.

A moment of panic when I saw this, but we're 'ok'. The reset handler calls
nvme_dev_shutdown() first, and that removes the device from the list,
so we won't really see a controller twice added in the list.

Still, there's no reason to poll a device that's about to reset, so it's
a good change.

Reviewed-by: Keith Busch <keith.busch at intel.com>
