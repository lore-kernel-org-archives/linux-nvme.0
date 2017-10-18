From: israelr@mellanox.com (Israel Rukshin)
Date: Wed, 18 Oct 2017 12:38:23 +0000
Subject: [PATCH 0/3] Add BLK_MQ_F_NO_SCHED flag to admin tag set
Message-ID: <1508330306-26844-1-git-send-email-israelr@mellanox.com>

Since commit b86dd81
"block: get rid of blk-mq default scheduler choice Kconfig entries",
when setting nr_hw_queues to 1 the admin tag set uses mq-deadline scheduler.
This flag is useful for admin queues that aren't used for normal IO.
We already use this flag at nvme-pci.

Israel Rukshin (3):
  nvme-rdma: Add BLK_MQ_F_NO_SCHED flag to admin tag set
  nvme-fc: Add BLK_MQ_F_NO_SCHED flag to admin tag set
  nvme-loop: Add BLK_MQ_F_NO_SCHED flag to admin tag set

 drivers/nvme/host/fc.c     | 1 +
 drivers/nvme/host/rdma.c   | 1 +
 drivers/nvme/target/loop.c | 1 +
 3 files changed, 3 insertions(+)

-- 
1.8.3.1
