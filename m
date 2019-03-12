From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Mar 2019 16:24:52 +0100
Subject: [PATCH 2/3] nvme: add proper discard setup for the multipath device
In-Reply-To: <20190312152453.9550-1-hch@lst.de>
References: <20190312152453.9550-1-hch@lst.de>
Message-ID: <20190312152453.9550-3-hch@lst.de>

Add a gendisk argument to nvme_config_discard so that the call to
nvme_update_disk_info for the multipath device node updates the
proper request_queue.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reported-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 724ac6075901..b3c13a486423 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1495,10 +1495,10 @@ static void nvme_set_chunk_size(struct nvme_ns *ns)
 	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
 }
 
-static void nvme_config_discard(struct nvme_ns *ns)
+static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
-	struct request_queue *queue = ns->queue;
+	struct request_queue *queue = disk->queue;
 	u32 size = queue_logical_block_size(queue);
 
 	if (!(ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
@@ -1615,7 +1615,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	set_capacity(disk, capacity);
 
-	nvme_config_discard(ns);
+	nvme_config_discard(disk, ns);
 	nvme_config_write_zeroes(ns);
 
 	if (id->nsattr & (1 << 0))
-- 
2.20.1
