From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 26 Nov 2017 15:07:49 +0200
Subject: [PATCH v6 0/4] Fix request completion holes
In-Reply-To: <20171123153524.24554-1-sagi@grimberg.me>
References: <20171123153524.24554-1-sagi@grimberg.me>
Message-ID: <de66fc56-6f84-bc74-84cd-e434ac174e99@mellanox.com>



On 11/23/2017 5:35 PM, Sagi Grimberg wrote:
> We have two holes in nvme-rdma when completing request.
> 
> 1. We never wait for send work request to complete before completing
> a request. It is possible that the HCA retries a send operation (due
> to dropped ack) after the nvme cqe has already arrived back to the host.
> If we unmap the host buffer upon reception of the cqe, the HCA might
> get iommu errors when attempting to access an unmapped host buffer.
> We must wait also for the send completion before completing a request,
> most of the time it will be before the nvme cqe has arrived back so
> we pay only for the extra cq entry processing.
> 
> 2. We don't wait for the request memory region to be fully invalidated
> in case the target didn't invalidate remotely. We must wait for the local
> invalidation to complete before completing the request.
> 
> Note that we might face two concurrent completion processing contexts for
> a single request. One is the ib_cq irq-poll context and the second is
> blk_mq_poll which is invoked from IOCB_HIPRI requests. Thus we need the
> completion flags updates (send/receive) to be atomic. A new request
> lock is introduced to guarantee the mutual exclusion of the completion
> flags updates.
> 
> Thanks to Christoph for suggesting request refcounts instead of a private
> lock.

This series looks good to me (unfourtunatly the performance penalty is 
high, but we'll recover in upcoming patches - inline UMR and completion 
moderation)

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
