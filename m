From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Tue, 9 May 2017 12:34:50 +0300
Subject: [PATCH] lightnvm: Remove an unused variable
Message-ID: <20170509093450.dgj3qghdwefpg6li@mwanda>

"rq" is never used in nvme_nvm_rqtocmd().  We also recently shifted some
code around so it's uninitialized and causes a static checker warning.
Let's just remove it.

Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8c4adac6fafc..765f07669ae3 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -464,8 +464,8 @@ static int nvme_nvm_set_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr *ppas,
 	return ret;
 }
 
-static inline void nvme_nvm_rqtocmd(struct request *rq, struct nvm_rq *rqd,
-				struct nvme_ns *ns, struct nvme_nvm_command *c)
+static inline void nvme_nvm_rqtocmd(struct nvm_rq *rqd,	struct nvme_ns *ns,
+				    struct nvme_nvm_command *c)
 {
 	c->ph_rw.opcode = rqd->opcode;
 	c->ph_rw.nsid = cpu_to_le32(ns->ns_id);
@@ -503,7 +503,7 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd)
 	if (!cmd)
 		return -ENOMEM;
 
-	nvme_nvm_rqtocmd(rq, rqd, ns, cmd);
+	nvme_nvm_rqtocmd(rqd, ns, cmd);
 
 	rq = nvme_alloc_request(q, (struct nvme_command *)cmd, 0, NVME_QID_ANY);
 	if (IS_ERR(rq)) {
