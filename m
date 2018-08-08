From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue,  7 Aug 2018 23:01:06 -0700
Subject: [PATCH V4 2/3] nvme-core: set gendisk read only based on nsattr
In-Reply-To: <20180808060107.5849-1-chaitanya.kulkarni@wdc.com>
References: <20180808060107.5849-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180808060107.5849-3-chaitanya.kulkarni@wdc.com>

NVMe 1.3 TP 4005 introduces new filed (NSATTR). This field indicates
whether given namespace is write protected or not. This patch sets the
gendisk associated with the namespace to read only based on the identify
namespace nsattr field.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 603fe59756fb..dd8ec1dd9219 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1484,6 +1484,12 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
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
