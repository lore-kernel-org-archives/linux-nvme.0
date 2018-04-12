From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 12 Apr 2018 11:06:53 +0300
Subject: [PATCH v1 1/3] nvmet-rdma: automatic listening port re-activation
In-Reply-To: <20180412080656.1691-1-sagi@grimberg.me>
References: <20180412080656.1691-1-sagi@grimberg.me>
Message-ID: <20180412080656.1691-2-sagi@grimberg.me>

In case the device goes away (or resets) we get a device
removal event (or .remove ib_client callback). So what
we want is to destroy the listening cm_id and re-activate
(or enable) when the same device comes back. Hence we introduce
nvmet_rdma_port which stores the ib_device node guid, and when
a new device comes in to the system (ib_client .add callback) we
search for an existing listener port on this device and reconfigure
the listener cm_id.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/rdma.c | 229 ++++++++++++++++++++++++++++-----------------
 1 file changed, 141 insertions(+), 88 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 52e0c5d579a7..b0bc716de96d 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -118,6 +118,15 @@ struct nvmet_rdma_device {
 	struct list_head	entry;
 };
 
+struct nvmet_rdma_port {
+	struct nvmet_port	*nport;
+	struct sockaddr_storage addr;
+	struct rdma_cm_id	*cm_id;
+	__be64			node_guid;
+	struct list_head	entry;
+	struct delayed_work	enable_work;
+};
+
 static bool nvmet_rdma_use_srq;
 module_param_named(use_srq, nvmet_rdma_use_srq, bool, 0444);
 MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
@@ -129,6 +138,9 @@ static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
 static LIST_HEAD(device_list);
 static DEFINE_MUTEX(device_list_mutex);
 
+static LIST_HEAD(port_list);
+static DEFINE_MUTEX(port_list_mutex);
+
 static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp);
 static void nvmet_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc);
 static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
@@ -1127,6 +1139,7 @@ static int nvmet_rdma_cm_accept(struct rdma_cm_id *cm_id,
 static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 		struct rdma_cm_event *event)
 {
+	struct nvmet_rdma_port *port = cm_id->context;
 	struct nvmet_rdma_device *ndev;
 	struct nvmet_rdma_queue *queue;
 	int ret = -EINVAL;
@@ -1142,7 +1155,7 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 		ret = -ENOMEM;
 		goto put_device;
 	}
-	queue->port = cm_id->context;
+	queue->port = port->nport;
 
 	if (queue->host_qid == 0) {
 		/* Let inflight controller teardown complete */
@@ -1249,53 +1262,6 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
 	schedule_work(&queue->release_work);
 }
 
-/**
- * nvme_rdma_device_removal() - Handle RDMA device removal
- * @cm_id:	rdma_cm id, used for nvmet port
- * @queue:      nvmet rdma queue (cm id qp_context)
- *
- * DEVICE_REMOVAL event notifies us that the RDMA device is about
- * to unplug. Note that this event can be generated on a normal
- * queue cm_id and/or a device bound listener cm_id (where in this
- * case queue will be null).
- *
- * We registered an ib_client to handle device removal for queues,
- * so we only need to handle the listening port cm_ids. In this case
- * we nullify the priv to prevent double cm_id destruction and destroying
- * the cm_id implicitely by returning a non-zero rc to the callout.
- */
-static int nvmet_rdma_device_removal(struct rdma_cm_id *cm_id,
-		struct nvmet_rdma_queue *queue)
-{
-	struct nvmet_port *port;
-
-	if (queue) {
-		/*
-		 * This is a queue cm_id. we have registered
-		 * an ib_client to handle queues removal
-		 * so don't interfear and just return.
-		 */
-		return 0;
-	}
-
-	port = cm_id->context;
-
-	/*
-	 * This is a listener cm_id. Make sure that
-	 * future remove_port won't invoke a double
-	 * cm_id destroy. use atomic xchg to make sure
-	 * we don't compete with remove_port.
-	 */
-	if (xchg(&port->priv, NULL) != cm_id)
-		return 0;
-
-	/*
-	 * We need to return 1 so that the core will destroy
-	 * it's own ID.  What a great API design..
-	 */
-	return 1;
-}
-
 static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		struct rdma_cm_event *event)
 {
@@ -1322,8 +1288,7 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		nvmet_rdma_queue_disconnect(queue);
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
-		ret = nvmet_rdma_device_removal(cm_id, queue);
-		break;
+		break; /* handled by nvmet_rdma_remove_one */
 	case RDMA_CM_EVENT_REJECTED:
 		pr_debug("Connection rejected: %s\n",
 			 rdma_reject_msg(cm_id, event->status));
@@ -1359,34 +1324,12 @@ static void nvmet_rdma_delete_ctrl(struct nvmet_ctrl *ctrl)
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 }
 
