From: israelr@mellanox.com (Israel Rukshin)
Date: Tue, 10 Oct 2017 14:40:30 +0300
Subject: [PATCH 1/4] nvmet: Add port pointer to nvmet_ctrl structure
In-Reply-To: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
References: <1507635633-16665-1-git-send-email-israelr@mellanox.com>
Message-ID: <1507635633-16665-2-git-send-email-israelr@mellanox.com>

The ctrl is the "engine" of the subsystem per port, so link them
for future usage.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/core.c  | 1 +
 drivers/nvme/target/nvmet.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 1b208be..08270c1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -819,6 +819,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		/* keep-alive timeout in seconds */
 		ctrl->kato = DIV_ROUND_UP(kato, 1000);
 	}
+	ctrl->port = req->port;
 	nvmet_start_keep_alive_timer(ctrl);
 
 	mutex_lock(&subsys->lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7b8e20a..dc586e7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -108,6 +108,7 @@ static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
 
 struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
+	struct nvmet_port	*port;
 	struct nvmet_cq		**cqs;
 	struct nvmet_sq		**sqs;
 
-- 
1.8.4.3
