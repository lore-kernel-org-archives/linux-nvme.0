From: hch@lst.de (Christoph Hellwig)
Date: Thu, 31 May 2018 18:23:48 +0200
Subject: [PATCH v2] nvmet: return all zeroed buffer when we can't find an
 active namespace
In-Reply-To: <20180530164525.26749-1-hch@lst.de>
References: <20180530164525.26749-1-hch@lst.de>
Message-ID: <20180531162348.GA30786@lst.de>

Quote from Figure 106 in NVMe 1.3a:

  The Identify Namespace data structure is returned to the host for the
  namespace specified in the Namespace Identifier (CDW1.NSID) field if it
  is an active NSID. If the specified namespace is not an active NSID,
  then the controller returns a zero filled data structure.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---

Changes since v1:
 - remove a leftover debug printk
 - fix whitespace damage

 drivers/nvme/target/admin-cmd.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index b2ba95b2eef7..64a12d4d7607 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -289,8 +289,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	struct nvme_id_ns *id;
 	u16 status = 0;
 
-	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
-	if (!ns) {
+	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
 		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 		goto out;
 	}
@@ -298,9 +297,14 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
 		status = NVME_SC_INTERNAL;
-		goto out_put_ns;
+		goto out;
 	}
 
+	/* return an all zeroed buffer if we can't find an active namespace */
+	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (!ns)
+		goto done;
+
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
 	 * that out from the underlying device.
@@ -325,11 +329,10 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
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
