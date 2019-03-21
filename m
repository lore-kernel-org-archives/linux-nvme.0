From: hch@lst.de (Christoph Hellwig)
Date: Thu, 21 Mar 2019 16:10:31 -0700
Subject: [PATCH 09/15] nvme-pci: only call nvme_unmap_data for requests
 transferring data
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
Message-ID: <20190321231037.25104-10-hch@lst.de>

This mirrors how nvme_map_pci is called and will allow simplifying some
checks in nvme_unmap_pci later on.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ce8bdc15ec3c..bc4ee869fe82 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -929,7 +929,8 @@ static void nvme_pci_complete_rq(struct request *req)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
 	nvme_cleanup_cmd(req);
-	nvme_unmap_data(iod->nvmeq->dev, req);
+	if (blk_rq_nr_phys_segments(req))
+		nvme_unmap_data(iod->nvmeq->dev, req);
 	nvme_complete_rq(req);
 }
 
-- 
2.20.1
