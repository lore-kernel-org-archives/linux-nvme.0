From: jschoenh@amazon.de (=?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?=)
Date: Sun, 27 Aug 2017 15:56:37 +0200
Subject: [PATCH] nvme: fix uninitialized prp2 value on small transfers
Message-ID: <1503842197-29978-1-git-send-email-jschoenh@amazon.de>

The value of iod->first_dma ends up as prp2 in NVMe commands. In case
there is not enough data to cross a page boundary, iod->first_dma is
never initialized and contains random data.

Comply with the NVMe specification and fill in 0 in that case.

Signed-off-by: Jan H. Sch?nherr <jschoenh at amazon.de>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 925467b..4a41a65 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -555,8 +555,10 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
 	int nprps, i;
 
 	length -= (page_size - offset);
-	if (length <= 0)
+	if (length <= 0) {
+		iod->first_dma = 0;
 		return BLK_STS_OK;
+	}
 
 	dma_len -= (page_size - offset);
 	if (dma_len) {
-- 
2.3.1.dirty
