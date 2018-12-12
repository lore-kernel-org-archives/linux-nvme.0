From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 23:38:53 -0800
Subject: [PATCH v3 0/5] implement nvmf read/write queue maps
Message-ID: <20181212073858.7102-1-sagi@grimberg.me>

This set implements read/write queue maps to nvmf (implemented in tcp
and rdma). We basically allow the users to pass in nr_write_queues
argument that will basically maps a separate set of queues to host
write I/O (or more correctly non-read I/O) and a set of queues to
hold read I/O (which is now controlled by the known nr_io_queues).

Note that read/write separation is a clear win for rdma but especially
for tcp as we minimize the risk for head-of-queue blocking for
mixed workloads over a single stream.

Changes from v2:
- moved NVMF_OPT_NR_WRITE_QUEUES from NVMF_ALLOWED_OPTS to the individual
  drivers
- removed obfuscated expression
- omitted nvme-cli patch (can be taken from v1)
- collected review tags

Changes from v1:
- simplified map_queues in nvme-tcp and nvme-rdma
- improved change logs
- collected review tags
- added nr-write-queues entry in nvme-cli docuementation

Sagi Grimberg (5):
  blk-mq-rdma: pass in queue map to blk_mq_rdma_map_queues
  nvme-fabrics: add missing nvmf_ctrl_options documentation
  nvme-fabrics: allow user to set nr_write_queues for separate queue
    maps
  nvme-tcp: support separate queue maps for read and write
  nvme-rdma: support separate queue maps for read and write

 block/blk-mq-rdma.c         |  8 +++----
 drivers/nvme/host/fabrics.c | 13 +++++++++++
 drivers/nvme/host/fabrics.h |  6 +++++
 drivers/nvme/host/rdma.c    | 28 ++++++++++++++++++++---
 drivers/nvme/host/tcp.c     | 44 ++++++++++++++++++++++++++++++++-----
 include/linux/blk-mq-rdma.h |  2 +-
 6 files changed, 87 insertions(+), 14 deletions(-)

-- 
2.17.1
