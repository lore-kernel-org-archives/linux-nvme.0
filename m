From: ming.lei@redhat.com (Ming Lei)
Date: Sat, 20 May 2017 11:56:02 +0800
Subject: [PATCH v2 0/3] nvme: fix hang in path of removing disk
Message-ID: <20170520035605.21785-1-ming.lei@redhat.com>

The first two patches fixes hang during removing disk.

The 3rd patch removes blk_mq_abort_requeue_list() since
no one uses it any more.


Ming Lei (3):
  nvme: use blk_mq_start_hw_queues() in nvme_kill_queues()
  nvme: avoid to use blk_mq_abort_requeue_list()
  blk-mq: remove blk_mq_abort_requeue_list()

 block/blk-mq.c           | 19 -------------------
 drivers/nvme/host/core.c | 13 ++++++++++---
 include/linux/blk-mq.h   |  1 -
 3 files changed, 10 insertions(+), 23 deletions(-)

-- 
2.9.4
