From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 8 Apr 2018 18:31:26 +0300
Subject: [PATCH 2/2 V2] nvme-rdma: Fix race at error recovery
In-Reply-To: <1523196519-23268-3-git-send-email-israelr@mellanox.com>
References: <1523196519-23268-1-git-send-email-israelr@mellanox.com>
 <1523196519-23268-3-git-send-email-israelr@mellanox.com>
Message-ID: <3632b646-7836-c1d6-26b6-c0fdf03080f4@grimberg.me>


> We need to stop rdma queues before canceling the requests.
> With this approach we avoid the race between error recovery work
> and rdma completions.
> The commit fix a NULL deref of a request MR at nvme_rdma_process_nvme_rsp().

What race? nvme_rdma_stop_queue() has two goals:
1. prevent new posts on the rdma qp
2. drain all inflight posts

"With this approach we avoid the race between error recovery work
  and rdma completions" is not sufficient (to put it politely).

The original post of this patch was designed to prevent the
device from performing DMA to/from user buffers which might have
been already completed by nvme_cancel_request.
