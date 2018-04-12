From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Apr 2018 11:06:54 +0300
Subject: [PATCH v1 2/3] nvmet: Add fabrics ops to port
In-Reply-To: <20180412080656.1691-1-sagi@grimberg.me>
References: <20180412080656.1691-1-sagi@grimberg.me>
Message-ID: <20180412080656.1691-3-sagi@grimberg.me>

From: Israel Rukshin <israelr@mellanox.com>

Instead of getting the nvmet_fabrics_ops from nvmet_transports array
each time we want to use it, just take it directly from the port.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/core.c  | 9 ++++-----
 drivers/nvme/target/nvmet.h | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e95424f172fd..e95e9cd30647 100644
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
-	const struct nvmet_fabrics_ops *ops;
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
index 15fd84ab21f8..bc04e5db3a12 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -98,6 +98,7 @@ struct nvmet_port {
 	struct list_head		referrals;
 	void				*priv;
 	bool				enabled;
+	const struct nvmet_fabrics_ops 	*ops;
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
-- 
2.14.1
