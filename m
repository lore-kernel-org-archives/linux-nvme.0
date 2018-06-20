From: hch@lst.de (Christoph Hellwig)
Date: Wed, 20 Jun 2018 10:31:59 +0200
Subject: [PATCH 2/7] nvme-rdma: fix possible free non-allocated async
 event buffer
In-Reply-To: <20180619123415.25077-3-sagi@grimberg.me>
References: <20180619123415.25077-1-sagi@grimberg.me>
 <20180619123415.25077-3-sagi@grimberg.me>
Message-ID: <20180620083159.GB3284@lst.de>

On Tue, Jun 19, 2018@03:34:10PM +0300, Sagi Grimberg wrote:
> If nvme_rdma_configure_admin_queue fails before we allocated
> the async event buffer, we will falsly free it because nvme_rdma_free_queue
> is freeing it. Fix it by allocating the buffer right after nvme_rdma_alloc_queue
> and free it right before nvme_rdma_queue_free to maintain orderly reverse cleanup
> sequence.

This looks much nicer indeed.
