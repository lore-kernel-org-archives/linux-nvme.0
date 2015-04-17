From: axboe@fb.com (Jens Axboe)
Date: Fri, 17 Apr 2015 15:31:48 -0600
Subject: [PATCH] NVMe: allow discard timeouts to be configurable
Message-ID: <20150417213148.GA22587@kernel.dk>

Hi,

On some devices, size of discard will impact how long it takes to
process, and full device discards can run into the 1-2min range. The
default IO timeout is 30 seconds, and even though that is configurable,
it'd be nice to keep that at a lower value and add a separate module
parameter for discard timeouts.

This patch adds that module parameter, and also defaults timeouts to 300
seconds instead of 30 seconds. That _should_ be enough for everyone.

Signed-off-by: Jens Axboe <axboe at fb.com>
---

 nvme-core.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 85b8036deaa3..2062a36811b1 100644
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
@@ -242,10 +246,16 @@ static int nvme_init_request(void *data, struct request *req,
 static void nvme_set_info(struct nvme_cmd_info *cmd, void *ctx,
 				nvme_completion_fn handler)
 {
+	struct request *rq = blk_mq_rq_from_pdu(cmd);
+
 	cmd->fn = handler;
 	cmd->ctx = ctx;
 	cmd->aborted = 0;
-	blk_mq_start_request(blk_mq_rq_from_pdu(cmd));
+
+	if (rq->cmd_flags & REQ_DISCARD)
+		rq->timeout = nvme_discard_timeout * HZ;
+
+	blk_mq_start_request(rq);
 }
 
 static void *iod_get_private(struct nvme_iod *iod)

-- 
Jens Axboe
