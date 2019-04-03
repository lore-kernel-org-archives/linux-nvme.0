From: hare@suse.de (Hannes Reinecke)
Date: Thu,  4 Apr 2019 00:41:58 +0200
Subject: [PATCH 2/2] nvme: validate cntlid during controller initialisation
In-Reply-To: <20190403224158.58106-1-hare@suse.de>
References: <20190403224158.58106-1-hare@suse.de>
Message-ID: <20190403224158.58106-3-hare@suse.de>

From: Hannes Reinecke <hare@suse.com>

The CNTLID value is required to be unique, and we do rely on this
for correct operation. So reject any controller for which a non-unique
CNTLID has been detected.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b5939112b9b6..23000a368e1f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2485,6 +2485,7 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
 int nvme_init_identify(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
+	struct nvme_ctrl *tmp;
 	u64 cap;
 	int ret, page_shift;
 	u32 max_hw_sectors;
@@ -2624,7 +2625,20 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
 	}
 
-	ret = nvme_mpath_init(ctrl, id);
+	ret = 0;
+	mutex_lock(&ctrl->subsys->lock);
+	list_for_each_entry(tmp, &ctrl->subsys->ctrls, subsys_entry) {
+		if (tmp->cntlid == ctrl->cntlid) {
+			dev_err(ctrl->device, "Duplicate cntlid %u, rejecting\n",
+				ctrl->cntlid);
+			ret = -EINVAL;
+			break;
+		}
+	}
+	mutex_unlock(&ctrl->subsys->lock);
+
+	if (ret == 0)
+		ret = nvme_mpath_init(ctrl, id);
 	kfree(id);
 
 	if (ret < 0)
-- 
2.16.4
