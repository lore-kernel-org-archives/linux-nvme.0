From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon,  7 Nov 2016 21:17:15 +0200
Subject: [PATCH 1/1] nvme/rdma: introduce delete_work_to_rdma_ctrl helper
Message-ID: <1478546235-26907-1-git-send-email-maxg@mellanox.com>

In order to avoid some code duplication.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index af1c114..dbda962 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -141,6 +141,12 @@ struct nvme_rdma_ctrl {
 	return container_of(ctrl, struct nvme_rdma_ctrl, ctrl);
 }
 
+static inline struct nvme_rdma_ctrl *
+delete_work_to_rdma_ctrl(struct work_struct *delete_work)
+{
+        return container_of(delete_work, struct nvme_rdma_ctrl, delete_work);
+}
+
 static LIST_HEAD(device_list);
 static DEFINE_MUTEX(device_list_mutex);
 
@@ -1655,8 +1661,7 @@ static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 
 static void nvme_rdma_del_ctrl_work(struct work_struct *work)
 {
-	struct nvme_rdma_ctrl *ctrl = container_of(work,
-				struct nvme_rdma_ctrl, delete_work);
+	struct nvme_rdma_ctrl *ctrl = delete_work_to_rdma_ctrl(work);
 
 	__nvme_rdma_remove_ctrl(ctrl, true);
 }
@@ -1692,8 +1697,7 @@ static int nvme_rdma_del_ctrl(struct nvme_ctrl *nctrl)
 
 static void nvme_rdma_remove_ctrl_work(struct work_struct *work)
 {
-	struct nvme_rdma_ctrl *ctrl = container_of(work,
-				struct nvme_rdma_ctrl, delete_work);
+	struct nvme_rdma_ctrl *ctrl = delete_work_to_rdma_ctrl(work);
 
 	__nvme_rdma_remove_ctrl(ctrl, false);
 }
-- 
1.7.1
