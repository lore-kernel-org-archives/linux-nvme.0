From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Feb 2018 07:24:09 -0800
Subject: [PATCH 2/3] nvme-rdma: use blk_rq_payload_bytes instead of
 blk_rq_bytes
In-Reply-To: <20180222152410.19222-1-hch@lst.de>
References: <20180222152410.19222-1-hch@lst.de>
Message-ID: <20180222152410.19222-3-hch@lst.de>

blk_rq_bytes does the wrong thing for special payloads like discards and
might cause the driver to not set up a SGL.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3a51ed50eff2..4d84a73ee12d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1051,7 +1051,7 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
 
-	if (!blk_rq_bytes(rq))
+	if (!blk_rq_payload_bytes(rq))
 		return;
 
 	if (req->mr) {
@@ -1166,7 +1166,7 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 
 	c->common.flags |= NVME_CMD_SGL_METABUF;
 
-	if (!blk_rq_bytes(rq))
+	if (!blk_rq_payload_bytes(rq))
 		return nvme_rdma_set_sg_null(c);
 
 	req->sg_table.sgl = req->first_sgl;
-- 
2.14.2
