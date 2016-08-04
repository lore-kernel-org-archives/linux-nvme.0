From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Aug 2016 13:51:31 +0200
Subject: [PATCH] nvme-rdma: start async event handler after
 reconnecting to a controller
In-Reply-To: <1470307876-18451-1-git-send-email-sagi@grimberg.me>
References: <1470307876-18451-1-git-send-email-sagi@grimberg.me>
Message-ID: <20160804115131.GD32487@lst.de>

On Thu, Aug 04, 2016@01:51:16PM +0300, Sagi Grimberg wrote:
> When we reset or reconnect to a controller, we are cancelling the
> async event handler so we can safely re-establish resources, but we
> need to remember to start it again when we successfully reconnect.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>

We'll also need an equivalent for the loop driver I think.
