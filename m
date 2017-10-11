From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 15:29:07 +0300
Subject: [PATCH 2/7] nvme-rdma: fix wrong logging message
In-Reply-To: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
References: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
Message-ID: <1507724952-13917-3-git-send-email-sagi@grimberg.me>

Not necessarily address resolution failed.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9e040bbc08c9..09f774abe5a8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -544,7 +544,7 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	ret = nvme_rdma_wait_for_cm(queue);
 	if (ret) {
 		dev_info(ctrl->ctrl.device,
-			"rdma_resolve_addr wait failed (%d).\n", ret);
+			"rdma connection establishment failed (%d)\n", ret);
 		goto out_destroy_cm_id;
 	}
 
-- 
2.7.4
