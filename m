From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Sun,  7 May 2017 16:14:44 +0200
Subject: [PATCH] lightnvm: remove unused rq parameter of nvme_nvm_rqtocmd() to
 kill warning
Message-ID: <1494166484-11363-1-git-send-email-geert@linux-m68k.org>

With gcc 4.1.2:

    drivers/nvme/host/lightnvm.c: In function ?nvme_nvm_submit_io?:
    drivers/nvme/host/lightnvm.c:498: warning: ?rq? is used uninitialized in this function

Indeed, since commit 2e13f33a2464fc3a ("lightnvm: create cmd before
allocating request"), the request is passed to nvme_nvm_rqtocmd() before
it is allocated.

Fortunately, as of commit 91276162de9476b8 ("lightnvm: refactor end_io
functions for sync"), nvme_nvm_rqtocmd () no longer uses the passed
request, so this warning is a false positive.

Drop the unused parameter to clean up the code and kill the warning.

Fixes: 2e13f33a2464fc3a ("lightnvm: create cmd before allocating request")
Fixes: 91276162de9476b8 ("lightnvm: refactor end_io functions for sync")
Signed-off-by: Geert Uytterhoeven <geert at linux-m68k.org>
---
Perhaps nvme_nvm_rqtocmd() should be renamed, too?
---
 drivers/nvme/host/lightnvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8c4adac6fafcc56d..206bfdbc1c982b04 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -464,8 +464,8 @@ static int nvme_nvm_set_bb_tbl(struct nvm_dev *nvmdev, struct ppa_addr *ppas,
 	return ret;
 }
 
-static inline void nvme_nvm_rqtocmd(struct request *rq, struct nvm_rq *rqd,
-				struct nvme_ns *ns, struct nvme_nvm_command *c)
+static inline void nvme_nvm_rqtocmd(struct nvm_rq *rqd, struct nvme_ns *ns,
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
-- 
2.7.4
