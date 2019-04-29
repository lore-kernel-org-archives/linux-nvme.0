From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 28 Apr 2019 20:24:42 -0700
Subject: [PATCH V2 3/3] nvme-multipath: improve logging
In-Reply-To: <20190429032442.5923-1-chaitanya.kulkarni@wdc.com>
References: <20190429032442.5923-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190429032442.5923-4-chaitanya.kulkarni@wdc.com>

From: Hannes Reinecke <hare@suse.com>

This patch improves the logging for nvme-multipath code.

Signed-off-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/multipath.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f0716f6ce41f..e4929b7b42f9 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -81,6 +81,9 @@ void nvme_failover_req(struct request *req)
 		 * Reset the controller for any non-ANA error as we don't know
 		 * what caused the error.
 		 */
+		dev_info(ns->ctrl->device,
+				"nvme-mp: status 0x%04x, resetting controller\n",
+				status);
 		nvme_reset_ctrl(ns->ctrl);
 		break;
 	}
@@ -421,7 +424,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	unsigned *nr_change_groups = data;
 	struct nvme_ns *ns;
 
-	dev_info(ctrl->device, "ANA group %d: %s.\n",
+	dev_dbg(ctrl->device, "ANA group %d: %s.\n",
 			le32_to_cpu(desc->grpid),
 			nvme_ana_state_names[desc->state]);
 
-- 
2.17.0
