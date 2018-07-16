From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 16 Jul 2018 13:53:42 +0300
Subject: [PATCH rfc 1/2] nvmet: add nvmet port logging helpers
In-Reply-To: <20180716105343.29699-1-sagi@grimberg.me>
References: <20180716105343.29699-1-sagi@grimberg.me>
Message-ID: <20180716105343.29699-2-sagi@grimberg.me>

prettify port related logging when we have multiple ports in
the system. Now port logging helpers will use the format
"nvmet portX: ...".

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/configfs.c | 37 +++++++++++++++----------------------
 drivers/nvme/target/nvmet.h    | 27 +++++++++++++++++++++++++++
 drivers/nvme/target/rdma.c     | 26 ++++++++++++++------------
 3 files changed, 56 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 3ba5ea5c4376..8c9b75640c30 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -59,8 +59,7 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 
 	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+		port_err(port, "Cannot modify address while enabled\n");
 		return -EACCES;
 	}
 
@@ -73,7 +72,7 @@ static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
 	} else if (sysfs_streq(page, "fc")) {
 		port->disc_addr.adrfam = NVMF_ADDR_FAMILY_FC;
 	} else {
-		pr_err("Invalid value '%s' for adrfam\n", page);
+		port_err(port, "Invalid value '%s' for adrfam\n", page);
 		return -EINVAL;
 	}
 
@@ -98,13 +97,12 @@ static ssize_t nvmet_addr_portid_store(struct config_item *item,
 	u16 portid = 0;
 
 	if (kstrtou16(page, 0, &portid)) {
-		pr_err("Invalid value '%s' for portid\n", page);
+		port_err(port, "Invalid value '%s' for portid\n", page);
 		return -EINVAL;
 	}
 
 	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+		port_err(port, "Cannot modify address while enabled\n");
 		return -EACCES;
 	}
 	port->disc_addr.portid = cpu_to_le16(portid);
@@ -128,13 +126,12 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 
 	if (count > NVMF_TRADDR_SIZE) {
-		pr_err("Invalid value '%s' for traddr\n", page);
+		port_err(port, "Invalid value '%s' for traddr\n", page);
 		return -EINVAL;
 	}
 
 	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+		port_err(port, "Cannot modify address while enabled\n");
 		return -EACCES;
 	}
 
@@ -166,8 +163,7 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 
 	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+		port_err(port, "Cannot modify address while enabled\n");
 		return -EACCES;
 	}
 
@@ -178,7 +174,7 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 	} else if (sysfs_streq(page, "not required")) {
 		port->disc_addr.treq = NVMF_TREQ_NOT_REQUIRED;
 	} else {
-		pr_err("Invalid value '%s' for treq\n", page);
+		port_err(port, "Invalid value '%s' for treq\n", page);
 		return -EINVAL;
 	}
 
@@ -202,12 +198,11 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 
 	if (count > NVMF_TRSVCID_SIZE) {
-		pr_err("Invalid value '%s' for trsvcid\n", page);
+		port_err(port, "Invalid value '%s' for trsvcid\n", page);
 		return -EINVAL;
 	}
 	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+		port_err(port, "Cannot modify address while enabled\n");
 		return -EACCES;
 	}
 
@@ -233,13 +228,12 @@ static ssize_t nvmet_param_inline_data_size_store(struct config_item *item,
 	int ret;
 
 	if (port->enabled) {
-		pr_err("Cannot modify inline_data_size while port enabled\n");
-		pr_err("Disable the port before modifying\n");
+		port_err(port, "Cannot modify inline_data_size while port enabled\n");
 		return -EACCES;
 	}
 	ret = kstrtoint(page, 0, &port->inline_data_size);
 	if (ret) {
-		pr_err("Invalid value '%s' for inline_data_size\n", page);
+		port_err(port, "Invalid value '%s' for inline_data_size\n", page);
 		return -EINVAL;
 	}
 	return count;
@@ -276,8 +270,7 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 	int i;
 
 	if (port->enabled) {
-		pr_err("Cannot modify address while enabled\n");
-		pr_err("Disable the address before modifying\n");
+		port_err(port, "Cannot modify address while enabled\n");
 		return -EACCES;
 	}
 
@@ -286,7 +279,7 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 			goto found;
 	}
 
-	pr_err("Invalid value '%s' for trtype\n", page);
+	port_err(port, "Invalid value '%s' for trtype\n", page);
 	return -EINVAL;
 found:
 	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
