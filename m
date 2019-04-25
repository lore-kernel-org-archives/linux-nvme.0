From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 24 Apr 2019 19:40:41 -0700
Subject: [PATCH 2/2] nvme-multipath: improve logging
In-Reply-To: <20190425024041.17657-1-chaitanya.kulkarni@wdc.com>
References: <20190425024041.17657-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190425024041.17657-3-chaitanya.kulkarni@wdc.com>

This patch improves the logging for nvme-multipath code.

Signed-off-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/multipath.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f0716f6ce41f..721aa2ea4363 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -81,6 +81,9 @@ void nvme_failover_req(struct request *req)
 		 * Reset the controller for any non-ANA error as we don't know
 		 * what caused the error.
 		 */
+		dev_info(ns->ctrl->device,
+			"nvme status 0x%04x, resetting controller\n",
+			status);
 		nvme_reset_ctrl(ns->ctrl);
 		break;
 	}
@@ -421,9 +424,13 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	unsigned *nr_change_groups = data;
 	struct nvme_ns *ns;
 
-	dev_info(ctrl->device, "ANA group %d: %s.\n",
+	if (desc->state < ARRAY_SIZE(nvme_ana_state_names))
+		dev_dbg(ctrl->device, "ANA group %d: %s.\n",
 			le32_to_cpu(desc->grpid),
 			nvme_ana_state_names[desc->state]);
+	else
+		dev_dbg(ctrl->device, "ANA group %d: unknown.\n",
+			le32_to_cpu(desc->grpid));
 
 	if (desc->state == NVME_ANA_CHANGE)
 		(*nr_change_groups)++;
-- 
2.17.0
