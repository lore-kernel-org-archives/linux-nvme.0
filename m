From: israelr@mellanox.com (Israel Rukshin)
Date: Mon, 19 Mar 2018 09:47:46 +0000
Subject: [PATCH 1/2] nvmet: Add fabrics ops to port
Message-ID: <1521452867-13619-1-git-send-email-israelr@mellanox.com>

Instead of getting the nvmet_fabrics_ops from nvmet_transports array
each time we want to use it, just take it directly from the port.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/core.c  | 9 ++++-----
 drivers/nvme/target/nvmet.h | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a78029e..cd97ec93 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -189,21 +189,20 @@ int nvmet_enable_port(struct nvmet_port *port)
 		return ret;
 	}
 
+	port->ops = ops;
 	port->enabled = true;
 	return 0;
 }
 
 void nvmet_disable_port(struct nvmet_port *port)
 {
-	struct nvmet_fabrics_ops *ops;
-
 	lockdep_assert_held(&nvmet_config_sem);
 
 	port->enabled = false;
 
-	ops = nvmet_transports[port->disc_addr.trtype];
-	ops->remove_port(port);
-	module_put(ops->owner);
+	port->ops->remove_port(port);
+	module_put(port->ops->owner);
+	port->ops = NULL;
 }
 
 static void nvmet_keep_alive_timer(struct work_struct *work)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 417f6c0..a7f2620 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -98,6 +98,7 @@ struct nvmet_port {
 	struct list_head		referrals;
 	void				*priv;
 	bool				enabled;
+	struct nvmet_fabrics_ops 	*ops;
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
-- 
1.8.3.1
