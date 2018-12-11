From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 15:36:51 -0800
Subject: [PATCH RFC 4/4] nvme-multipath: disable polling for underlying
 namespace request queue
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
Message-ID: <20181211233652.9705-5-sagi@grimberg.me>

Since the multipath device does not support polling (yet) we cannot
pass requests to the polling queue map as those will not generate
interrupt so we cannot reap the completion.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f90576862736..511d399a6002 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1547,6 +1547,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
+		/* XXX: multipath device does not support polling for now... */
+		blk_queue_flag_clear(QUEUE_FLAG_POLL, ns->queue);
 	}
 #endif
 }
-- 
2.17.1
