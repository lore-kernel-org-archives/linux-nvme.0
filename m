From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu,  2 Aug 2018 14:10:59 -0700
Subject: [PATCH V3 2/3] nvme-core: set gendisk read only based on nsattr
In-Reply-To: <20180802211100.8404-1-chaitanya.kulkarni@wdc.com>
References: <20180802211100.8404-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180802211100.8404-3-chaitanya.kulkarni@wdc.com>

NVMe 1.3 TP 4005 introduces new filed (NSATTR). This field indicates
whether given namespace is write protected or not. This patch sets the
gendisk associated with the namespace to read only based on the identify
namespace nsattr field structure to set the.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e62592c949ab..4b785ae2fa2e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1452,6 +1452,12 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	set_capacity(disk, capacity);
 	nvme_config_discard(ns);
+
+	if (id->nsattr & (1 << 0))
+		set_disk_ro(disk, true);
+	else
+		set_disk_ro(disk, false);
+
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
-- 
2.17.0
