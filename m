From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  3 May 2016 17:22:36 +0200
Subject: [PATCH] lightnvm: pass dma address to hardware rather than pointer
Message-ID: <1462288968-763853-1-git-send-email-arnd@arndb.de>

A recent change to lightnvm added code to pass a kernel pointer
to the hardware, which gcc complained about:

drivers/nvme/host/lightnvm.c: In function 'nvme_nvm_rqtocmd':
drivers/nvme/host/lightnvm.c:472:32: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]
  c->ph_rw.metadata = cpu_to_le64(rqd->meta_list);

It looks like this has no way of working anyway, so this changes
the code to pass the dma_address instead. This was most likely
what was intended here. Neither of the two are currently ever
written to, so the effect is the same for now.

Signed-off-by: Arnd Bergmann <arnd at arndb.de>
Fixes: a34b1eb78e21 ("lightnvm: enable metadata to be sent to device")
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index fadeb54bc7df..65de1e56e59a 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -469,7 +469,7 @@ static inline void nvme_nvm_rqtocmd(struct request *rq, struct nvm_rq *rqd,
 	c->ph_rw.opcode = rqd->opcode;
 	c->ph_rw.nsid = cpu_to_le32(ns->ns_id);
 	c->ph_rw.spba = cpu_to_le64(rqd->ppa_addr.ppa);
-	c->ph_rw.metadata = cpu_to_le64(rqd->meta_list);
+	c->ph_rw.metadata = cpu_to_le64(rqd->dma_meta_list);
 	c->ph_rw.control = cpu_to_le16(rqd->flags);
 	c->ph_rw.length = cpu_to_le16(rqd->nr_pages - 1);
 
-- 
2.7.0
