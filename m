From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 12 Dec 2017 19:02:26 +0800
Subject: [PATCH 0/6] blk-mq: fix race related with device
 deletion/reset/switching sched
Message-ID: <20171212110232.12495-1-ming.lei@redhat.com>

Hi,

The 1st patch fixes one kernel oops triggered by IOs vs. deleting SCSI
device, and this issue can be triggered in less than 1min on scsi_debug.

The other 5 patch fixes recent Yi Zhang's reports about his NVMe stress
tests, most of them are related with switching io sched, NVMe reset or
updating nr_hw_queues.

Thanks,
Ming


Ming Lei (6):
  blk-mq: quiesce queue before freeing queue
  blk-mq: support concurrent blk_mq_quiesce_queue()
  blk-mq: quiesce queue during switching io sched and updating
    nr_requests
  blk-mq: avoid to map CPU into stale hw queue
  blk-mq: fix race between updating nr_hw_queues and switching io sched
  nvme: remove .init_request callback

 block/blk-core.c         |  9 +++++++++
 block/blk-mq-pci.c       |  8 ++++++++
 block/blk-mq.c           | 52 ++++++++++++++++++++++++++++++++++++++++++------
 block/elevator.c         |  2 ++
 drivers/nvme/host/core.c |  4 ++--
 drivers/nvme/host/pci.c  | 40 ++++++++++++++++++-------------------
 include/linux/blk-mq.h   |  7 ++++++-
 include/linux/blkdev.h   |  2 ++
 8 files changed, 95 insertions(+), 29 deletions(-)

-- 
2.9.5
