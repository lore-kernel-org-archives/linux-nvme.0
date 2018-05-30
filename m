From: hch@lst.de (Christoph Hellwig)
Date: Wed, 30 May 2018 18:45:25 +0200
Subject: [PATCH] nvmet: return all zeroed buffer when we can't find an active
 namespace
Message-ID: <20180530164525.26749-1-hch@lst.de>

Quote from Figure 106 in NVMe 1.3a:

  The Identify Namespace data structure is returned to the host for the
  namespace specified in the Namespace Identifier (CDW1.NSID) field if it
  is an active NSID. If the specified namespace is not an active NSID,
  then the controller returns a zero filled data structure.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/admin-cmd.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index b2ba95b2eef7..7f906e4ccc96 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -288,9 +288,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	struct nvmet_ns *ns;
 	struct nvme_id_ns *id;
 	u16 status = 0;
-
-	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
-	if (!ns) {
+	
+	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
 		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 		goto out;
 	}
@@ -298,7 +297,15 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
 		status = NVME_SC_INTERNAL;
-		goto out_put_ns;
+		goto out;
+	}
+
+	/* return an all zeroed buffer if we can't find an active namespace */
+	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (!ns) {
+		printk("nsid %d not found\n",
+			le32_to_cpu(req->cmd->identify.nsid));
+		goto done;
 	}
 
 	/*
@@ -325,11 +332,10 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	id->lbaf[0].ds = ns->blksize_shift;
 
+	nvmet_put_namespace(ns);
+done:
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
-
 	kfree(id);
-out_put_ns:
-	nvmet_put_namespace(ns);
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.17.0
