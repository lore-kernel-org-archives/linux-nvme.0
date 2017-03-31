From: hch@lst.de (Christoph Hellwig)
Date: Fri, 31 Mar 2017 17:00:05 +0200
Subject: [PATCH 1/4] nvme: add missing byte swap in nvme_setup_discard
In-Reply-To: <20170331150008.16034-1-hch@lst.de>
References: <20170331150008.16034-1-hch@lst.de>
Message-ID: <20170331150008.16034-2-hch@lst.de>

Fixes: b35ba01e ("nvme: support ranged discard requests")
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b3b57fef446..9583a5f58a1d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -270,7 +270,7 @@ static inline int nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->dsm.opcode = nvme_cmd_dsm;
 	cmnd->dsm.nsid = cpu_to_le32(ns->ns_id);
-	cmnd->dsm.nr = segments - 1;
+	cmnd->dsm.nr = cpu_to_le32(segments - 1);
 	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
 
 	req->special_vec.bv_page = virt_to_page(range);
-- 
2.11.0
