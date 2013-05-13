From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 13 May 2013 22:29:04 +0800
Subject: [PATCH v2] NVMe: fix error return code in nvme_submit_bio_queue()
Message-ID: <CAPgLHd8a0UuopsM53j5NsZz1UaqZoRK0_aK2m=XqC2iv-i9rAw@mail.gmail.com>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fix to return -ENOMEM in the nvem iod alloc error handling case instead
of 0(possible overwrite to 0 by above nvme_submit_flush_data()), as done
elsewhere in this function.

Signed-off-by: Wei Yongjun <yongjun_wei at trendmicro.com.cn>
---
v1 -> v2: send to mail list from MAINTAINERS
---
 drivers/block/nvme-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 8efdfaa..750c337 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -629,7 +629,7 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	struct nvme_command *cmnd;
 	struct nvme_iod *iod;
 	enum dma_data_direction dma_dir;
-	int cmdid, length, result = -ENOMEM;
+	int cmdid, length, result;
 	u16 control;
 	u32 dsmgmt;
 	int psegs = bio_phys_segments(ns->queue, bio);
@@ -641,8 +641,10 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	}
 
 	iod = nvme_alloc_iod(psegs, bio->bi_size, GFP_ATOMIC);
-	if (!iod)
+	if (!iod) {
+		result = -ENOMEM;
 		goto nomem;
+	}
 	iod->private = bio;
 
 	result = -EBUSY;
