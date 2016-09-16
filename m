From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 16 Sep 2016 10:51:11 +0200
Subject: [PATCH RFC 00/21] blk-mq: Introduce combined hardware queues
Message-ID: <cover.1474014910.git.agordeev@redhat.com>

Linux block device layer limits number of hardware contexts queues
to number of CPUs in the system. That looks like suboptimal hardware
utilization in systems where number of CPUs is (significantly) less
than number of hardware queues.

In addition, there is a need to deal with tag starvation (see commit
0d2602ca "blk-mq: improve support for shared tags maps"). While unused
hardware queues stay idle, extra efforts are taken to maintain a notion
of fairness between queue users. Deeper queue depth could probably
mitigate the whole issue sometimes.

That all brings a straightforward idea that hardware queues provided by
a device should be utilized as much as possible.

This series is an attempt to introduce 1:N mapping between CPUs and
hardware queues. The code is experimental and hence some checks and
sysfs interfaces and are withdrawn as blocking the demo implementation.

The implementation evenly distributes hardware queues by CPUs, with
moderate changes to the existing codebase. But further developments
of the design are possible if needed. I.e. complete device utilization,
CPU and/or interrupt topology-driven queue distribution, workload-driven
queue redistribution.

Comments and suggestions are very welcomed!

The series is against linux-block tree.

Thanks!

CC: Jens Axboe <axboe at kernel.dk>
CC: linux-nvme at lists.infradead.org

Alexander Gordeev (21):
  blk-mq: Fix memory leaks on a queue cleanup
  blk-mq: Fix a potential NULL pointer assignment to hctx tags
  block: Get rid of unused request_queue::nr_queues member
  blk-mq: Do not limit number of queues to 'nr_cpu_ids' in allocations
  blk-mq: Update hardware queue map after q->nr_hw_queues is set
  block: Remove redundant blk_mq_ops::map_queue() interface
  blk-mq: Remove a redundant assignment
  blk-mq: Cleanup hardware context data node selection
  blk-mq: Cleanup a loop exit condition
  blk-mq: Get rid of unnecessary blk_mq_free_hw_queues()
  blk-mq: Move duplicating code to blk_mq_exit_hctx()
  blk-mq: Uninit hardware context in order reverse to init
  blk-mq: Move hardware context init code into blk_mq_init_hctx()
  blk-mq: Rework blk_mq_init_hctx() function
  blk-mq: Pair blk_mq_hctx_kobj_init() with blk_mq_hctx_kobj_put()
  blk-mq: Set flush_start_tag to BLK_MQ_MAX_DEPTH
  blk-mq: Introduce a 1:N hardware contexts
  blk-mq: Enable tag numbers exceed hardware queue depth
  blk-mq: Enable combined hardware queues
  blk-mq: Allow combined hardware queues
  null_blk: Do not limit # of hardware queues to # of CPUs

 block/blk-core.c                  |   5 +-
 block/blk-flush.c                 |   6 +-
 block/blk-mq-cpumap.c             |  49 +++--
 block/blk-mq-sysfs.c              |   5 +
 block/blk-mq-tag.c                |   9 +-
 block/blk-mq.c                    | 373 +++++++++++++++-----------------------
 block/blk-mq.h                    |   4 +-
 block/blk.h                       |   2 +-
 drivers/block/loop.c              |   3 +-
 drivers/block/mtip32xx/mtip32xx.c |   4 +-
 drivers/block/null_blk.c          |  16 +-
 drivers/block/rbd.c               |   3 +-
 drivers/block/virtio_blk.c        |   6 +-
 drivers/block/xen-blkfront.c      |   6 +-
 drivers/md/dm-rq.c                |   4 +-
 drivers/mtd/ubi/block.c           |   1 -
 drivers/nvme/host/pci.c           |  29 +--
 drivers/nvme/host/rdma.c          |   2 -
 drivers/nvme/target/loop.c        |   2 -
 drivers/scsi/scsi_lib.c           |   4 +-
 include/linux/blk-mq.h            |  51 ++++--
 include/linux/blkdev.h            |   1 -
 22 files changed, 279 insertions(+), 306 deletions(-)

-- 
1.8.3.1
