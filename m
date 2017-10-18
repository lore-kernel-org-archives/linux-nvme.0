From: dn3108@gmail.com (Minwoo Im)
Date: Wed, 18 Oct 2017 22:56:09 +0900
Subject: [PATCH] nvme-pci: fix typos in comments
Message-ID: <1508334969-16445-1-git-send-email-dn3108@gmail.com>

fixed comment typos in adapter_alloc_cq() and adapter_alloc_sq().
'the the' duplications are replaced with 'that the'.

Signed-off-by: Minwoo Im <dn3108 at gmail.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3f5a04c..5a055c8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -930,7 +930,7 @@ static int adapter_alloc_cq(struct nvme_dev *dev, u16 qid,
 	int flags = NVME_QUEUE_PHYS_CONTIG | NVME_CQ_IRQ_ENABLED;
 
 	/*
-	 * Note: we (ab)use the fact the the prp fields survive if no data
+	 * Note: we (ab)use the fact that the prp fields survive if no data
 	 * is attached to the request.
 	 */
 	memset(&c, 0, sizeof(c));
@@ -951,7 +951,7 @@ static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
 	int flags = NVME_QUEUE_PHYS_CONTIG;
 
 	/*
-	 * Note: we (ab)use the fact the the prp fields survive if no data
+	 * Note: we (ab)use the fact that the prp fields survive if no data
 	 * is attached to the request.
 	 */
 	memset(&c, 0, sizeof(c));
-- 
2.7.4
