From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 28 Jan 2018 15:58:04 +0200
Subject: [PATCH 2/5] nvme-rdma: use NVME_CTRL_CONNECTING state to mark init
 process
In-Reply-To: <1517147887-15645-1-git-send-email-maxg@mellanox.com>
References: <1517147887-15645-1-git-send-email-maxg@mellanox.com>
Message-ID: <1517147887-15645-3-git-send-email-maxg@mellanox.com>

In order to avoid concurrent error recovery during initialization
process (allowed by the NVME_CTRL_NEW --> NVME_CTRL_RESETTING transition)
we must mark the ctrl as CONNECTING before initial connection
establisment.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 1 +
 drivers/nvme/host/rdma.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c1a9706..1d7e304 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -296,6 +296,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		break;
 	case NVME_CTRL_CONNECTING:
 		switch (old_state) {
+		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
 			changed = true;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 219c6a0..d86aee7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1930,6 +1930,9 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	if (!ctrl->queues)
 		goto out_uninit_ctrl;
 
+	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
+	WARN_ON_ONCE(!changed);
+
 	ret = nvme_rdma_configure_admin_queue(ctrl, true);
 	if (ret)
 		goto out_kfree_queues;
-- 
1.8.3.1
