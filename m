From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 20 Nov 2017 13:30:57 +0200
Subject: [PATCH v4 0/4] Fix request completion holes
Message-ID: <20171120113101.8292-1-sagi@grimberg.me>

We have two holes in nvme-rdma when completing request.

1. We never wait for send work request to complete before completing
a request. It is possible that the HCA retries a send operation (due
to dropped ack) after the nvme cqe has already arrived back to the host.
If we unmap the host buffer upon reception of the cqe, the HCA might
get iommu errors when attempting to access an unmapped host buffer.
We must wait also for the send completion before completing a request,
most of the time it will be before the nvme cqe has arrived back so
we pay only for the extra cq entry processing.

2. We don't wait for the request memory region to be fully invalidated
in case the target didn't invalidate remotely. We must wait for the local
invalidation to complete before completing the request.

Note that we might face two concurrent completion processing contexts for
a single request. One is the ib_cq irq-poll context and the second is
blk_mq_poll which is invoked from IOCB_HIPRI requests. Thus we need the
completion flags updates (send/receive) to be atomic. A new request
lock is introduced to guarantee the mutual exclusion of the completion
flags updates.

Thanks to Christoph for suggesting request refcounts instead of a private
lock.


Changes from v3:
- Added a patch for detecting bogus remote invalidation (while we're in the area)
- Saved a third atomic op for local invalidate (Christoph)
- pull the status and result from nvme cqe to nvme_rdma_request

Changes from v2:
- Fixed send completion signalling in patch 1 (still signal conditionally
  as we still want to suppress it for async events)
- replaced req->lock with req->ref for micro-optimization (Christoph)

Changes from v1:
- Added atomic send/resp_completed updated (via per-request lock)

Sagi Grimberg (4):
  nvme-rdma: don't suppress send completions
  nvme-rdma: don't complete requests before a send work request has
    completed
  nvme-rdma: wait for local invalidation before completing a request
  nvme-rdma: Check remotely invalidated rkey matches our expected rkey

 drivers/nvme/host/rdma.c | 118 +++++++++++++++++++++++++----------------------
 1 file changed, 62 insertions(+), 56 deletions(-)

-- 
2.14.1
