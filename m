From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Oct 2015 21:36:26 +0000 (UTC)
Subject: [PATCH 6/7] nvme: properly handle partially initialized queues
 in nvme_create_io_queues
In-Reply-To: <1443808699-4738-7-git-send-email-hch@lst.de>
References: <1443808699-4738-1-git-send-email-hch@lst.de>
 <1443808699-4738-7-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1510022129280.23840@localhost.lm.intel.com>

On Fri, 2 Oct 2015, Christoph Hellwig wrote:
> This avoids having to clean up later in a seemingly unrelated place.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Somewhat related to this area of code but not a new concern, I think we're
in trouble if the controller resets after we have active request_queue,
but controller allows fewer IO queues than originally configured with
the blk-mq tagset. On the other hand, we don't have a way to provide
additional IO queues to the tagset after a reset either, so I think we
need a new blk-mq API to notify it of changes to number of h/w contexts.

This part looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
