From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 15:36:47 -0800
Subject: [PATCH RFC 0/4] restore polling to nvme-rdma
Message-ID: <20181211233652.9705-1-sagi@grimberg.me>

Add an additional queue mapping for polling queues that will
host polling for latency critical I/O.

One caveat is that we don't want these queues to be pure polling
as we don't want to bother with polling for the initial nvmf connect
I/O. Hence, introduce ib_change_cq_ctx that will modify the cq polling
context from SOFTIRQ to DIRECT. Note that this function is not safe
with inflight I/O so the caller must make sure not to call it without
having all I/O quiesced (we also relax the ib_cq_completion_direct warning
as we have a scenario that this can happen).

With that, we simply defer blk_poll callout to ib_process_cq_direct and
we're done. One thing that might worth adding is some kind of ignore
regexp of some sort because we don't want to give up polling because we
consumed memory registration completions. As for now, we might break the
polling early do to that.

Finally, we turn off polling support for nvme-multipath as it won't invoke
polling and our completion queues no longer generates any interrupts for
it. I didn't come up with a good way to get around it so far...

Sagi Grimberg (4):
  nvme-fabrics: allow user to pass in nr_poll_queues
  rdma: introduce ib_change_cq_ctx
  nvme-rdma: implement polling queue map
  nvme-multipath: disable polling for underlying namespace request queue

 drivers/infiniband/core/cq.c | 102 ++++++++++++++++++++++++-----------
 drivers/nvme/host/core.c     |   2 +
 drivers/nvme/host/fabrics.c  |  16 +++++-
 drivers/nvme/host/fabrics.h  |   3 ++
 drivers/nvme/host/rdma.c     |  35 +++++++++++-
 include/rdma/ib_verbs.h      |   1 +
 6 files changed, 124 insertions(+), 35 deletions(-)

-- 
2.17.1
