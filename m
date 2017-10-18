From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Oct 2017 14:07:42 +0300
Subject: [PATCH 3/5] nvme-rdma: remove redundant check if the ctrl is in the
 ctrl when freeing it
In-Reply-To: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
References: <1508324864-23087-1-git-send-email-sagi@grimberg.me>
Message-ID: <1508324864-23087-4-git-send-email-sagi@grimberg.me>

From: Roy Shterman <roys@lightbitslabs.com>

Its no longer acceptable now that we do not invoke ->free_ctrl
from inside ->create_ctrl.

Signed-off-by: Roy Shterman <roys at lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 866abee2374d..03a3f0372450 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -875,16 +875,12 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	if (list_empty(&ctrl->list))
-		goto free_ctrl;
-
 	mutex_lock(&nvme_rdma_ctrl_mutex);
 	list_del(&ctrl->list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
 	kfree(ctrl->queues);
 	nvmf_free_options(nctrl->opts);
-free_ctrl:
 	kfree(ctrl);
 }
 
-- 
2.7.4
