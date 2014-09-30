From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Tue, 30 Sep 2014 19:29:54 +0200
Subject: [PATCH v13] Convert NVMe driver to blk-mq
Message-ID: <1412098195-30133-1-git-send-email-m@bjorling.me>

Hi,

Thanks to Keith and Jens for feedback. Four fixes have been added. The current
patch is on top of Jens' for-next, together with the patches from Willy's
master tree.

A branch with the patch on top can be found here:

  https://github.com/MatiasBjorling/linux-collab nvmemq_review

and the separate changes can be found in the nvmemq_v13 branch.

There is a regression in the number of hardware queues available can change
between suspend/resume. This can mitigated by unloading the
device driver before suspend and reload it after resume. To fix it requires
support from blk-mq to take down hctx's on suspend and restore them again on
resume. We are working on getting to a good solution. This should be a minor
detail and shouldn't prevent the patch from going upstream. If it does, please
let me know.

Changes since v12:
 * Remove comment from nvme_suspend.
 * Queue depth off-by-one error, leading to time out errors.
 * Support latest blk-mq API changes.
 * Fix missing irq hints on suspend/resume.

Changes since v11:
 * Remove unused dev->q_suspended.
 * Remove unused "queued" label.
 * Revert replacement of nvmeq->hctx with nvmeq->tags. It allowed an
   use-after-free error to occur when all nvme queues wasn't assigned.

Changes since v10:
 * Rebased on top of Linus' v3.16-rc6.
 * Incorporated the feedback from Christoph:
    a. Insert comment regarding the timeout flow.
    b. Moved tags into nvmeq instead of hctx.
    c. Moved initialization of tags and nvmeq outside of init_hctx.
    d. Refactor submission of commands in the request queue path.
    e. Fixes for WARN_ON and BUG_ON.
 * Fixed a missing blk_put_request during abort.
 * Converted the "Async event request" patch into the request model.

Changes since v9:
 * Rebased on top of Linus' v3.16-rc3.
 * Ming noted that we should remember to kick the request queue after requeue.
 * Jens noted a couple of superfluous warnings.
 * Christoph is removed from the contribution section. Instead he is going to
   be added as reviewed-by.

Changes since v8:
 * QUEUE_FLAG_VIRT_HOLE was renamed to QUEUE_FLAG_SG_GAPS
 * Previous revertion of patches lost the IRQ affinity hint
 * Removed test code in nvme_reset_notify

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
  * various cleanups

Matias Bj?rling (1):
  NVMe: Convert to blk-mq

 drivers/block/nvme-core.c | 1347 ++++++++++++++++++---------------------------
 drivers/block/nvme-scsi.c |    8 +-
 include/linux/nvme.h      |   15 +-
 3 files changed, 552 insertions(+), 818 deletions(-)

-- 
1.9.1
