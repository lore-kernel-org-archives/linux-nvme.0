From: dledford@redhat.com (Doug Ledford)
Date: Mon, 13 Nov 2017 17:10:44 -0500
Subject: [PATCH v2 0/3] Fix request completion holes
In-Reply-To: <20171108100616.26605-1-sagi@grimberg.me>
References: <20171108100616.26605-1-sagi@grimberg.me>
Message-ID: <1510611044.3735.49.camel@redhat.com>

On Wed, 2017-11-08@12:06 +0200, Sagi Grimberg wrote:
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
> Note that we could have used a per-queue lock for these updates (which
> would have generated less locks as we have less queues), but given that
> we access the request in the completion handlers we might benefit by having
> the lock local in the request. I'm open to suggestions though.
> 
> Changes from v1:
> - Added atomic send/resp_completed updated (via per-request lock)
> 
> Sagi Grimberg (3):
>   nvme-rdma: don't suppress send completions
>   nvme-rdma: don't complete requests before a send work request has
>     completed
>   nvme-rdma: wait for local invalidation before completing a request
> 
>  drivers/nvme/host/rdma.c | 125 ++++++++++++++++++++++++++---------------------
>  1 file changed, 70 insertions(+), 55 deletions(-)
> 

Sagi, are you ready for me to take this series in?  It seemed like there
was a question as to whether you might want to try atomics instead of
spin locks, or do you want to stick with spinlocks?

-- 
Doug Ledford <dledford at redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171113/72fd8cc4/attachment.sig>
