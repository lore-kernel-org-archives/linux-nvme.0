From: xerofoify@gmail.com (Nicholas Krause)
Date: Thu,  6 Aug 2015 14:53:15 -0400
Subject: [PATCH] nvme:Fix error handling in the function nvme_init_integrity
Message-ID: <1438887195-3955-1-git-send-email-xerofoify@gmail.com>

This fixes error handling in the function nvme_init_integrity
by checking if the call to the function blck_integrity_register
has failed by returning a error code and if so tell the user
with dev_err that making this device integrity capable has failed
before returning immediately to the caller of the function
nvme_init_integriy as we cannot continue this function's work

Signed-off-by: Nicholas Krause <xerofoify at gmail.com>
---
 drivers/block/nvme-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..b4bff81 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -572,7 +572,10 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 		break;
 	}
 	integrity.tuple_size = ns->ms;
-	blk_integrity_register(ns->disk, &integrity);
+	if (blk_integrity_register(ns->disk, &integrity)) {
+		dev_err(ns->dev->device, "Failed to make this device integrity capable\n");
+		return;
+	}
 	blk_queue_max_integrity_segments(ns->queue, 1);
 }
 #else /* CONFIG_BLK_DEV_INTEGRITY */
-- 
2.1.4
