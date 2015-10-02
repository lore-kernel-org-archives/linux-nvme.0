From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Oct 2015 21:54:20 +0000 (UTC)
Subject: [PATCH 7/7] nvme: remove failed controllers directly from
 probe/reset context
In-Reply-To: <1443808699-4738-8-git-send-email-hch@lst.de>
References: <1443808699-4738-1-git-send-email-hch@lst.de>
 <1443808699-4738-8-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1510022146590.23840@localhost.lm.intel.com>

On Fri, 2 Oct 2015, Christoph Hellwig wrote:
> Now that all probing and resets happen from workqueue context we can remove
> the controller directly without any risk of deadlocking.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

I don't know about this one. If you call pci_stop_and_remove_bus_device(),
that will get to the driver's ->remove() callback in the same context. The
first thing this driver does is flush the probe and reset work, and
I don't think a work queue can flush itself.
