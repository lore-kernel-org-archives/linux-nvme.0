From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Aug 2016 13:16:55 -0400
Subject: Oops when completing request on the wrong queue
In-Reply-To: <87a8gltgks.fsf@linux.vnet.ibm.com>
References: <87a8gltgks.fsf@linux.vnet.ibm.com>
Message-ID: <20160811171655.GA5334@localhost.localdomain>

On Wed, Aug 10, 2016@01:04:35AM -0300, Gabriel Krisman Bertazi wrote:
> Hi,
> 
> We, IBM, have been experiencing eventual Oops when stressing IO at the
> same time we add/remove processors.  The Oops happens in the IRQ path,
> when we try to complete a request that was apparently meant for another
> queue.
> 
> In __nvme_process_cq, the driver will use the cqe.command_id and the
> nvmeq->tags to find out, via blk_mq_tag_to_rq, the request that
> initiated the IO.  Eventually, it happens that the request returned by
> that function is not initialized, and we crash inside
> __blk_mq_complete_request, as shown below.

Could you try the following patch and see if it resolves the issue?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d7c33f9..d49ddfb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -216,7 +216,7 @@ static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	return 0;
 }
 
-static void nvme_admin_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
+static void nvme_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
 
@@ -1133,7 +1133,7 @@ static struct blk_mq_ops nvme_mq_admin_ops = {
 	.complete	= nvme_complete_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_admin_init_hctx,
-	.exit_hctx      = nvme_admin_exit_hctx,
+	.exit_hctx      = nvme_exit_hctx,
 	.init_request	= nvme_admin_init_request,
 	.timeout	= nvme_timeout,
 };
@@ -1143,6 +1143,7 @@ static struct blk_mq_ops nvme_mq_ops = {
 	.complete	= nvme_complete_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_init_hctx,
+	.exit_hctx      = nvme_exit_hctx,
 	.init_request	= nvme_init_request,
 	.timeout	= nvme_timeout,
 	.poll		= nvme_poll,
--
