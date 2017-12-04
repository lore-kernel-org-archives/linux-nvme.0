From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  4 Dec 2017 10:47:09 +0200
Subject: [PATCH 1/2] nvmet: lower log level for each queue creation
Message-ID: <20171204084710.15828-1-sagi@grimberg.me>

Its a bit chatty to report on each queue, lets log
it only for debug purposes.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/fabrics-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 9e41904b0380..62315cc4b5b0 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -235,7 +235,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out_ctrl_put;
 	}
 
-	pr_info("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
+	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
 
 out:
 	kfree(d);
-- 
2.14.1
