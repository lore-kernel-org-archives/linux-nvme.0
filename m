From: israelr@mellanox.com (Israel Rukshin)
Date: Mon, 19 Mar 2018 09:47:47 +0000
Subject: [PATCH 2/2] nvmet: Add port transport active flag
In-Reply-To: <1521452867-13619-1-git-send-email-israelr@mellanox.com>
References: <1521452867-13619-1-git-send-email-israelr@mellanox.com>
Message-ID: <1521452867-13619-2-git-send-email-israelr@mellanox.com>

tractive port flag means that nvmet transport is active and ready for
receiving requests from host.
It differ from enabled port state (port with subsystem symbolic link)
which doesn't guarantee this.
The tractive flag is necessary in case the physical ports become down
while nvmet ports are enabled.
In this case the port state remains enabled but tractive flag becomes false.

The tractive flag will help the administrator to monitor the port state
from transport point of view.
The commit also add the ability to activate the port by simply writing
to tractive at the configfs.
e.g.: echo 1 > config/nvmet/ports/1/tractive

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/configfs.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  8 ++++++++
 drivers/nvme/target/nvmet.h    |  2 ++
 drivers/nvme/target/rdma.c     |  6 ++++++
 4 files changed, 52 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e6b2d2a..840556a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -268,6 +268,41 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, addr_trtype);
 
+static ssize_t nvmet_tractive_show(struct config_item *item, char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return sprintf(page, "%d\n", nvmet_is_port_active(port));
+}
+
+static ssize_t nvmet_tractive_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	bool active;
+	int ret = 0;
+
+	if (strtobool(page, &active))
+		return -EINVAL;
+
+	if (!active) {
+		pr_err("Deactivate the port is not allowed\n");
+		return -EINVAL;
+	}
+
+	down_write(&nvmet_config_sem);
+	if (!port->enabled) {
+		pr_err("Can't activate disabled port\n");
+		ret = -EINVAL;
+	} else if (!nvmet_is_port_active(port))
+		ret = port->ops->add_port(port);
+	up_write(&nvmet_config_sem);
+
+	return ret ? ret : count;
+}
+
+CONFIGFS_ATTR(nvmet_, tractive);
+
 /*
  * Namespace structures & file operation functions below
  */
@@ -873,6 +908,7 @@ static void nvmet_port_release(struct config_item *item)
 	&nvmet_attr_addr_traddr,
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
+	&nvmet_attr_tractive,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cd97ec93..fa2a02c 100644
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
index a7f2620..1615ed4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -209,6 +209,7 @@ struct nvmet_fabrics_ops {
 	void (*queue_response)(struct nvmet_req *req);
 	int (*add_port)(struct nvmet_port *port);
 	void (*remove_port)(struct nvmet_port *port);
+	bool (*is_port_active)(struct nvmet_port *port);
 	void (*delete_ctrl)(struct nvmet_ctrl *ctrl);
 };
 
@@ -307,6 +308,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 
 int nvmet_enable_port(struct nvmet_port *port);
 void nvmet_disable_port(struct nvmet_port *port);
+bool nvmet_is_port_active(struct nvmet_port *port);
 
 void nvmet_referral_enable(struct nvmet_port *parent, struct nvmet_port *port);
 void nvmet_referral_disable(struct nvmet_port *port);
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 210e4e3..1686b6c 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1436,6 +1436,11 @@ static void nvmet_rdma_remove_port(struct nvmet_port *port)
 		rdma_destroy_id(cm_id);
 }
 
+static bool nvmet_rdma_is_port_active(struct nvmet_port *port)
+{
+	return port->priv ? true : false;
+}
+
 static struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_RDMA,
@@ -1444,6 +1449,7 @@ static void nvmet_rdma_remove_port(struct nvmet_port *port)
 	.has_keyed_sgls		= 1,
 	.add_port		= nvmet_rdma_add_port,
 	.remove_port		= nvmet_rdma_remove_port,
+	.is_port_active		= nvmet_rdma_is_port_active,
 	.queue_response		= nvmet_rdma_queue_response,
 	.delete_ctrl		= nvmet_rdma_delete_ctrl,
 };
-- 
1.8.3.1
