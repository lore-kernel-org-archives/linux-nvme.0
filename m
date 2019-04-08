From: ming.lei@redhat.com (Ming Lei)
Date: Mon,  8 Apr 2019 17:40:45 +0800
Subject: [PATCH V3 0/2] blk-mq/nvme: cancel request synchronously
Message-ID: <20190408094047.29150-1-ming.lei@redhat.com>

Hi,

This patchset introduces blk_mq_complete_request_sync() for canceling
request synchronously in error handler context, then one race between
completing request remotely and destroying contoller/queues can be fixed.


V3:
	- avoid extra cost to blk_mq_complete_request

V2:
	- export via EXPORT_SYMBOL_GPL
	- minor commit log change


Ming Lei (2):
  blk-mq: introduce blk_mq_complete_request_sync()
  nvme: cancel request synchronously

 block/blk-mq.c           | 11 +++++++++++
 drivers/nvme/host/core.c |  2 +-
 include/linux/blk-mq.h   |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

Cc: Keith Busch <kbusch at kernel.org>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Bart Van Assche <bvanassche at acm.org>
Cc: James Smart <james.smart at broadcom.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: linux-nvme at lists.infradead.org

-- 
2.9.5
