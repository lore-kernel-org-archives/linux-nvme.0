From: joshi.k@samsung.com (Kanchan Joshi)
Date: Thu, 25 Apr 2019 16:50:00 +0530
Subject: [PATCH v5 5/7] nvme: register stream info with block layer
In-Reply-To: <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
References: <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <CGME20190425112403epcas1p13006198cda351a08c8403c2b85c9f102@epcas1p1.samsung.com>
Message-ID: <1556191202-3245-6-git-send-email-joshi.k@samsung.com>

Make nvme driver register number of streams with block layer. Block
layer will use that for write-hint to stream-id conversion. Registration
is done for each namespace. Since NVMe spec allow all available
streams (within subsystem) to be used by all namespaces, no attempt
has been made to add reservation at namespace level.
Also driver no longer disables stream feature if device reported less
than 4 streams. Any write-hint beyond exported number of streams will
be mapped to 0 by block layer.
Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 drivers/nvme/host/core.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3000d9..81b86fa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -464,10 +464,6 @@ static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, 0);
 }
 
-static int nvme_disable_streams(struct nvme_ctrl *ctrl)
-{
-	return nvme_toggle_streams(ctrl, false);
-}
 
 static int nvme_enable_streams(struct nvme_ctrl *ctrl)
 {
@@ -510,14 +506,7 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
 		return ret;
 
 	ctrl->nssa = le16_to_cpu(s.nssa);
-	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
-		dev_info(ctrl->device, "too few streams (%u) available\n",
-					ctrl->nssa);
-		nvme_disable_streams(ctrl);
-		return 0;
-	}
-
-	ctrl->nr_streams = min_t(unsigned, ctrl->nssa, BLK_MAX_WRITE_HINTS - 1);
+	ctrl->nr_streams = ctrl->nssa;
 	dev_info(ctrl->device, "Using %u streams\n", ctrl->nr_streams);
 	return 0;
 }
@@ -3186,6 +3175,7 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 {
 	struct streams_directive_params s;
 	int ret;
+	u16 nr_streams;
 
 	if (!ctrl->nr_streams)
 		return 0;
@@ -3197,6 +3187,8 @@ static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 	ns->sws = le32_to_cpu(s.sws);
 	ns->sgs = le16_to_cpu(s.sgs);
 
+	nr_streams = min_t(unsigned, ctrl->nr_streams, BLK_MAX_WRITE_HINTS - 1);
+	blk_queue_stream_limits(ns->queue, nr_streams);
 	if (ns->sws) {
 		unsigned int bs = 1 << ns->lba_shift;
 
-- 
2.7.4
