From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 17 Oct 2018 11:34:15 -0700
Subject: [PATCH] nvme-pci: remove duplicate check
Message-ID: <20181017183415.3373-1-chaitanya.kulkarni@wdc.com>

This is a cleanup patch doesn't change any functionality. It removes
the duplicate call to the blk_integrity_rq() in the nvme_map_data().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 72737009b82d..4e023cd007e1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -772,10 +772,10 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 
 		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
 			goto out_unmap;
-	}
 
-	if (blk_integrity_rq(req))
 		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(&iod->meta_sg));
+	}
+
 	return BLK_STS_OK;
 
 out_unmap:
-- 
2.17.0
