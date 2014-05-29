From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Thu, 29 May 2014 23:51:24 +0200
Subject: [PATCH v4] basic conversion to blk-mq
Message-ID: <1401400285-25003-1-git-send-email-m@bjorling.me>

Hi Matthew and Keith,

Thanks for the quick review.

The patch has been updated with the feedback from Keith and Jens. It's against
Jens' 3.16/core tree. You may use the nvmemq_wip_review branch at:

https://github.com/MatiasBjorling/linux-collab nvmemq_wip_review

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

Keith, what kind of retry scheme do you like for timeout retries?

Matias Bj?rling (1):
  NVMe: basic conversion to blk-mq

 drivers/block/nvme-core.c | 1100 ++++++++++++++++++---------------------------
 include/linux/nvme.h      |   11 +-
 2 files changed, 442 insertions(+), 669 deletions(-)

-- 
1.9.1
