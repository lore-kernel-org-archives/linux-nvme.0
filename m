From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 14 Dec 2018 11:06:04 -0800
Subject: [PATCH v4 0/6] restore nvme-rdma polling
Message-ID: <20181214190610.20086-1-sagi@grimberg.me>

Add an additional queue mapping for polling queues that will
host polling for latency critical I/O.

Allocate the poll queues with IB_POLL_DIRECT context. For nvmf connect
we introduce a new blk_execute_rq_polled to poll for the completion and
have nvmf_connect_io_queue use it for conneting polling queues.

Changes from v3:
- renamed nvme_rdma_poller_queue to nvme_rdma_poll_queue
- dropped explicit setting of QUEUE_FLAG_POLL in the connect_q
- report nr_maps=3 only if we got opts->nr_poll_queues
- dropped local cq variable from nvme_rdma_poll

Changes from v2:
- move blk_execute_rq_polled to nvme-core
- turn off REQ_HIPRI if polling is not supported (e.g. for stacking devices)
- omit nvme-cli patch - can be taken from v2
- removed blk_tag_to_qc_t and open-coded it in request_to_tag instead

Changes from v1:
- get rid of ib_change_cq_ctx
- poll for nvmf connect over poll queues

Christoph Hellwig (1):
  block: clear REQ_HIPRI if polling is not supported

Sagi Grimberg (5):
  block: make request_to_qc_t public
  nvme-core: optionally poll sync commands
  nvme-fabrics: allow nvmf_connect_io_queue to poll
  nvme-fabrics: allow user to pass in nr_poll_queues
  nvme-rdma: implement polling queue map

 block/blk-core.c            |  3 +++
 block/blk-mq.c              |  8 ------
 drivers/nvme/host/core.c    | 38 ++++++++++++++++++++++++----
 drivers/nvme/host/fabrics.c | 25 ++++++++++++++-----
 drivers/nvme/host/fabrics.h |  5 +++-
 drivers/nvme/host/fc.c      |  2 +-
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/rdma.c    | 49 ++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/tcp.c     |  2 +-
 drivers/nvme/target/loop.c  |  2 +-
 include/linux/blk-mq.h      | 10 ++++++++
 include/linux/blk_types.h   | 11 ---------
 12 files changed, 116 insertions(+), 41 deletions(-)

-- 
2.17.1
