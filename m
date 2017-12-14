From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 14 Dec 2017 10:30:57 +0800
Subject: [PATCH V2 0/6] blk-mq: fix race related with device
 deletion/reset/switching sched
Message-ID: <20171214023103.18272-1-ming.lei@redhat.com>

Hi,

The 1st patch fixes one kernel oops triggered by IOs vs. deleting SCSI
device, and this issue can be triggered easily on scsi_debug.

The other 5 patch fixes recent Yi Zhang's reports about his NVMe stress
tests, most of them are related with switching io sched, NVMe reset or
updating nr_hw_queues.

V2:
	- address stale queue mapping in blk_mq_update_queue_map(), instead
	of PCI transport, since such issue exists on other transport too,
	as suggested by Christoph
	- avoid to introduce nvme_admin_queue_rq() since the nvme queue can
	be got from hctx->driver_data, which is reliable


Thanks,
Ming

Ming Lei (6):
  blk-mq: quiesce queue before freeing queue
  blk-mq: support concurrent blk_mq_quiesce_queue()
  blk-mq: quiesce queue during switching io sched and updating
    nr_requests
  blk-mq: avoid to map CPU into stale hw queue
  blk-mq: fix race between updating nr_hw_queues and switching io sched
  nvme-pci: remove .init_request callback

 block/blk-core.c         |  9 ++++++
 block/blk-mq.c           | 74 ++++++++++++++++++++++++++++++++++++++++++------
 block/elevator.c         |  2 ++
 drivers/nvme/host/core.c |  4 +--
 drivers/nvme/host/pci.c  | 21 +++-----------
 include/linux/blk-mq.h   |  7 ++++-
 include/linux/blkdev.h   |  2 ++
 7 files changed, 91 insertions(+), 28 deletions(-)

-- 
2.9.5
