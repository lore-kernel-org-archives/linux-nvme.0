From: jsmart2021@gmail.com (James Smart)
Date: Wed, 18 Oct 2017 09:52:16 -0700
Subject: [PATCH v3] nvmet: synchronize sqhd update
Message-ID: <20171018165216.25563-1-jsmart2021@gmail.com>

In testing target io in read write mix, we did indeed get into cases
where sqhd didn't update properly and slowly missed enough updates to
shutdown the queue.

Protect the updating sqhd by using cmpxchg

Signed-off-by: James Smart <james.smart at broadcom.com>

---
v2: move locks so around update and assignment
v3: convert to cmpxchg
---
 drivers/nvme/target/core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cfc35cbb6fe2..72d02f871c03 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -387,11 +387,18 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
+	u16 old_sqhd, new_sqhd;
+
 	if (status)
 		nvmet_set_status(req, status);
 
-	if (req->sq->size)
-		req->sq->sqhd = (req->sq->sqhd + 1) % req->sq->size;
+	if (req->sq->size) {
+		do {
+			old_sqhd = req->sq->sqhd;
+			new_sqhd = (old_sqhd + 1) % req->sq->size;
+		} while (cmpxchg(&req->sq->sqhd, old_sqhd, new_sqhd) !=
+					old_sqhd);
+	}
 	req->rsp->sq_head = cpu_to_le16(req->sq->sqhd);
 	req->rsp->sq_id = cpu_to_le16(req->sq->qid);
 	req->rsp->command_id = req->cmd->common.command_id;
-- 
2.13.1
