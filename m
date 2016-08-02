From: keith.busch@intel.com (Keith Busch)
Date: Tue, 2 Aug 2016 18:23:40 -0400
Subject: [PATCH] nvme: Suspend all queues before deletion
In-Reply-To: <1469812557-9809-1-git-send-email-krisman@linux.vnet.ibm.com>
References: <1469812557-9809-1-git-send-email-krisman@linux.vnet.ibm.com>
Message-ID: <20160802222340.GA28486@localhost.localdomain>

On Fri, Jul 29, 2016@02:15:57PM -0300, Gabriel Krisman Bertazi wrote:
> -	for (pass = 0; pass < 2; pass++) {
> -		int sent = 0, i = queues;
> +	reinit_completion(&dev->ioq_wait);
> +	for (i = queues; i > 0; i--)
> +		nvme_suspend_queue(dev->queues[i]);
>  
> -		reinit_completion(&dev->ioq_wait);
> - retry:
> -		timeout = ADMIN_TIMEOUT;
> -		for (; i > 0; i--) {
> -			struct nvme_queue *nvmeq = dev->queues[i];
> +	for (i = queues; i > 0; i--) {
> +retry_sq:
> +		if (nvme_delete_queue(dev->queues[i], nvme_admin_delete_sq))
> +			break;
> +		sent++;
> +retry_cq:
> +		if (nvme_delete_queue(dev->queues[i], nvme_admin_delete_cq))
> +			break;
> +		sent++;

I see what this is fixing, and maybe this works for most controllers,
but this isn't a spec compliant way to delete queues: "Host software
shall ensure that any associated I/O Submission Queue is deleted prior
to deleting a Completion Queue". The host can't know if the submission
queue is deleted until it sees status the delete command.

Maybe we should suspend queues unconditionally during disable?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index befac5b..e7b7e8e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1564,8 +1564,6 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 		for (; i > 0; i--) {
 			struct nvme_queue *nvmeq = dev->queues[i];
 
-			if (!pass)
-				nvme_suspend_queue(nvmeq);
 			if (nvme_delete_queue(nvmeq, opcode))
 				break;
 			++sent;
@@ -1716,15 +1714,16 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		nvme_stop_queues(&dev->ctrl);
 		csts = readl(dev->bar + NVME_REG_CSTS);
 	}
-	if (csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY)) {
-		for (i = dev->queue_count - 1; i >= 0; i--) {
-			struct nvme_queue *nvmeq = dev->queues[i];
-			nvme_suspend_queue(nvmeq);
-		}
-	} else {
+
+	for (i = dev->queue_count - 1; i > 0; i--)
+		nvme_suspend_queue(dev->queues[i]);
+
+	if (!(csts & NVME_CSTS_CFS || !(csts & NVME_CSTS_RDY))) {
 		nvme_disable_io_queues(dev);
 		nvme_disable_admin_queue(dev, shutdown);
-	}
+	} else
+		nvme_suspend_queue(dev->queues[0]);
+
 	nvme_pci_disable(dev);
 
 	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_io, dev);
--
