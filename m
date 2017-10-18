From: jsmart2021@gmail.com (James Smart)
Date: Wed, 18 Oct 2017 14:33:59 -0700
Subject: [PATCH v4] nvmet: synchronize sqhd update
Message-ID: <20171018213359.3587-1-jsmart2021@gmail.com>

In testing target io in read write mix, we did indeed get into cases
where sqhd didn't update properly and slowly missed enough updates to
shutdown the queue.

Protect the updating sqhd by using cmpxchg

Signed-off-by: James Smart <james.smart at broadcom.com>

---
v2: move locks so around update and assignment
v3: convert to cmpxchg
v4: as u16 cmpxchg appears to not always be supported, convert sqhd to u32
---
 drivers/nvme/target/core.c  | 15 ++++++++++++---
 drivers/nvme/target/nvmet.h |  2 +-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cfc35cbb6fe2..a469f1996dca 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -387,12 +387,21 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
+	u32 old_sqhd, new_sqhd;
+	u16 sqhd;
+
 	if (status)
 		nvmet_set_status(req, status);
 
-	if (req->sq->size)
-		req->sq->sqhd = (req->sq->sqhd + 1) % req->sq->size;
-	req->rsp->sq_head = cpu_to_le16(req->sq->sqhd);
+	if (req->sq->size) {
+		do {
+			old_sqhd = req->sq->sqhd;
+			new_sqhd = (old_sqhd + 1) % req->sq->size;
+		} while (cmpxchg(&req->sq->sqhd, old_sqhd, new_sqhd) !=
+					old_sqhd);
+	}
+	sqhd = req->sq->sqhd & 0x0000FFFF;
+	req->rsp->sq_head = cpu_to_le16(sqhd);
 	req->rsp->sq_id = cpu_to_le16(req->sq->qid);
 	req->rsp->command_id = req->cmd->common.command_id;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ed38b44a7007..ebc1446e205e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -74,7 +74,7 @@ struct nvmet_sq {
 	struct percpu_ref	ref;
 	u16			qid;
 	u16			size;
-	u16			sqhd;
+	u32			sqhd;
 	struct completion	free_done;
 	struct completion	confirm_done;
 };
-- 
2.13.1
