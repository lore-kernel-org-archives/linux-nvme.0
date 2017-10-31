From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 31 Oct 2017 10:55:19 +0200
Subject: [PATCH 0/3] Fix request completion holes
Message-ID: <1509440122-1190-1-git-send-email-sagi@grimberg.me>

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

Sagi Grimberg (3):
  nvme-rdma: don't suppress send completions
  nvme-rdma: don't complete requests before a send work request has
    completed
  nvme-rdma: wait for local invalidation before completing a request

 drivers/nvme/host/rdma.c | 101 +++++++++++++++++++++++------------------------
 1 file changed, 50 insertions(+), 51 deletions(-)

-- 
2.7.4
