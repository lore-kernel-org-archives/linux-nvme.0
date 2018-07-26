From: hare@suse.de (Hannes Reinecke)
Date: Thu, 26 Jul 2018 12:57:02 +0200
Subject: [PATCH] nvme: drop WARN_ON() when processing ANA AEN
Message-ID: <20180726105702.80794-1-hare@suse.de>

We might be receiving ANA AENs at any time, so it might happen that
we're receiving an ANA AEN even before we have processed all ANA
information.
But this is nothing to worry about, and we can safely drop the
WARN_ON here.

Patch is relative to hchs nvme-ana tree.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 39bdfe806d1b..3b96ace1f86d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3382,10 +3382,11 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 		break;
 #ifdef CONFIG_NVME_MULTIPATH
 	case NVME_AER_NOTICE_ANA:
-		if (WARN_ON_ONCE(!ctrl->ana_log_buf))
+		if (ctrl->ana_log_buf) {
+			queue_work(nvme_wq, &ctrl->ana_work);
 			break;
-		queue_work(nvme_wq, &ctrl->ana_work);
-		break;
+		}
+		dev_warn(ctrl->device, "ANA disabled, skipping AEN\n");
 #endif
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
-- 
2.12.3
