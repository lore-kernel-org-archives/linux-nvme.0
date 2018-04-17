From: keith.busch@intel.com (Keith Busch)
Date: Tue, 17 Apr 2018 16:05:35 -0600
Subject: [PATCH] nvme: Set integrity flag for user passthrough commands
Message-ID: <20180417220535.14755-1-keith.busch@intel.com>

If the command a separate metadata buffer attached, the request needs
to have the integrity flag set so the driver knows to map it.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9df4f71e58ca..127a9cbf3314 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -764,6 +764,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 				ret = PTR_ERR(meta);
 				goto out_unmap;
 			}
+			req->cmd_flags |= REQ_INTEGRITY;
 		}
 	}
 
-- 
2.14.3
