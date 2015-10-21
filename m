From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 21 Oct 2015 13:19:22 -0400
Subject: [PATCH v3 00/12] Simplify block integrity registration v3
Message-ID: <20151021171921.6456.1646.stgit@dwillia2-desk3.amr.corp.intel.com>

Changes since v2 [1]:

1/ Fold in static declaration fix to "block: Consolidate static
   integrity profile properties"

2/ Rebase on latest for-4.4/drivers from block.git

3/ Merge the pending lifetime fixes

[1]: http://lists.infradead.org/pipermail/linux-nvme/2015-October/002783.html

---

Dan Williams (7):
      md, dm, scsi, nvme, libnvdimm: drop blk_integrity_unregister() at shutdown
      md: suspend i/o during runtime blk_integrity_unregister
      nvme: suspend i/o during runtime blk_integrity_unregister
      block: generic request_queue reference counting
      block: move blk_integrity to request_queue
      block: blk_flush_integrity() for bio-based drivers
      block, libnvdimm, nvme: provide a built-in blk_integrity nop profile

Martin K. Petersen (5):
      block: Move integrity kobject to struct gendisk
      block: Consolidate static integrity profile properties
      block: Reduce the size of struct blk_integrity
      block: Export integrity data interval size in sysfs
      block: Inline blk_integrity in struct gendisk


 Documentation/ABI/testing/sysfs-block |    7 +
 block/bio-integrity.c                 |   17 ++-
 block/blk-core.c                      |   74 +++++++++++--
 block/blk-integrity.c                 |  192 +++++++++++++++------------------
 block/blk-mq-sysfs.c                  |    6 -
 block/blk-mq.c                        |   80 ++++----------
 block/blk-sysfs.c                     |    3 -
 block/blk.h                           |   22 ++++
 block/genhd.c                         |    2 
 block/partition-generic.c             |    1 
 block/t10-pi.c                        |   16 +--
 drivers/md/dm-table.c                 |   88 ++++++++-------
 drivers/md/dm.c                       |    2 
 drivers/md/md.c                       |   11 +-
 drivers/md/multipath.c                |    2 
 drivers/md/raid1.c                    |    2 
 drivers/md/raid10.c                   |    2 
 drivers/nvdimm/btt.c                  |    1 
 drivers/nvdimm/core.c                 |   21 +---
 drivers/nvme/host/pci.c               |   34 +-----
 drivers/scsi/sd.c                     |    1 
 drivers/scsi/sd_dif.c                 |   31 +++--
 drivers/target/target_core_iblock.c   |   10 +-
 fs/block_dev.c                        |    2 
 include/linux/blk-mq.h                |    1 
 include/linux/blkdev.h                |   48 ++++----
 include/linux/genhd.h                 |   26 ++++
 include/linux/t10-pi.h                |    8 +
 28 files changed, 367 insertions(+), 343 deletions(-)
