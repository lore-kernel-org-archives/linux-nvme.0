From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 15:35:14 -0800
Subject: [PATCH v2 1/5] blk-mq-rdma: pass in queue map to
 blk_mq_rdma_map_queues
In-Reply-To: <20181211233519.9350-1-sagi@grimberg.me>
References: <20181211233519.9350-1-sagi@grimberg.me>
Message-ID: <20181211233519.9350-2-sagi@grimberg.me>

will be used by nvme-rdma for queue map separation support.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 block/blk-mq-rdma.c         | 8 ++++----
 drivers/nvme/host/rdma.c    | 2 +-
 include/linux/blk-mq-rdma.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index a71576aff3a5..45030a81a1ed 100644
--- a/block/blk-mq-rdma.c
+++ b/block/blk-mq-rdma.c
@@ -29,24 +29,24 @@
  * @set->nr_hw_queues, or @dev does not provide an affinity mask for a
  * vector, we fallback to the naive mapping.
  */
-int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
+int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
 		struct ib_device *dev, int first_vec)
 {
 	const struct cpumask *mask;
 	unsigned int queue, cpu;
 
-	for (queue = 0; queue < set->nr_hw_queues; queue++) {
+	for (queue = 0; queue < map->nr_queues; queue++) {
 		mask = ib_get_vector_affinity(dev, first_vec + queue);
 		if (!mask)
 			goto fallback;
 
 		for_each_cpu(cpu, mask)
-			set->map[0].mq_map[cpu] = queue;
+			map->mq_map[cpu] = map->queue_offset + queue;
 	}
 
 	return 0;
 
 fallback:
-	return blk_mq_map_queues(&set->map[0]);
+	return blk_mq_map_queues(map);
 }
 EXPORT_SYMBOL_GPL(blk_mq_rdma_map_queues);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f2db848f6985..5057d5ab5aaa 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1751,7 +1751,7 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_rdma_ctrl *ctrl = set->driver_data;
 
-	return blk_mq_rdma_map_queues(set, ctrl->device->dev, 0);
+	return blk_mq_rdma_map_queues(&set->map[0], ctrl->device->dev, 0);
 }
 
 static const struct blk_mq_ops nvme_rdma_mq_ops = {
diff --git a/include/linux/blk-mq-rdma.h b/include/linux/blk-mq-rdma.h
index b4ade198007d..7b6ecf9ac4c3 100644
--- a/include/linux/blk-mq-rdma.h
+++ b/include/linux/blk-mq-rdma.h
@@ -4,7 +4,7 @@
 struct blk_mq_tag_set;
 struct ib_device;
 
-int blk_mq_rdma_map_queues(struct blk_mq_tag_set *set,
+int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
 		struct ib_device *dev, int first_vec);
 
 #endif /* _LINUX_BLK_MQ_RDMA_H */
-- 
2.17.1
