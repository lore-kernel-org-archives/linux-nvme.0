From: hch@lst.de (Christoph Hellwig)
Date: Wed, 1 Mar 2017 15:59:18 +0100
Subject: [PATCH] nvme-rdma: nvme-fc: Fix avoid tag set initialization
 twice.
In-Reply-To: <1488333999-30412-1-git-send-email-parav@mellanox.com>
References: <1488333999-30412-1-git-send-email-parav@mellanox.com>
Message-ID: <20170301145918.GA12248@lst.de>

On Tue, Feb 28, 2017@08:06:39PM -0600, Parav Pandit wrote:
> When BLK_MQ_F_NO_SCHED is not set for a tagset of a request queue,
> it tries to initialize the queue twice where blk_mq_alloc_rq_map() gets
> invoked twice as part of blk_mq_alloc_tag_set() and blk_mq_init_queue()
> through elevator init path.

Maybe we'll need to fix this in the block core instead of working around it?
