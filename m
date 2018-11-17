From: axboe@kernel.dk (Jens Axboe)
Date: Sat, 17 Nov 2018 14:43:47 -0700
Subject: [PATCHSET v4] Various block optimizations
Message-ID: <20181117214354.822-1-axboe@kernel.dk>

Some of these are optimizations, the latter part is prep work
for supporting polling with aio.

Patches against my for-4.21/block branch. These patches can also
be found in my mq-perf branch. Some of them are prep patches for
the aio poll work, which can be found in my aio-poll branch.
These will get posted soon.

Changes since v3:

- Fix tiny race in iocb flag checking for plugging
- Improve poll-many implementation, including nvme-rdma
- Get rid of unneeded smp_rmb()
- Drop merged patches

Changes since v2:

- Include polled swap IO in the poll optimizations
- Get rid of unnecessary write barrier for DIO wakeup
- Fix a potential stall if need_resched() was set and preempt
  wasn't enabled
- Provide separate mq_ops for NVMe with poll queues
- Drop q->mq_ops patch
- Rebase on top of for-4.21/block

Changes since v1:

- Improve nvme irq disabling for polled IO
- Fix barriers in the ordered wakeup for polled O_DIRECT
- Add patch to allow polling to find any command that is done
- Add patch to control whether polling spins or not
- Have async O_DIRECT mark a bio as pollable
- Don't plug for polling


 block/blk-core.c                  |  4 +-
 block/blk-mq.c                    | 91 +++++++++++++++++++++------------------
 drivers/nvme/host/fc.c            | 33 --------------
 drivers/nvme/host/multipath.c     |  6 +--
 drivers/nvme/host/pci.c           | 22 +++++-----
 drivers/nvme/host/rdma.c          | 38 ++++++++--------
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 fs/block_dev.c                    | 11 +++--
 fs/direct-io.c                    |  2 +-
 fs/iomap.c                        |  5 ++-
 include/linux/blk-mq.h            |  2 +-
 include/linux/blkdev.h            |  4 +-
 mm/page_io.c                      |  5 ++-
 13 files changed, 101 insertions(+), 124 deletions(-)

-- 
Jens Axboe
