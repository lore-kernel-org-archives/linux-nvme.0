From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Apr 2017 10:50:03 +0200
Subject: [PATCH 5/7] nvmet/fc: mark the sqhd field as __le16
In-Reply-To: <20170421085005.5945-1-hch@lst.de>
References: <20170421085005.5945-1-hch@lst.de>
Message-ID: <20170421085005.5945-6-hch@lst.de>

That's what it's used as.

Found by sparse.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d504c52ac9cb..4392b514725b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -119,7 +119,7 @@ struct nvmet_fc_tgt_queue {
 	u16				qid;
 	u16				sqsize;
 	u16				ersp_ratio;
-	u16				sqhd;
+	__le16				sqhd;
 	int				cpu;
 	atomic_t			connected;
 	atomic_t			sqtail;
-- 
2.11.0
