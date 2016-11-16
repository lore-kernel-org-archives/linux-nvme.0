From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 Nov 2016 18:08:55 +0100
Subject: [PATCH] nvme/pci: Don't free queues on error
In-Reply-To: <1479243386-4383-1-git-send-email-keith.busch@intel.com>
References: <1479243386-4383-1-git-send-email-keith.busch@intel.com>
Message-ID: <20161116170855.GB5005@lst.de>

On Tue, Nov 15, 2016@03:56:26PM -0500, Keith Busch wrote:
> The nvme_remove function tears down all allocated resources in the correct
> order, so no need to free queues on error during initialization. This
> fixes possible use-after-free errors when queues are still associated
> with a blk-mq hctx.
> 
> Reported-by: Scott Bauer <scott.bauer at intel.com>
> Tested-by: Scott Bauer <scott.bauer at intel.com>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>

should this get a Cc to stable?
