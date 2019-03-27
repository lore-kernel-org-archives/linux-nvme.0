From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 27 Mar 2019 10:06:09 +0800
Subject: [PATCH 0/2] blk-mq/nvme: cancel request synchronously
In-Reply-To: <20190318032950.17770-1-ming.lei@redhat.com>
References: <20190318032950.17770-1-ming.lei@redhat.com>
Message-ID: <20190327020608.GB4882@ming.t460p>

On Mon, Mar 18, 2019@11:29:48AM +0800, Ming Lei wrote:
> Hi,
> 
> This patchset introduces blk_mq_complete_request_sync() for canceling
> request synchronously in error handler context, then one race between
> completing request and destroying contoller/queues can be fixed.
> 
> 
> Ming Lei (2):
>   blk-mq: introduce blk_mq_complete_request_sync()
>   nvme: cancel request synchronously
> 
>  block/blk-mq.c           | 20 ++++++++++++++++----
>  drivers/nvme/host/core.c |  2 +-
>  include/linux/blk-mq.h   |  1 +
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: linux-nvme at lists.infradead.org
> 
> -- 
> 2.9.5
> 

Hi Jens and Christoph,

This two simple patches do fix kernel oops in the "Link flap / Failover
testing an NVMe over RDMA connection" from our customer.

Looks no one objects this fix, could you consider them for v5.1 if you
are fine?

Thanks,
Ming
