From: bvanassche@acm.org (Bart Van Assche)
Date: Mon,  8 Oct 2018 14:28:53 -0700
Subject: [PATCH 15/16] nvmet-rdma: Declare local symbols static
In-Reply-To: <20181008212854.68310-1-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
Message-ID: <20181008212854.68310-16-bvanassche@acm.org>

This patch avoids that sparse complains about missing declarations.

Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/target/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 5becca88ccbe..bd265aceb90c 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -122,7 +122,7 @@ struct nvmet_rdma_device {
 	int			inline_page_count;
 };
 
-struct workqueue_struct *nvmet_rdma_delete_wq;
+static struct workqueue_struct *nvmet_rdma_delete_wq;
 static bool nvmet_rdma_use_srq;
 module_param_named(use_srq, nvmet_rdma_use_srq, bool, 0444);
 MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
-- 
2.19.0.605.g01d371f741-goog
