From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 12 Dec 2018 22:38:12 -0800
Subject: [PATCH v2 0/6] restore nvme-rdma polling
Message-ID: <20181213063819.13614-1-sagi@grimberg.me>

Add an additional queue mapping for polling queues that will
host polling for latency critical I/O.

Allocate the poll queues with IB_POLL_DIRECT context. For nvmf connect
we introduce a new blk_execute_rq_polled to poll for the completion and
have nvmf_connect_io_queue use it for conneting polling queues.

Finally, we turn off polling support for nvme-multipath as it won't invoke
polling and our completion queues no longer generates any interrupts for
it. I didn't come up with a good way to get around it so far...

Changes from v1:
- get rid of ib_change_cq_ctx
- poll for nvmf connect over poll queues

Sagi Grimberg (6):
  block: introduce blk_execute_rq_polled
  nvme-core: allow __nvme_submit_sync_cmd to poll
  nvme-fabrics: allow nvmf_connect_io_queue to poll
  nvme-fabrics: allow user to pass in nr_poll_queues
  nvme-rdma: implement polling queue map
  nvme-multipath: disable polling for underlying namespace request queue

 block/blk-exec.c            | 29 +++++++++++++++++++
 block/blk-mq.c              |  8 -----
 drivers/nvme/host/core.c    | 15 ++++++----
 drivers/nvme/host/fabrics.c | 25 ++++++++++++----
 drivers/nvme/host/fabrics.h |  5 +++-
 drivers/nvme/host/fc.c      |  2 +-
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/rdma.c    | 58 +++++++++++++++++++++++++++++++++----
 drivers/nvme/host/tcp.c     |  2 +-
 drivers/nvme/target/loop.c  |  2 +-
 include/linux/blk-mq.h      |  8 +++++
 include/linux/blkdev.h      |  2 ++
 12 files changed, 128 insertions(+), 30 deletions(-)

-- 
2.17.1
