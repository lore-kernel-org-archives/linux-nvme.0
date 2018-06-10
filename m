From: israelr@mellanox.com (Israel Rukshin)
Date: Sun, 10 Jun 2018 10:31:10 +0000
Subject: [PATCH] nvme: Fix NULL pointer dereference in nvme_init_subsystem
Message-ID: <1528626670-11813-1-git-send-email-israelr@mellanox.com>

When using nvme-pci driver the nvmf_ctrl_options is NULL.
There is no need to check for discovery_nqn flag at non-fabrics controller.

Fixes: 181303d0 ("nvme-fabrics: allow duplicate connections to the discovery controller")
Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c8b3006..0ab4c7a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2208,7 +2208,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		 * Verify that the subsystem actually supports multiple
 		 * controllers, else bail out.
 		 */
-		if (!ctrl->opts->discovery_nqn &&
+		if (!(ctrl->opts && ctrl->opts->discovery_nqn) &&
 		    nvme_active_ctrls(found) && !(id->cmic & (1 << 1))) {
 			dev_err(ctrl->device,
 				"ignoring ctrl due to duplicate subnqn (%s).\n",
-- 
1.8.3.1
