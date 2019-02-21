From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 20 Feb 2019 20:13:34 -0800
Subject: [PATCH 1/2] nvme-rdma: use nr_phys_segments when map rq to sgl
In-Reply-To: <20190221041335.22806-1-chaitanya.kulkarni@wdc.com>
References: <20190221041335.22806-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190221041335.22806-2-chaitanya.kulkarni@wdc.com>

Use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes() to check
if a command contains data to be mapped.  This fixes the case where
a struct request contains LBAs, but it has no payload, such as
Write Zeroes support.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ac365366c2ec..c6a489049fd5 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1150,7 +1150,7 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
 
-	if (!blk_rq_payload_bytes(rq))
+	if (!blk_rq_nr_phys_segments(rq))
 		return;
 
 	if (req->mr) {
@@ -1273,7 +1273,7 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 
 	c->common.flags |= NVME_CMD_SGL_METABUF;
 
-	if (!blk_rq_payload_bytes(rq))
+	if (!blk_rq_nr_phys_segments(rq))
 		return nvme_rdma_set_sg_null(c);
 
 	req->sg_table.sgl = req->first_sgl;
-- 
2.17.0
