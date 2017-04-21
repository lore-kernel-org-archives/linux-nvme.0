From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Apr 2017 10:50:01 +0200
Subject: [PATCH 3/7] nvmet/fc: mark nvmet_fc_handle_fcp_rqst static
In-Reply-To: <20170421085005.5945-1-hch@lst.de>
References: <20170421085005.5945-1-hch@lst.de>
Message-ID: <20170421085005.5945-4-hch@lst.de>

Found by sparse.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 074bd3743b5f..3626dd8cc8a1 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2055,7 +2055,7 @@ nvmet_fc_fcp_nvme_cmd_done(struct nvmet_req *nvme_req)
 /*
  * Actual processing routine for received FC-NVME LS Requests from the LLD
  */
-void
+static void
 nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 			struct nvmet_fc_fcp_iod *fod)
 {
-- 
2.11.0
