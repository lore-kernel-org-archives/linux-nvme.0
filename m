From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  3 Jun 2019 16:11:59 -0700
Subject: [PATCH] Revert "nvme-rdma: remove redundant reference between
 ib_device and tagset"
Message-ID: <20190603231159.17034-1-sagi@grimberg.me>

This commit caused a kernel panic when disconnecting from an
inaccessible controller.

--
nvme nvme0: Removing ctrl: NQN "testnqn1"
nvme_rdma: nvme_rdma_exit_request: hctx 0 queue_idx 1
BUG: unable to handle kernel paging request at 0000000080000228
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
...
Call Trace:
 blk_mq_exit_hctx+0x5c/0xf0
 blk_mq_exit_queue+0xd4/0x100
 blk_cleanup_queue+0x9a/0xc0
 nvme_rdma_destroy_io_queues+0x52/0x60 [nvme_rdma]
 nvme_rdma_shutdown_ctrl+0x3e/0x80 [nvme_rdma]
 nvme_do_delete_ctrl+0x53/0x80 [nvme_core]
 nvme_sysfs_delete+0x45/0x60 [nvme_core]
 kernfs_fop_write+0x105/0x180
 vfs_write+0xad/0x1a0
 ksys_write+0x5a/0xd0
 do_syscall_64+0x55/0x110
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fa215417154
--

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 26709a2ab593..8aff3a0ab609 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -707,6 +707,15 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return ret;
 }
 
+static void nvme_rdma_free_tagset(struct nvme_ctrl *nctrl,
+		struct blk_mq_tag_set *set)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+
+	blk_mq_free_tag_set(set);
+	nvme_rdma_dev_put(ctrl->device);
+}
+
 static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		bool admin)
 {
@@ -745,9 +754,24 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 
 	ret = blk_mq_alloc_tag_set(set);
 	if (ret)
-		return ERR_PTR(ret);
+		goto out;
+
+	/*
+	 * We need a reference on the device as long as the tag_set is alive,
+	 * as the MRs in the request structures need a valid ib_device.
+	 */
+	ret = nvme_rdma_dev_get(ctrl->device);
+	if (!ret) {
+		ret = -EINVAL;
+		goto out_free_tagset;
+	}
 
 	return set;
+
+out_free_tagset:
+	blk_mq_free_tag_set(set);
+out:
+	return ERR_PTR(ret);
 }
 
 static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
@@ -755,7 +779,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 {
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
-		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
+		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
 	}
 	if (ctrl->async_event_sqe.data) {
 		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
@@ -833,7 +857,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
 out_free_tagset:
 	if (new)
-		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
+		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.admin_tagset);
 out_free_async_qe:
 	nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
 		sizeof(struct nvme_command), DMA_TO_DEVICE);
@@ -848,7 +872,7 @@ static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
 {
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
-		blk_mq_free_tag_set(ctrl->ctrl.tagset);
+		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.tagset);
 	}
 	nvme_rdma_free_io_queues(ctrl);
 }
@@ -889,7 +913,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
 out_free_tag_set:
 	if (new)
-		blk_mq_free_tag_set(ctrl->ctrl.tagset);
+		nvme_rdma_free_tagset(&ctrl->ctrl, ctrl->ctrl.tagset);
 out_free_io_queues:
 	nvme_rdma_free_io_queues(ctrl);
 	return ret;
-- 
2.17.1
