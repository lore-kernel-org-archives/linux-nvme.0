From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Apr 2018 11:06:55 +0300
Subject: [PATCH v1 3/3] nvmet: Add port transport state flag
In-Reply-To: <20180412080656.1691-1-sagi@grimberg.me>
References: <20180412080656.1691-1-sagi@grimberg.me>
Message-ID: <20180412080656.1691-4-sagi@grimberg.me>

From: Israel Rukshin <israelr@mellanox.com>

trstate port flag means that nvmet transport state is up and ready for
receiving requests from host. It differ from enabled port state (port
with subsystem symbolic link) which doesn't guarantee this. The trstate
flag is necessary in case the physical ports become down while nvmet ports are enabled.
In this case the port state remains enabled but tractive flag becomes false.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/configfs.c | 11 +++++++++++
 drivers/nvme/target/core.c     |  8 ++++++++
 drivers/nvme/target/nvmet.h    |  2 ++
 drivers/nvme/target/rdma.c     |  8 ++++++++
 4 files changed, 29 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ad9ff27234b5..6501b2655508 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -265,6 +265,16 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, addr_trtype);
 
+static ssize_t nvmet_trstate_show(struct config_item *item, char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return sprintf(page, "%s\n",
+		nvmet_is_port_active(port) ? "up" : "down");
+}
+
+CONFIGFS_ATTR_RO(nvmet_, trstate);
+
 /*
  * Namespace structures & file operation functions below
  */
@@ -870,6 +880,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_traddr,
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
+	&nvmet_attr_trstate,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e95e9cd30647..96ba6a1a504c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -205,6 +205,14 @@ void nvmet_disable_port(struct nvmet_port *port)
 	port->ops = NULL;
 }
 
+bool nvmet_is_port_active(struct nvmet_port *port)
+{
+	if (port->ops && port->ops->is_port_active)
+		return port->ops->is_port_active(port);
+
+	return port->enabled;
+}
+
 static void nvmet_keep_alive_timer(struct work_struct *work)
 {
 	struct nvmet_ctrl *ctrl = container_of(to_delayed_work(work),
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index bc04e5db3a12..30981d738d37 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -212,6 +212,7 @@ struct nvmet_fabrics_ops {
 	void (*delete_ctrl)(struct nvmet_ctrl *ctrl);
 	void (*disc_traddr)(struct nvmet_req *req,
 			struct nvmet_port *port, char *traddr);
+	bool (*is_port_active)(struct nvmet_port *port);
 };
 
 #define NVMET_MAX_INLINE_BIOVEC	8
@@ -309,6 +310,7 @@ void nvmet_unregister_transport(const struct nvmet_fabrics_ops *ops);
 
 int nvmet_enable_port(struct nvmet_port *port);
 void nvmet_disable_port(struct nvmet_port *port);
+bool nvmet_is_port_active(struct nvmet_port *port);
 
 void nvmet_referral_enable(struct nvmet_port *parent, struct nvmet_port *port);
 void nvmet_referral_disable(struct nvmet_port *port);
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index b0bc716de96d..fdd651d3853c 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1477,6 +1477,13 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 	}
 }
 
+static bool nvmet_rdma_is_port_active(struct nvmet_port *nport)
+{
+	struct nvmet_rdma_port *port = nport->priv;
+
+	return port->cm_id ? true : false;
+}
+
 static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_RDMA,
@@ -1484,6 +1491,7 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.msdbd			= 1,
 	.has_keyed_sgls		= 1,
 	.add_port		= nvmet_rdma_add_port,
+	.is_port_active		= nvmet_rdma_is_port_active,
 	.remove_port		= nvmet_rdma_remove_port,
 	.queue_response		= nvmet_rdma_queue_response,
 	.delete_ctrl		= nvmet_rdma_delete_ctrl,
-- 
2.14.1
