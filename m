From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Dec 2017 05:54:02 -0800
Subject: [PATCH 4.15-rc 1/3] nvme-core: Don't set nvme_wq as MEM_RECLAIM
In-Reply-To: <f8cc93b5-a32a-f418-a65b-193ee530c481@grimberg.me>
References: <20171221100752.18386-1-sagi@grimberg.me>
 <20171221100752.18386-2-sagi@grimberg.me>
 <20171221101741.GB17327@infradead.org>
 <fd880cf7-e815-fa63-b999-6381b145ffd8@grimberg.me>
 <20171221130002.GA4239@infradead.org>
 <f8cc93b5-a32a-f418-a65b-193ee530c481@grimberg.me>
Message-ID: <20171221135402.GA12323@infradead.org>

On Thu, Dec 21, 2017@03:17:10PM +0200, Sagi Grimberg wrote:
> Note that the we need to make sure to not flush workqueue !MEM_RECLAIM
> from a workqueue that is MEM_RECLAIM and vice-versa (if we do we will
> can trigger deadlocks in severe memory pressure.

Yes.

> We cannot place the delete_work on the same workqueue as the reset_work
> because we flush reset_work from nvme_delete_ctrl (this is what this
> patch is trying to prevent).

Ok..

Seems like we should instead have a single-thread MEM_RECLAIM
workqueue per nvme controller for reset and remove as that would
implicitly serialize remove and delete.

Alternatively we could use the reset_work for removal as well.
In fact it already has the removal and we'd just need to add
a goto for that case if we are in deleting state, e.g. something
like the patch below, just for rdma without the core and other
transport bits:

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 37af56596be6..ac09d5c4465f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1753,6 +1753,9 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
+	if (ctrl->state == NVME_CTRL_DELETING)
+		goto out_remove;
+
 	ret = nvme_rdma_configure_admin_queue(ctrl, false);
 	if (ret)
 		goto out_fail;
@@ -1760,7 +1763,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	if (ctrl->ctrl.queue_count > 1) {
 		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
-			goto out_fail;
+			goto out_remove;
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
@@ -1774,7 +1777,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 
 	return;
 
-out_fail:
+out_remove:
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
 	nvme_remove_namespaces(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, true);
