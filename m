From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 31 Dec 2017 15:33:27 +0200
Subject: [PATCH 1/1] nvme: Modify the debug level for setting shutdown timeout
Message-ID: <1514727207-8460-1-git-send-email-maxg@mellanox.com>

When an NVMe controller reports RTD3 Entry Latency larger than
the value of shutdown_timeout module parameter, we update the
shutdown_timeout accordingly to honor RTD3 Entry Latency. Use an
Informational debug level instead of a Warning level for it.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e46e60..4643876 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2253,7 +2253,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 						 shutdown_timeout, 60);
 
 		if (ctrl->shutdown_timeout != shutdown_timeout)
-			dev_warn(ctrl->device,
+			dev_info(ctrl->device,
 				 "Shutdown timeout set to %u seconds\n",
 				 ctrl->shutdown_timeout);
 	} else
-- 
1.8.3.1
