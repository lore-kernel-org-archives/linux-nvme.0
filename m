From: sashal@kernel.org (Sasha Levin)
Date: Thu, 18 Jul 2019 23:56:10 -0400
Subject: [PATCH AUTOSEL 5.2 139/171] nvme-tcp: set the STABLE_WRITES flag when
 data digests are enabled
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
Message-ID: <20190719035643.14300-139-sashal@kernel.org>

From: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>

[ Upstream commit 958f2a0f8121ae36a5cbff383ab94fadf1fba5eb ]

There was a few false alarms sighted on target side about wrong data
digest while performing high throughput load to XFS filesystem shared
through NVMoF TCP.

This flag tells the rest of the kernel to ensure that the data buffer
does not change while the write is in flight.  It incurs a performance
penalty, so only enable it when it is actually needed, i.e. when we are
calculating data digests.

Although even with this change in place, ext2 users can steel experience
false positives, as ext2 is not respecting this flag. This may be apply
to vfat as well.

Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
Signed-off-by: Mike Playle <mplayle at solarflare.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 120fb593d1da..b4048748551e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -11,6 +11,7 @@
 #include <linux/hdreg.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/backing-dev.h>
 #include <linux/list_sort.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -3256,6 +3257,10 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		goto out_free_ns;
 	}
 
+	if (ctrl->opts->data_digest)
+		ns->queue->backing_dev_info->capabilities
+			|= BDI_CAP_STABLE_WRITES;
+
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
 	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
 		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
-- 
2.20.1
