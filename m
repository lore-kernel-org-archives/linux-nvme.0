From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Nov 2017 10:38:19 +0100
Subject: [PATCH 1/1] nvme-rdma: Fix memory leak during queue allocation
In-Reply-To: <1510146032-25434-1-git-send-email-maxg@mellanox.com>
References: <1510146032-25434-1-git-send-email-maxg@mellanox.com>
Message-ID: <20171109093813.GA17515@lst.de>

On Wed, Nov 08, 2017@03:00:32PM +0200, Max Gurtovoy wrote:
> In case nvme_rdma_wait_for_cm timeout expires before we get
> an established or rejected event (rdma_connect succeeded) from
> rdma_cm, we end up with leaking the ib resources for dedicated
> queue.
> This scenario can easily reproduced using traffic test during port
> toggling.
> 
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>

Looks fine. but a little comment on the special casing of
-ETIMEDOUT would be nice.
