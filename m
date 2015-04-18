From: axboe@fb.com (Jens Axboe)
Date: Sat, 18 Apr 2015 14:17:28 -0600
Subject: [PATCH v2] NVMe: allow discard timeouts to be configurable
Message-ID: <20150418201728.GA19441@kernel.dk>


On some devices, size of discard will impact how long it takes to
process, and full device discards can run into the 1-2min range. The
default IO timeout is 30 seconds, and even though that is configurable,
it'd be nice to keep that at a lower value and add a separate module
parameter for discard timeouts.

This patch adds that module parameter, and also defaults timeouts to 300
seconds instead of 30 seconds. That _should_ be enough for everyone.

Signed-off-by: Jens Axboe <axboe at fb.com>
---

Changes since v1:

- Move timeout setting into the DISCARD branch of request setup
  earlier, which saves a branch.

 nvme-core.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 85b8036deaa3..4a5b107aee22 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -58,6 +58,10 @@ unsigned char nvme_io_timeout = 30;
 module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 
+unsigned int nvme_discard_timeout = 300;
+module_param_named(discard_timeout, nvme_discard_timeout, uint, 0644);
+MODULE_PARM_DESC(discard_timeout, "timeout in seconds for discard I/O");
+
 static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
@@ -848,6 +852,12 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 			goto retry_cmd;
 		iod_list(iod)[0] = (__le64 *)range;
 		iod->npages = 0;
+
+		/*
+		 * Set the discard specific timeout here, before calling
+		 * nvme_set_info() which does blk_mq_start_request().
+		 */
+		req->timeout = nvme_discard_timeout * HZ;
 	} else if (req->nr_phys_segments) {
 		dma_dir = rq_data_dir(req) ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
 

-- 
Jens Axboe
