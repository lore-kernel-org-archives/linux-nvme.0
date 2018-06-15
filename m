From: hch@lst.de (Christoph Hellwig)
Date: Fri, 15 Jun 2018 10:01:54 +0200
Subject: [PATCH] nvme: Fix error flow at nvme_rdma_configure_admin_queue()
In-Reply-To: <1528979864-3109-1-git-send-email-israelr@mellanox.com>
References: <1528979864-3109-1-git-send-email-israelr@mellanox.com>
Message-ID: <20180615080154.GA19525@lst.de>

On Thu, Jun 14, 2018@12:37:44PM +0000, Israel Rukshin wrote:
> On error calling to nvme_rdma_free_queue() with admin queue
> frees the QE before it was allocated.
> 
> Signed-off-by: Israel Rukshin <israelr at mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>

This certainly matches what we do in nvme_rdma_free_queue, but it
looks like a little too much special casing vodoo to me.

The nvme_rdma_free_queue was added by Sagi last October to fix
a reconnect double free.  But I wonder if we just need to move it
back instead and have a different double free protection.  E.g.
in nvme_rdma_free_qe just check if qe->data is set first,
and the NULL it out when freeing.
