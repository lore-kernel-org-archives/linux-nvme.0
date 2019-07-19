From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 19 Jul 2019 12:45:46 -0700
Subject: [PATCH 4/4] nvme: don't pass cap to nvme_enable_ctrl
In-Reply-To: <20190719194546.24229-1-sagi@grimberg.me>
References: <20190719194546.24229-1-sagi@grimberg.me>
Message-ID: <20190719194546.24229-5-sagi@grimberg.me>

All seem to call it with ctrl->cap so no need to pass it
at all.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c   | 7 ++++---
 drivers/nvme/host/fc.c     | 2 +-
 drivers/nvme/host/nvme.h   | 2 +-
 drivers/nvme/host/pci.c    | 2 +-
 drivers/nvme/host/rdma.c   | 2 +-
 drivers/nvme/host/tcp.c    | 2 +-
 drivers/nvme/target/loop.c | 2 +-
 7 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 60e924b0b510..93b7e362f0ac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1967,14 +1967,15 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
 
-int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
+int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 {
 	/*
 	 * Default to a 4K page size, with the intention to update this
 	 * path in the future to accomodate architectures with differing
 	 * kernel and IO page sizes.
 	 */
-	unsigned dev_page_min = NVME_CAP_MPSMIN(cap) + 12, page_shift = 12;
+	unsigned dev_page_min = NVME_CAP_MPSMIN(ctrl->cap) + 12;
+	unsigned page_shift = 12;
 	int ret;
 
 	if (page_shift < dev_page_min) {
@@ -1995,7 +1996,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
 		return ret;
-	return nvme_wait_ready(ctrl, cap, true);
+	return nvme_wait_ready(ctrl, ctrl->cap, true);
 }
 EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 67d420bd79f6..e5c2a03a6c22 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2647,7 +2647,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	 * prior connection values
 	 */
 
-	ret = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
+	ret = nvme_enable_ctrl(&ctrl->ctrl);
 	if (ret)
 		goto out_disconnect_admin_queue;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a7f8fccb1f35..740241e84d29 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -427,7 +427,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl);
-int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
+int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f2e74043dc6b..4b508d5e45cf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1695,7 +1695,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	lo_hi_writeq(nvmeq->sq_dma_addr, dev->bar + NVME_REG_ASQ);
 	lo_hi_writeq(nvmeq->cq_dma_addr, dev->bar + NVME_REG_ACQ);
 
-	result = nvme_enable_ctrl(&dev->ctrl, dev->ctrl.cap);
+	result = nvme_enable_ctrl(&dev->ctrl);
 	if (result)
 		return result;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 8e2094fb5e7e..3fd44e1c279d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -809,7 +809,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	if (error)
 		goto out_cleanup_queue;
 
-	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
+	error = nvme_enable_ctrl(&ctrl->ctrl);
 	if (error)
 		goto out_stop_queue;
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4a32d5350fc5..77c3d4d06d29 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1721,7 +1721,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	if (error)
 		goto out_cleanup_queue;
 
-	error = nvme_enable_ctrl(ctrl, ctrl->cap);
+	error = nvme_enable_ctrl(ctrl);
 	if (error)
 		goto out_stop_queue;
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d901a019e3a2..a53a0c0170f5 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -369,7 +369,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	set_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
 
-	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
+	error = nvme_enable_ctrl(&ctrl->ctrl);
 	if (error)
 		goto out_cleanup_queue;
 
-- 
2.17.1
