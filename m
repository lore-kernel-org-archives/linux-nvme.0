From: hare@suse.de (Hannes Reinecke)
Date: Tue, 18 Jun 2019 12:10:25 +0200
Subject: [PATCH 2/2] nvme: flush scan_work when resetting controller
In-Reply-To: <20190618101025.78840-1-hare@suse.de>
References: <20190618101025.78840-1-hare@suse.de>
Message-ID: <20190618101025.78840-3-hare@suse.de>

When resetting the controller there is no point whatsoever to
have a scan run in parallel; we cannot access the controller and
we cannot tell which devices are present and which not.
Additionally we'll run a scan after reset anyway.
So flush existing scans before reconnecting, ensuring to
short-circuit the scan workqueue function if the controller state
isn't live to avoid lockups.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 drivers/nvme/host/fc.c   |  1 +
 drivers/nvme/host/rdma.c |  1 +
 drivers/nvme/host/tcp.c  |  1 +
 4 files changed, 13 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e872591e5fe7..dc3f1ff12276 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1627,6 +1627,9 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	sector_t capacity = le64_to_cpu(id->nsze) << (ns->lba_shift - 9);
 	unsigned short bs = 1 << ns->lba_shift;
 
+	if (ns->ctrl->state != NVME_CTRL_LIVE)
+		return;
+
 	if (ns->lba_shift > PAGE_SHIFT) {
 		/* unsupported block size, set capacity to 0 later */
 		bs = (1 << 9);
@@ -1702,6 +1705,9 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		return -ENODEV;
 	}
 
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return 0;
+
 	id = nvme_identify_ns(ctrl, ns->head->ns_id);
 	if (!id)
 		return -ENODEV;
@@ -3437,6 +3443,8 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 		return -ENOMEM;
 
 	for (i = 0; i < num_lists; i++) {
+		if (ctrl->state != NVME_CTRL_LIVE)
+			goto free;
 		ret = nvme_identify_ns_list(ctrl, prev, ns_list);
 		if (ret)
 			goto free;
@@ -3515,6 +3523,8 @@ static void nvme_scan_work(struct work_struct *work)
 	if (test_and_clear_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events)) {
 		dev_info(ctrl->device, "rescanning namespaces.\n");
 		nvme_clear_changed_ns_log(ctrl);
+		if (ctrl->state != NVME_CTRL_LIVE)
+			return;
 	}
 
 	if (nvme_identify_ctrl(ctrl, &id))
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9b497d785ed7..1c6aa21858b2 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2909,6 +2909,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 
 	__nvme_fc_terminate_io(ctrl);
 
+	flush_work(&ctrl->ctrl.scan_work);
 	nvme_stop_ctrl(&ctrl->ctrl);
 
 	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f383146e7d0f..c00d59a14a2b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1839,6 +1839,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
+	flush_work(&ctrl->ctrl.scan_work);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure should never happen */
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 2b107a1d152b..ee32d9355959 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1872,6 +1872,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 
 	nvme_stop_ctrl(ctrl);
 	nvme_tcp_teardown_ctrl(ctrl, false);
+	flush_work(&ctrl->scan_work);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we're in DELETING state */
-- 
2.16.4
