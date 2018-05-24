From: hare@suse.de (Hannes Reinecke)
Date: Thu, 24 May 2018 16:18:17 +0200
Subject: [PATCH 3/3] nvme: allow duplicate connections to the discovery
 controller
In-Reply-To: <20180524141817.127576-1-hare@suse.de>
References: <20180524141817.127576-1-hare@suse.de>
Message-ID: <20180524141817.127576-4-hare@suse.de>

The whole point of the discovery controller is that it can accept
multiple connections. Additionally the cmic field is not even defined for
the discovery controller identify page.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c    | 3 ++-
 drivers/nvme/host/fabrics.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 10b180b8ccf4..28ac580b07e5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2494,7 +2494,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		 * Verify that the subsystem actually supports multiple
 		 * controllers, else bail out.
 		 */
-		if (nvme_active_ctrls(found) && !(id->cmic & (1 << 1))) {
+		if (!ctrl->opts->discovery_nqn &&
+		    nvme_active_ctrls(found) && !(id->cmic & (1 << 1))) {
 			dev_err(ctrl->device,
 				"ignoring ctrl due to duplicate subnqn (%s).\n",
 				found->subnqn);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 997d8677ab44..a29b0f00a88d 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -858,6 +858,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	if (opts->discovery_nqn) {
 		opts->kato = 0;
 		opts->nr_io_queues = 0;
+		opts->duplicate_connect = true;
 	}
 	if (ctrl_loss_tmo < 0)
 		opts->max_reconnects = -1;
-- 
2.12.3
