From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 31 Dec 2018 23:58:30 -0800
Subject: [PATCH 2/2] nvme-tcp: don't ask if controller is fabrics
In-Reply-To: <20190101075830.27560-1-sagi@grimberg.me>
References: <20190101075830.27560-1-sagi@grimberg.me>
Message-ID: <20190101075830.27560-3-sagi@grimberg.me>

For sure we are a fabric driver.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/tcp.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a9f1469509af..a2b80e9cd060 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1565,8 +1565,7 @@ static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool remove)
 {
 	nvme_tcp_stop_io_queues(ctrl);
 	if (remove) {
-		if (ctrl->ops->flags & NVME_F_FABRICS)
-			blk_cleanup_queue(ctrl->connect_q);
+		blk_cleanup_queue(ctrl->connect_q);
 		blk_mq_free_tag_set(ctrl->tagset);
 	}
 	nvme_tcp_free_io_queues(ctrl);
@@ -1587,12 +1586,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			goto out_free_io_queues;
 		}
 
-		if (ctrl->ops->flags & NVME_F_FABRICS) {
-			ctrl->connect_q = blk_mq_init_queue(ctrl->tagset);
-			if (IS_ERR(ctrl->connect_q)) {
-				ret = PTR_ERR(ctrl->connect_q);
-				goto out_free_tag_set;
-			}
+		ctrl->connect_q = blk_mq_init_queue(ctrl->tagset);
+		if (IS_ERR(ctrl->connect_q)) {
+			ret = PTR_ERR(ctrl->connect_q);
+			goto out_free_tag_set;
 		}
 	} else {
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
@@ -1606,7 +1603,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	return 0;
 
 out_cleanup_connect_q:
-	if (new && (ctrl->ops->flags & NVME_F_FABRICS))
+	if (new)
 		blk_cleanup_queue(ctrl->connect_q);
 out_free_tag_set:
 	if (new)
-- 
2.17.1
