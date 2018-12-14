From: colin.king@canonical.com (Colin King)
Date: Fri, 14 Dec 2018 11:42:43 +0000
Subject: [PATCH][next] nvme-tcp: fix spelling mistake "attepmpt" -> "attempt"
Message-ID: <20181214114243.10675-1-colin.king@canonical.com>

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_info message, fix it.

Signed-off-by: Colin Ian King <colin.king at canonical.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 51826479a41e..f451cb21925c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1789,7 +1789,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	if (nvme_tcp_setup_ctrl(ctrl, false))
 		goto requeue;
 
-	dev_info(ctrl->device, "Successfully reconnected (%d attepmpt)\n",
+	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
 			ctrl->nr_reconnects);
 
 	ctrl->nr_reconnects = 0;
-- 
2.19.1
