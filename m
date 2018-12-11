From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 02:49:30 -0800
Subject: [PATCH 0/5] implement nvmf read/write queue maps
Message-ID: <20181211104936.25333-1-sagi@grimberg.me>

This set implements read/write queue maps to nvmf (implemented in tcp
and rdma). We basically allow the users to pass in nr_write_queues
argument that will basically maps a separate set of queues to host
write I/O (or more correctly non-read I/O) and a set of queues to
hold read I/O (which is now controlled by the known nr_io_queues).

A patchset that restores nvme-rdma polling is in the pipe.
The polling is less trivial because:
1. we can find non I/O completions in the cq (i.e. memreg)
2. we need to start with non-polling for a sane connect and
   then switch to polling which is not trivial behind the
   cq API we use.

Note that read/write separation for rdma but especially tcp this can be
very clear win as we minimize the risk for head-of-queue blocking for
mixed workloads over a single tcp byte stream.

Sagi Grimberg (5):
  blk-mq-rdma: pass in queue map to blk_mq_rdma_map_queues
  nvme-fabrics: add missing nvmf_ctrl_options documentation
  nvme-fabrics: allow user to set nr_write_queues for separate queue
    maps
  nvme-tcp: support separate queue maps for read and write
  nvme-rdma: support read/write queue separation

 block/blk-mq-rdma.c         |  8 +++---
 drivers/nvme/host/fabrics.c | 15 ++++++++++-
 drivers/nvme/host/fabrics.h |  6 +++++
 drivers/nvme/host/rdma.c    | 39 ++++++++++++++++++++++++---
 drivers/nvme/host/tcp.c     | 53 ++++++++++++++++++++++++++++++++-----
 include/linux/blk-mq-rdma.h |  2 +-
 6 files changed, 108 insertions(+), 15 deletions(-)

-- 
2.17.1
