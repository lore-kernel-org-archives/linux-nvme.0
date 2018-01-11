From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Thu, 11 Jan 2018 13:09:39 +0800
Subject: [PATCH] nvme-pci: calculate iod and avg_seg_size just before use them
Message-ID: <1515647379-1877-1-git-send-email-jianchao.w.wang@oracle.com>

The calculation of iod and avg_seg_size maybe meaningless if
nvme_pci_use_sgls returns before uses them. So calculate
just before use them.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0530432..733b4f4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -772,16 +772,19 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 {
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_iod *iod;
 	unsigned int avg_seg_size;
 
-	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req),
-			blk_rq_nr_phys_segments(req));
-
 	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1))))
 		return false;
+
+	iod = blk_mq_rq_to_pdu(req);
 	if (!iod->nvmeq->qid)
 		return false;
+
+	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req),
+			blk_rq_nr_phys_segments(req));
+
 	if (!sgl_threshold || avg_seg_size < sgl_threshold)
 		return false;
 	return true;
-- 
2.7.4
