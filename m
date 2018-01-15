From: keith.busch@intel.com (Keith Busch)
Date: Mon, 15 Jan 2018 06:07:23 -0700
Subject: [PATCH] nvme/pci: Check segement valid for SGL use
Message-ID: <20180115130723.31469-1-keith.busch@intel.com>

The driver needs to verify there is a payload with a command before
seeing if it should use SGLs to map it.

Fixes: 955b1b5a00ba ("nvme-pci: move use_sgl initialization to nvme_init_iod()")

Reported-by: Paul Menzel <pmenzel+linux-nvme at molgen.mpg.de>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d53550e612bc..a7e94cc3c70e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -451,10 +451,13 @@ static void **nvme_pci_iod_list(struct request *req)
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	int nseg = blk_rq_nr_phys_segments(req);
 	unsigned int avg_seg_size;
 
-	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req),
-			blk_rq_nr_phys_segments(req));
+	if (nseg == 0)
+		return false;
+
+	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
 
 	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1))))
 		return false;
-- 
2.13.6
