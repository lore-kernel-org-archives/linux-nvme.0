From: jsmart2021@gmail.com (James Smart)
Date: Mon, 13 May 2019 15:43:08 -0700
Subject: [PATCH 1/7] nvmet: add transport discovery change op
In-Reply-To: <20190513224314.24169-1-jsmart2021@gmail.com>
References: <20190513224314.24169-1-jsmart2021@gmail.com>
Message-ID: <20190513224314.24169-2-jsmart2021@gmail.com>

Some transports, such as FC-NVME, support discovery controller change
events without the use of a persistent discovery controller. FC receives
events via RSCN from the FC Fabric Controller or subsystem FC port.

This patch adds a nvmet transport op that is called whenever a
discovery change event occurs in the nvmet layer.

To facilitate the callback without adding another layer to cross into
core.c to reference the transport ops, the port structure snapshots
the transport ops when the port is enabled and clears them when disabled.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
---
 drivers/nvme/target/core.c      | 2 ++
 drivers/nvme/target/discovery.c | 4 ++++
 drivers/nvme/target/nvmet.h     | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7734a6acff85..43e8c4adc1f4 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -311,6 +311,7 @@ int nvmet_enable_port(struct nvmet_port *port)
 		port->inline_data_size = 0;
 
 	port->enabled = true;
+	port->tr_ops = ops;
 	return 0;
 }
 
@@ -321,6 +322,7 @@ void nvmet_disable_port(struct nvmet_port *port)
 	lockdep_assert_held(&nvmet_config_sem);
 
 	port->enabled = false;
+	port->tr_ops = NULL;
 
 	ops = nvmet_transports[port->disc_addr.trtype];
 	ops->remove_port(port);
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 5baf269f3f8a..8efca26b4776 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -41,6 +41,10 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 		__nvmet_disc_changed(port, ctrl);
 	}
 	mutex_unlock(&nvmet_disc_subsys->lock);
+
+	/* If transport can signal change, notify transport */
+	if (port->tr_ops && port->tr_ops->discovery_chg)
+		port->tr_ops->discovery_chg(port);
 }
 
 static void __nvmet_subsys_disc_changed(struct nvmet_port *port,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c25d88fc9dec..dc270944bb25 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -140,6 +140,7 @@ struct nvmet_port {
 	void				*priv;
 	bool				enabled;
 	int				inline_data_size;
+	const struct nvmet_fabrics_ops	*tr_ops;
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
@@ -277,6 +278,7 @@ struct nvmet_fabrics_ops {
 	void (*disc_traddr)(struct nvmet_req *req,
 			struct nvmet_port *port, char *traddr);
 	u16 (*install_queue)(struct nvmet_sq *nvme_sq);
+	void (*discovery_chg)(struct nvmet_port *port);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
-- 
2.13.7
