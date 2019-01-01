From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 31 Dec 2018 23:58:29 -0800
Subject: [PATCH 1/2] nvme-tcp: remove dead code
In-Reply-To: <20190101075830.27560-1-sagi@grimberg.me>
References: <20190101075830.27560-1-sagi@grimberg.me>
Message-ID: <20190101075830.27560-2-sagi@grimberg.me>

we should never touch the opal device from the transport
driver.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b4eed8bcbef5..a9f1469509af 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1620,7 +1620,6 @@ static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
 {
 	nvme_tcp_stop_queue(ctrl, 0);
 	if (remove) {
-		free_opal_dev(ctrl->opal_dev);
 		blk_cleanup_queue(ctrl->admin_q);
 		blk_mq_free_tag_set(ctrl->admin_tagset);
 	}
-- 
2.17.1