-static int nvmet_rdma_add_port(struct nvmet_port *port)
+static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port)
 {
+	struct sockaddr *addr = (struct sockaddr *)&port->addr;
 	struct rdma_cm_id *cm_id;
-	struct sockaddr_storage addr = { };
-	__kernel_sa_family_t af;
 	int ret;
 
-	switch (port->disc_addr.adrfam) {
-	case NVMF_ADDR_FAMILY_IP4:
-		af = AF_INET;
-		break;
-	case NVMF_ADDR_FAMILY_IP6:
-		af = AF_INET6;
-		break;
-	default:
-		pr_err("address family %d not supported\n",
-				port->disc_addr.adrfam);
-		return -EINVAL;
-	}
-
-	ret = inet_pton_with_scope(&init_net, af, port->disc_addr.traddr,
-			port->disc_addr.trsvcid, &addr);
-	if (ret) {
-		pr_err("malformed ip/port passed: %s:%s\n",
-			port->disc_addr.traddr, port->disc_addr.trsvcid);
-		return ret;
-	}
-
 	cm_id = rdma_create_id(&init_net, nvmet_rdma_cm_handler, port,
 			RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(cm_id)) {
@@ -1404,23 +1347,22 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 		goto out_destroy_id;
 	}
 
-	ret = rdma_bind_addr(cm_id, (struct sockaddr *)&addr);
+	ret = rdma_bind_addr(cm_id, addr);
 	if (ret) {
-		pr_err("binding CM ID to %pISpcs failed (%d)\n",
-			(struct sockaddr *)&addr, ret);
+		pr_err("binding CM ID to %pISpcs failed (%d)\n", addr, ret);
 		goto out_destroy_id;
 	}
 
 	ret = rdma_listen(cm_id, 128);
 	if (ret) {
-		pr_err("listening to %pISpcs failed (%d)\n",
-			(struct sockaddr *)&addr, ret);
+		pr_err("listening to %pISpcs failed (%d)\n", addr, ret);
 		goto out_destroy_id;
 	}
 
-	pr_info("enabling port %d (%pISpcs)\n",
-		le16_to_cpu(port->disc_addr.portid), (struct sockaddr *)&addr);
-	port->priv = cm_id;
+	port->cm_id = cm_id;
+	if (cm_id->device)
+		port->node_guid = cm_id->device->node_guid;
+
 	return 0;
 
 out_destroy_id:
@@ -1428,18 +1370,100 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 	return ret;
 }
 
-static void nvmet_rdma_remove_port(struct nvmet_port *port)
+static void nvmet_rdma_enable_port_work(struct work_struct *w)
+{
+	struct nvmet_rdma_port *port = container_of(to_delayed_work(w),
+			struct nvmet_rdma_port, enable_work);
+	int ret;
+
+	ret = nvmet_rdma_enable_port(port);
+	if (ret)
+		schedule_delayed_work(&port->enable_work, 5 * HZ);
+}
+
+static int nvmet_rdma_add_port(struct nvmet_port *nport)
+{
+	struct nvmet_rdma_port *port;
+	__kernel_sa_family_t af;
+	int ret;
+
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	switch (nport->disc_addr.adrfam) {
+	case NVMF_ADDR_FAMILY_IP4:
+		af = AF_INET;
+		break;
+	case NVMF_ADDR_FAMILY_IP6:
+		af = AF_INET6;
+		break;
+	default:
+		pr_err("address family %d not supported\n",
+				nport->disc_addr.adrfam);
+		ret = -EINVAL;
+		goto out_free_port;
+	}
+
+	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
+			nport->disc_addr.trsvcid, &port->addr);
+	if (ret) {
+		pr_err("malformed ip/port passed: %s:%s\n",
+			nport->disc_addr.traddr, nport->disc_addr.trsvcid);
+		goto out_free_port;
+	}
+
+	ret = nvmet_rdma_enable_port(port);
+	if(ret)
+		goto out_free_port;
+
+	pr_info("enabling port %d (%pISpcs)\n",
+		le16_to_cpu(nport->disc_addr.portid),
+		(struct sockaddr *)&port->addr);
+
+	nport->priv = port;
+	port->nport = nport;
+	INIT_DELAYED_WORK(&port->enable_work, nvmet_rdma_enable_port_work);
+
+	mutex_lock(&port_list_mutex);
+	list_add_tail(&port->entry, &port_list);
+	mutex_unlock(&port_list_mutex);
+
+	return 0;
+
+out_free_port:
+	kfree(port);
+	return ret;
+}
+
+static void nvmet_rdma_disable_port(struct nvmet_rdma_port *port)
 {
-	struct rdma_cm_id *cm_id = xchg(&port->priv, NULL);
+	struct rdma_cm_id *cm_id = port->cm_id;
 
+	port->cm_id = NULL;
 	if (cm_id)
 		rdma_destroy_id(cm_id);
 }
 
