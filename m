From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 12 Dec 2018 22:38:18 -0800
Subject: [PATCH v2 6/6] nvme-multipath: disable polling for underlying
 namespace request queue
In-Reply-To: <20181213063819.13614-1-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
Message-ID: <20181213063819.13614-7-sagi@grimberg.me>

Since the multipath device does not support polling (yet) we cannot
pass requests to the polling queue map as those will not generate
interrupt so we cannot reap the completion.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eb1c10b0eaf0..5a6c29ee669c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1550,6 +1550,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
+		/* multipath device does not support polling */
+		blk_queue_flag_clear(QUEUE_FLAG_POLL, ns->queue);
 	}
 #endif
 }
-- 
2.17.1
