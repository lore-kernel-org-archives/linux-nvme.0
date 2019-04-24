From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 24 Apr 2019 19:02:12 +0800
Subject: [PATCH V7 0/9] blk-mq: fix races related with freeing queue
Message-ID: <20190424110221.17435-1-ming.lei@redhat.com>

Hi,

Since 45a9c9d909b2 ("blk-mq: Fix a use-after-free"), run queue isn't
allowed during cleanup queue even though queue refcount is held.

This change has caused lots of kernel oops triggered in run queue path,
turns out it isn't easy to fix them all.

So move freeing of hw queue resources into hctx's release handler, then
the above issue is fixed. Meantime, this way is safe given freeing hw
queue resource doesn't require tags.

V3 covers more races.

V7:
	- add reviewed-by and tested-by tag
	- rename "dead_hctx" as "unused_hctx"
	- check if there are live hctx in queue's release handler
	- only patch 6 is modified

V6:
	- remove previous SCSI patch which will be routed via SCSI tree
	- add reviewed-by tag
	- fix one related NVMe scan vs reset race

V5:
	- refactor blk_mq_alloc_and_init_hctx()
	- fix race related updating nr_hw_queues by always freeing hctx
	  after request queue is released

V4:
	- add patch for fixing potential use-after-free in blk_mq_update_nr_hw_queues
	- fix comment in the last patch

V3:
	- cancel q->requeue_work in queue's release handler
	- cancel hctx->run_work in hctx's release handler
	- add patch 1 for fixing race in plug code path
	- the last patch is added for avoiding to grab SCSI's refcont
	in IO path

V2:
	- moving freeing hw queue resources into hctx's release handler


Ming Lei (9):
  blk-mq: grab .q_usage_counter when queuing request from plug code path
  blk-mq: move cancel of requeue_work into blk_mq_release
  blk-mq: free hw queue's resource in hctx's release handler
  blk-mq: move all hctx alloction & initialization into
    __blk_mq_alloc_and_init_hctx
  blk-mq: split blk_mq_alloc_and_init_hctx into two parts
  blk-mq: always free hctx after request queue is freed
  blk-mq: move cancel of hctx->run_work into blk_mq_hw_sysfs_release
  block: don't drain in-progress dispatch in blk_cleanup_queue()
  nvme: hold request queue's refcount in ns's whole lifetime

 block/blk-core.c         |  23 +-----
 block/blk-mq-sysfs.c     |   8 ++
 block/blk-mq.c           | 199 ++++++++++++++++++++++++++++-------------------
 block/blk-mq.h           |   2 +-
 drivers/nvme/host/core.c |  10 ++-
 include/linux/blk-mq.h   |   2 +
 include/linux/blkdev.h   |   7 ++
 7 files changed, 148 insertions(+), 103 deletions(-)

Cc: Dongli Zhang <dongli.zhang at oracle.com>
Cc: James Smart <james.smart at broadcom.com>
Cc: Bart Van Assche <bart.vanassche at wdc.com>
Cc: linux-scsi at vger.kernel.org,
Cc: Martin K . Petersen <martin.petersen at oracle.com>,
Cc: Christoph Hellwig <hch at lst.de>,
Cc: James E . J . Bottomley <jejb at linux.vnet.ibm.com>,

-- 
2.9.5
