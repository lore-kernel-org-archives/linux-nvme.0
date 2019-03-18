From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 18 Mar 2019 11:29:48 +0800
Subject: [PATCH 0/2] blk-mq/nvme: cancel request synchronously
Message-ID: <20190318032950.17770-1-ming.lei@redhat.com>

Hi,

This patchset introduces blk_mq_complete_request_sync() for canceling
request synchronously in error handler context, then one race between
completing request and destroying contoller/queues can be fixed.


Ming Lei (2):
  blk-mq: introduce blk_mq_complete_request_sync()
  nvme: cancel request synchronously

 block/blk-mq.c           | 20 ++++++++++++++++----
 drivers/nvme/host/core.c |  2 +-
 include/linux/blk-mq.h   |  1 +
 3 files changed, 18 insertions(+), 5 deletions(-)

Cc: Christoph Hellwig <hch at lst.de>
Cc: linux-nvme at lists.infradead.org

-- 
2.9.5
