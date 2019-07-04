From: mskorzhinskiy@solarflare.com (Mikhail Skorzhinskii)
Date: Thu, 4 Jul 2019 09:59:18 +0200
Subject: [PATCH 2/3] nvme-tcp: set the STABLE_WRITES flag when data digests
 are enabled
In-Reply-To: <cover.1562234605.git.mskorzhinskiy@solarflare.com>
References: <cover.1562234605.git.mskorzhinskiy@solarflare.com>
Message-ID: <468b110203ae91cdea1bbe84176332472bf206fb.1562234605.git.mskorzhinskiy@solarflare.com>

There was a few false alarms sighted on target side about wrong data digest
while performing high throughput load to XFS filesystem shared through
NVMoF TCP.

This flag tells[1] the rest of the kernel to ensure that the data buffer
does not change while the write is in flight. It incurs a performance
penalty, so only enable it when it is actually needed, i.e. when we are
calculating data digests.

Although even with this change in place[2], ext2 users can steel experience
false positives, as ext2 is not respecting this flag. This may be apply to
vfat as well.

References:

[1] https://lwn.net/Articles/528031/
[2] https://www.redhat.com/archives/dm-devel/2015-May/msg00158.html

Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
Signed-off-by: Mike Playle <mplayle at solarflare.com>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5417110cbf1b..f4340dc1d399 100644
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
@@ -3304,6 +3305,10 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
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
2.16.4
