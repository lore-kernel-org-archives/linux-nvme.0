From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Fri,  6 Jun 2014 14:20:24 +0200
Subject: [PATCH v6] conversion to blk-mq
Message-ID: <1402057225-7312-1-git-send-email-m@bjorling.me>

Hi all,

Here is the updated patchset, on top of Jens' latest for-linus branch. You may
use the nvmemq_review branch at:

https://github.com/MatiasBjorling/linux-collab nvmemq_review

and see the individual contributions in the nvmemq_v6 branch.

I've removed the WIP flag, let me know if there is any outstanding work.
If not, I'll create final version on top of latest linus master and Matthew
master branch patches for final patch.

Changes since v5:
 * Splits are now supported directly within blk-mq
 * Remove nvme_queue->cpu_mask variable
 * Remove unnecessary null check
 * Style fixups

Changes since v4:
 * Fix timeout retries
 * Fix naming in nvme_init_hctx
 * Fix racy behavior of admin queue in nvme_dev_remove
 * Fix wrong return values in nvme_queue_request
 * Put cqe_seen back
 * Introduce abort_completion for killing timed out I/Os
 * Move locks outside of nvme_submit_iod
 * Various renaming and style fixes

Changes since v3:
 * Added abortion logic
 * Fixed possible race on abortion
 * Removed req data with flush. Handled by by blk-mq
 * Added safety check for submitting user rq to admin queue.
 * Use dev->online_queues for nr_hw_queues
 * Fix loop with initialization in nvme_create_io_queues
 * Style fixups

Changes since v2:
  * rebased on top of current 3.16/core.
  * use blk-mq queue management for spreading io queues
  * removed rcu handling and allocated all io queues up front for mgmt by blk-mq
  * removed the need for hotplugging notification
  * fixed flush data handling
  * fixed double free of spinlock
  * various cleanup

Matias Bj?rling (1):
  NVMe: conversion to blk-mq

 drivers/block/nvme-core.c | 1178 +++++++++++++++++++--------------------------
 drivers/block/nvme-scsi.c |    8 +-
 include/linux/nvme.h      |   14 +-
 3 files changed, 496 insertions(+), 704 deletions(-)

-- 
1.9.1
