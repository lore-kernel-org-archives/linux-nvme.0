From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 Jun 2016 16:53:44 +0200
Subject: [PATCH] nvme-rdma: correctly stop keep alive on error path
In-Reply-To: <1465508227-14143-1-git-send-email-mlin@kernel.org>
References: <1465508227-14143-1-git-send-email-mlin@kernel.org>
Message-ID: <20160613145344.GC5863@lst.de>

On Thu, Jun 09, 2016@05:37:07PM -0400, Ming Lin wrote:
> From: Ming Lin <ming.l at samsung.com>
> 
> We didn't stop keep alive when blk_mq_alloc_tag_set() fails
> in nvme_rdma_create_io_queues().
> 
> This caused below hung when unloading nvme-rdma driver.

Thanks Ming,

applied for the next round of resends.
