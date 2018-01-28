From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 28 Jan 2018 15:58:05 +0200
Subject: [PATCH 3/5] nvme-fc: use NVME_CTRL_CONNECTING state to mark init
 process
In-Reply-To: <1517147887-15645-1-git-send-email-maxg@mellanox.com>
References: <1517147887-15645-1-git-send-email-maxg@mellanox.com>
Message-ID: <1517147887-15645-4-git-send-email-maxg@mellanox.com>

Align with RDMA and PCI transports.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/fc.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b679971..2992896 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2704,7 +2704,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
  * on the link side, recreates the controller association.
  */
 static int
-nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
+nvme_fc_create_association(struct nvme_fc_ctrl *ctrl, bool new)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
 	int ret;
@@ -2735,7 +2735,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 	if (ret)
 		goto out_delete_hw_queue;
 
-	if (ctrl->ctrl.state != NVME_CTRL_NEW)
+	if (!new)
 		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
 	ret = nvmf_connect_admin_queue(&ctrl->ctrl);
@@ -2801,7 +2801,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 	 */
 
 	if (ctrl->ctrl.queue_count > 1) {
-		if (ctrl->ctrl.state == NVME_CTRL_NEW)
+		if (new)
 			ret = nvme_fc_create_io_queues(ctrl);
 		else
 			ret = nvme_fc_reinit_io_queues(ctrl);
@@ -3007,7 +3007,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 	}
 
 	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE)
-		ret = nvme_fc_create_association(ctrl);
+		ret = nvme_fc_create_association(ctrl, false);
 	else
 		ret = -ENOTCONN;
 
@@ -3042,7 +3042,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 			container_of(to_delayed_work(work),
 				struct nvme_fc_ctrl, connect_work);
 
-	ret = nvme_fc_create_association(ctrl);
+	ret = nvme_fc_create_association(ctrl, false);
 	if (ret)
 		nvme_fc_reconnect_or_delete(ctrl, ret);
 	else
@@ -3096,6 +3096,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 	struct nvme_fc_ctrl *ctrl;
 	unsigned long flags;
 	int ret, idx, retry;
+	bool changed;
 
 	if (!(rport->remoteport.port_role &
 	    (FC_PORT_ROLE_NVME_DISCOVERY | FC_PORT_ROLE_NVME_TARGET))) {
@@ -3212,8 +3213,11 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
 	 * request fails, retry the initial connection creation up to
 	 * three times before giving up and declaring failure.
 	 */
+	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
+	WARN_ON_ONCE(!changed);
+
 	for (retry = 0; retry < 3; retry++) {
-		ret = nvme_fc_create_association(ctrl);
+		ret = nvme_fc_create_association(ctrl, true);
 		if (!ret)
 			break;
 	}
-- 
1.8.3.1
