From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 12 Jun 2017 10:42:58 -0600
Subject: [PATCH] nvme-rdma: fix merge error
In-Reply-To: <20170612162606.18907-1-hch@lst.de>
References: <20170612162606.18907-1-hch@lst.de>
Message-ID: <18d3fc3a-6e9d-64e9-bb49-cbe0247d7068@kernel.dk>

On 06/12/2017 10:26 AM, Christoph Hellwig wrote:
> The merge of 4.12-rc5 into the for-4.13/block tree didn't handle the queue
> ready case correctly.  Fix this by propagating blk_status_t into
> nvme_rdma_queue_is_ready.

Thanks, added.

-- 
Jens Axboe
