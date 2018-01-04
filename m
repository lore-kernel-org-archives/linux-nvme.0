From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu,  4 Jan 2018 17:56:14 +0200
Subject: [PATCH 2/2] nvme: Fix subsystem multiple controllers support check
In-Reply-To: <1515081374-22328-1-git-send-email-maxg@mellanox.com>
References: <1515081374-22328-1-git-send-email-maxg@mellanox.com>
Message-ID: <1515081374-22328-2-git-send-email-maxg@mellanox.com>

From: Israel Rukshin <israelr@mellanox.com>

There is a problem when another module (e.g. nvmet) takes
a refcount on the nvme block device and the physical nvme drive is removed.
In that case nvme_free_ctrl() will not be called and the controller state
will be "deleting" or "dead" unless nvmet module releases the block device.
Later on, the same nvme drive probes back and nvme_init_subsystem() will be
called and fail due to duplicate subnqn (if the nvme device doesn't support
subsystem with multiple controllers). This will cause a probe failure.
This commit changes the check of multiple controllers support at
nvme_init_subsystem() by not counting all the controllers at "dead" or
"deleting" state (this is safe because controllers at this state will never
be active again).

Fixes: ab9e00cc72fa ("nvme: track subsystems")
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Israel Rukshin <israelr at mellanox.com>
---
 drivers/nvme/host/core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb6b08e..f6dfdd3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2063,6 +2063,22 @@ static ssize_t nvme_subsys_show_nqn(struct device *dev,
 	NULL,
 };
 
+static int nvme_active_ctrls(struct nvme_subsystem *subsys)
+{
+	int count = 0;
+	struct nvme_ctrl *ctrl;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl->state != NVME_CTRL_DELETING &&
+		    ctrl->state != NVME_CTRL_DEAD)
+			count++;
+	}
+	mutex_unlock(&subsys->lock);
+
+	return count;
+}
+
 static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	struct nvme_subsystem *subsys, *found;
@@ -2101,7 +2117,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		 * Verify that the subsystem actually supports multiple
 		 * controllers, else bail out.
 		 */
-		if (!(id->cmic & (1 << 1))) {
+		if (nvme_active_ctrls(found) && !(id->cmic & (1 << 1))) {
 			dev_err(ctrl->device,
 				"ignoring ctrl due to duplicate subnqn (%s).\n",
 				found->subnqn);
-- 
1.8.3.1