+static void nvmet_rdma_remove_port(struct nvmet_port *nport)
+{
+	struct nvmet_rdma_port *port = nport->priv;
+
+	mutex_lock(&port_list_mutex);
+	list_del(&port->entry);
+	mutex_unlock(&port_list_mutex);
+
+	cancel_delayed_work_sync(&port->enable_work);
+
+	nvmet_rdma_disable_port(port);
+	kfree(port);
+}
+
 static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
-		struct nvmet_port *port, char *traddr)
+		struct nvmet_port *nport, char *traddr)
 {
-	struct rdma_cm_id *cm_id = port->priv;
+	struct nvmet_rdma_port *port = nport->priv;
+	struct rdma_cm_id *cm_id = port->cm_id;
 
 	if (inet_addr_is_any((struct sockaddr *)&cm_id->route.addr.src_addr)) {
 		struct nvmet_rdma_rsp *rsp =
@@ -1449,7 +1473,7 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 
 		sprintf(traddr, "%pISc", addr);
 	} else {
-		memcpy(traddr, port->disc_addr.traddr, NVMF_TRADDR_SIZE);
+		memcpy(traddr, nport->disc_addr.traddr, NVMF_TRADDR_SIZE);
 	}
 }
 
@@ -1466,9 +1490,26 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.disc_traddr		= nvmet_rdma_disc_port_addr,
 };
 
+static void nvmet_rdma_add_one(struct ib_device *ib_device)
+{
+	struct nvmet_rdma_port *port, *n;
+
+	mutex_lock(&port_list_mutex);
+	list_for_each_entry_safe(port, n, &port_list, entry) {
+		if (port->node_guid != ib_device->node_guid)
+			continue;
+
+		pr_info("device added, enabling port %d\n",
+			le16_to_cpu(port->nport->disc_addr.portid));
+		schedule_delayed_work(&port->enable_work, HZ);
+	}
+	mutex_unlock(&port_list_mutex);
+}
+
 static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 {
 	struct nvmet_rdma_queue *queue, *tmp;
+	struct nvmet_rdma_port *port, *n;
 	struct nvmet_rdma_device *ndev;
 	bool found = false;
 
@@ -1481,6 +1522,17 @@ static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data
 	}
 	mutex_unlock(&device_list_mutex);
 
+	mutex_lock(&port_list_mutex);
+	list_for_each_entry_safe(port, n, &port_list, entry) {
+		if (port->node_guid != ib_device->node_guid)
+			continue;
+
+		pr_info("device removal, disabling port %d\n",
+			le16_to_cpu(port->nport->disc_addr.portid));
+		nvmet_rdma_disable_port(port);
+	}
+	mutex_unlock(&port_list_mutex);
+
 	if (!found)
 		return;
 
@@ -1494,7 +1546,7 @@ static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data
 		if (queue->dev->device != ib_device)
 			continue;
 
-		pr_info("Removing queue %d\n", queue->idx);
+		pr_info("device removal, removing queue %d\n", queue->idx);
 		list_del_init(&queue->queue_list);
 		__nvmet_rdma_queue_disconnect(queue);
 	}
@@ -1505,6 +1557,7 @@ static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data
 
 static struct ib_client nvmet_rdma_ib_client = {
 	.name   = "nvmet_rdma",
+	.add = nvmet_rdma_add_one,
 	.remove = nvmet_rdma_remove_one
 };
 
-- 
2.14.1