@@ -854,7 +847,7 @@ static ssize_t nvmet_referral_enable_store(struct config_item *item,
 
 	return count;
 inval:
-	pr_err("Invalid value '%s' for enable\n", page);
+	port_err(port, "Invalid value '%s' for enable\n", page);
 	return -EINVAL;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 688993855402..6811258ab8ff 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -270,6 +270,33 @@ struct nvmet_req {
 	const struct nvmet_fabrics_ops *ops;
 };
 
+#define port_err(port, fmt, a...)		\
+	printk(KERN_ERR "nvmet port%d: " fmt, \
+		le32_to_cpu((port)->disc_addr.portid), ##a)
+#define port_info(port, fmt, a...)		\
+	printk(KERN_INFO "nvmet port%d: " fmt, \
+		le32_to_cpu((port)->disc_addr.portid), ##a)
+#define port_warn(port, fmt, a...)		\
+	printk(KERN_WARNING "nvmet port%d: " fmt, \
+		le32_to_cpu((port)->disc_addr.portid), ##a)
+
+#if defined(CONFIG_DYNAMIC_DEBUG)
+#include <linux/dynamic_debug.h>
+#define port_dbg(port, fmt, a...)				\
+do {								\
+	DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);		\
+	if (DYNAMIC_DEBUG_BRANCH(descriptor))			\
+		printk(KERN_DEBUG "nvmet port%d: " fmt, 	\
+			le32_to_cpu((port)->disc_addr.portid), ##a);\
+} while (0)
+#elif defined(DEBUG)
+#define port_dbg(port, fmt, a...)				\
+	printk(KERN_DEBUG "nvmet port%d: " fmt, 	\
+		le32_to_cpu((port)->disc_addr.portid)
+#else
+#define port_dbg(port, fmt, a...) {}
+#endif
+
 extern struct workqueue_struct *buffered_io_wq;
 
 static inline void nvmet_set_status(struct nvmet_req *req, u16 status)
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index e7f43d1e1779..71bf6bf57be9 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -918,7 +918,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 	list_add(&ndev->entry, &device_list);
 out_unlock:
 	mutex_unlock(&device_list_mutex);
-	pr_debug("added %s.\n", ndev->device->name);
+	port_dbg(port, "added %s.\n", ndev->device->name);
 	return ndev;
 
 out_free_pd:
@@ -1273,7 +1273,8 @@ static void nvmet_rdma_queue_established(struct nvmet_rdma_queue *queue)
 
 	spin_lock_irqsave(&queue->state_lock, flags);
 	if (queue->state != NVMET_RDMA_Q_CONNECTING) {
-		pr_warn("trying to establish a connected queue\n");
+		port_warn(queue->port,
+			"trying to establish a connected queue\n");
 		goto out_unlock;
 	}
 	queue->state = NVMET_RDMA_Q_LIVE;
@@ -1299,7 +1300,8 @@ static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 	bool disconnect = false;
 	unsigned long flags;
 
-	pr_debug("cm_id= %p queue->state= %d\n", queue->cm_id, queue->state);
+	port_dbg(queue->port, "cm_id= %p queue->state= %d\n",
+		queue->cm_id, queue->state);
 
 	spin_lock_irqsave(&queue->state_lock, flags);
 	switch (queue->state) {
@@ -1473,7 +1475,7 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 		af = AF_INET6;
 		break;
 	default:
-		pr_err("address family %d not supported\n",
+		port_err(port, "address family %d not supported\n",
 				port->disc_addr.adrfam);
 		return -EINVAL;
 	}
@@ -1481,7 +1483,8 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 	if (port->inline_data_size < 0) {
 		port->inline_data_size = NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
 	} else if (port->inline_data_size > NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
-		pr_warn("inline_data_size %u is too large, reducing to %u\n",
+		port_warn(port,
+			"inline_data_size %u is too large, reducing to %u\n",
 			port->inline_data_size,
 			NVMET_RDMA_MAX_INLINE_DATA_SIZE);
 		port->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
@@ -1490,7 +1493,7 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 	ret = inet_pton_with_scope(&init_net, af, port->disc_addr.traddr,
 			port->disc_addr.trsvcid, &addr);
 	if (ret) {
-		pr_err("malformed ip/port passed: %s:%s\n",
+		port_err(port, "malformed ip/port passed: %s:%s\n",
 			port->disc_addr.traddr, port->disc_addr.trsvcid);
 		return ret;
 	}
@@ -1498,7 +1501,7 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 	cm_id = rdma_create_id(&init_net, nvmet_rdma_cm_handler, port,
 			RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(cm_id)) {
-		pr_err("CM ID creation failed\n");
+		port_err(port, "CM ID creation failed\n");
 		return PTR_ERR(cm_id);
 	}
 
@@ -1508,26 +1511,25 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 	 */
 	ret = rdma_set_afonly(cm_id, 1);
 	if (ret) {
-		pr_err("rdma_set_afonly failed (%d)\n", ret);
+		port_err(port, "rdma_set_afonly failed (%d)\n", ret);
 		goto out_destroy_id;
 	}
 
 	ret = rdma_bind_addr(cm_id, (struct sockaddr *)&addr);
 	if (ret) {
-		pr_err("binding CM ID to %pISpcs failed (%d)\n",
+		port_err(port, "binding CM ID to %pISpcs failed (%d)\n",
 			(struct sockaddr *)&addr, ret);
 		goto out_destroy_id;
 	}
 
 	ret = rdma_listen(cm_id, 128);
 	if (ret) {
-		pr_err("listening to %pISpcs failed (%d)\n",
+		port_err(port, "listening to %pISpcs failed (%d)\n",
 			(struct sockaddr *)&addr, ret);
 		goto out_destroy_id;
 	}
 
-	pr_info("enabling port %d (%pISpcs)\n",
-		le16_to_cpu(port->disc_addr.portid), (struct sockaddr *)&addr);
+	port_info(port, "enabled (%pISpcs)\n", (struct sockaddr *)&addr);
 	port->priv = cm_id;
 	return 0;
 
-- 
2.14.1
