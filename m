From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Fri, 13 Jun 2014 14:09:55 +0200
Subject: [PATCH v8] convert nvme driver to blk-mq
Message-ID: <1402661396-19207-1-git-send-email-m@bjorling.me>

Hi all,

Thanks for all the hard work, feedback and suggestions.

I think we're there. I did a test with the qemu nvme device, it passes xfstests,
spurious removals, and ioctl tests. Take it for a spin on your physical devices.

The patch is based on the following:

Jens for-linus up to:

  28747fcd2211d0fccbe3d3c91a1067c3744db908
  block: remove WQ_POWER_EFFICIENT from kblockd

Matthew master up to:

  bd67608a6127c994e897c49cc4f72d9095925301
  NVMe: Rename io_timeout to nvme_io_timeout

The merged trees with the patch on top is found here:

  https://github.com/MatiasBjorling/linux-collab nvmemq_review

and the separate changes can be found in the nvmemq_v8 branch

Changes since v7:
 * Jens implemented support for QUEUE_FLAG_VIRT_HOLE to limit
   requests to a continuous range of virtual memory.
 * Keith fixed up the abortion logic.
 * Usual style fixups

Changes since v6:
 * Rebased on top of Matthew's master and Jens' for-linus
 * A couple of style fixups

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

 drivers/block/nvme-core.c | 1204 ++++++++++++++++++---------------------------
 drivers/block/nvme-scsi.c |    8 +-
 include/linux/nvme.h      |   15 +-
 3 files changed, 489 insertions(+), 738 deletions(-)

-- 
1.9.1
