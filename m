From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 29 May 2018 11:25:58 -0700
Subject: [PATCH v3 3/3] nvmet-rdma: support 16K inline data
In-Reply-To: <cover.1527618402.git.swise@opengridcomputing.com>
References: <cover.1527618402.git.swise@opengridcomputing.com>
Message-ID: <55c82aa5730c05017a58641ad9550b6c0f0e16b2.1527618402.git.swise@opengridcomputing.com>

Add a new configfs port attribute, called inline_data_size,
to allow configuring the size of inline data for a given port.
The maximum size allowed is still enforced by nvmet-rdma with
NVMET_RDMA_MAX_INLINE_DATA_SIZE, which is increased to max(16KB,
PAGE_SIZE).  And the default size, if not specified via configfs,
is still PAGE_SIZE.  This preserves the existing behavior, but allows
larger inline sizes.

Also support a configuration where inline_data_size is 0, which disables
using inline data.

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/target/admin-cmd.c |  4 ++--
 drivers/nvme/target/configfs.c  | 31 ++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  4 ++++
 drivers/nvme/target/discovery.c |  2 +-
 drivers/nvme/target/nvmet.h     |  2 +-
 drivers/nvme/target/rdma.c      | 45 ++++++++++++++++++++++++++++-------------
 6 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5e0e9fc..a9e3223 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -247,14 +247,14 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->sgls = cpu_to_le32(1 << 0);	/* we always support SGLs */
 	if (ctrl->ops->has_keyed_sgls)
 		id->sgls |= cpu_to_le32(1 << 2);
-	if (ctrl->ops->sqe_inline_size)
+	if (req->port->inline_data_size)
 		id->sgls |= cpu_to_le32(1 << 20);
 
 	strcpy(id->subnqn, ctrl->subsys->subsysnqn);
 
 	/* Max command capsule size is sqe + single page of in-capsule data */
 	id->ioccsz = cpu_to_le32((sizeof(struct nvme_command) +
-				  ctrl->ops->sqe_inline_size) / 16);
+				  req->port->inline_data_size) / 16);
 	/* Max response capsule size is cqe */
 	id->iorcsz = cpu_to_le32(sizeof(struct nvme_completion) / 16);
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ad9ff27..9867783 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -214,6 +214,35 @@ static ssize_t nvmet_addr_trsvcid_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, addr_trsvcid);
 
+static ssize_t nvmet_param_inline_data_size_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return snprintf(page, PAGE_SIZE, "%d\n", port->inline_data_size);
+}
+
+static ssize_t nvmet_param_inline_data_size_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	int ret;
+
+	if (port->enabled) {
+		pr_err("Cannot modify inline_data_size enabled\n");
+		pr_err("Disable the port before modifying\n");
+		return -EACCES;
+	}
+	ret = kstrtoint(page, 0, &port->inline_data_size);
+	if (ret) {
+		pr_err("Invalid value '%s' for inline_data_size\n", page);
+		return -EINVAL;
+	}
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, param_inline_data_size);
+
 static ssize_t nvmet_addr_trtype_show(struct config_item *item,
 		char *page)
 {
@@ -870,6 +899,7 @@ static void nvmet_port_release(struct config_item *item)
 	&nvmet_attr_addr_traddr,
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
+	&nvmet_attr_param_inline_data_size,
 	NULL,
 };
 
@@ -899,6 +929,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	INIT_LIST_HEAD(&port->entry);
 	INIT_LIST_HEAD(&port->subsystems);
 	INIT_LIST_HEAD(&port->referrals);
+	port->inline_data_size = -1;	/* < 0 == let the transport choose */
 
 	port->disc_addr.portid = cpu_to_le16(portid);
 	config_group_init_type_name(&port->group, name, &nvmet_port_type);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e95424f..695ec17 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -189,6 +189,10 @@ int nvmet_enable_port(struct nvmet_port *port)
 		return ret;
 	}
 
+	/* If the transport didn't set inline_data_size, then disable it. */
+	if (port->inline_data_size < 0)
+		port->inline_data_size = 0;
+
 	port->enabled = true;
 	return 0;
 }
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 231e04e..fc2e675 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -171,7 +171,7 @@ static void nvmet_execute_identify_disc_ctrl(struct nvmet_req *req)
 	id->sgls = cpu_to_le32(1 << 0);	/* we always support SGLs */
 	if (ctrl->ops->has_keyed_sgls)
 		id->sgls |= cpu_to_le32(1 << 2);
-	if (ctrl->ops->sqe_inline_size)
+	if (req->port->inline_data_size)
 		id->sgls |= cpu_to_le32(1 << 20);
 
 	strcpy(id->subnqn, ctrl->subsys->subsysnqn);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 15fd84a..db29e45 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -98,6 +98,7 @@ struct nvmet_port {
 	struct list_head		referrals;
 	void				*priv;
 	bool				enabled;
+	int				inline_data_size;
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
@@ -202,7 +203,6 @@ struct nvmet_subsys_link {
 struct nvmet_fabrics_ops {
 	struct module *owner;
 	unsigned int type;
-	unsigned int sqe_inline_size;
 	unsigned int msdbd;
 	bool has_keyed_sgls : 1;
 	void (*queue_response)(struct nvmet_req *req);
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 52e0c5d..2f0b08e 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -33,9 +33,10 @@
 #include "nvmet.h"
 
 /*
- * We allow up to a page of inline data to go with the SQE
+ * We allow at least 1 page, and up to 16KB of inline data to go with the SQE
  */
-#define NVMET_RDMA_INLINE_DATA_SIZE	PAGE_SIZE
+#define NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE	PAGE_SIZE
+#define NVMET_RDMA_MAX_INLINE_DATA_SIZE		max_t(int, SZ_16K, PAGE_SIZE)
 
 struct nvmet_rdma_cmd {
 	struct ib_sge		sge[2];
@@ -116,6 +117,7 @@ struct nvmet_rdma_device {
 	size_t			srq_size;
 	struct kref		ref;
 	struct list_head	entry;
+	int			inline_data_size;
 };
 
 static bool nvmet_rdma_use_srq;
@@ -187,6 +189,8 @@ static inline bool nvmet_rdma_need_data_out(struct nvmet_rdma_rsp *rsp)
 static int nvmet_rdma_alloc_cmd(struct nvmet_rdma_device *ndev,
 			struct nvmet_rdma_cmd *c, bool admin)
 {
+	int inline_data_size = ndev->inline_data_size;
+
 	/* NVMe command / RDMA RECV */
 	c->nvme_cmd = kmalloc(sizeof(*c->nvme_cmd), GFP_KERNEL);
 	if (!c->nvme_cmd)
@@ -200,17 +204,17 @@ static int nvmet_rdma_alloc_cmd(struct nvmet_rdma_device *ndev,
 	c->sge[0].length = sizeof(*c->nvme_cmd);
 	c->sge[0].lkey = ndev->pd->local_dma_lkey;
 
-	if (!admin) {
+	if (!admin && inline_data_size) {
 		c->inline_page = alloc_pages(GFP_KERNEL,
-				get_order(NVMET_RDMA_INLINE_DATA_SIZE));
+				get_order(inline_data_size));
 		if (!c->inline_page)
 			goto out_unmap_cmd;
 		c->sge[1].addr = ib_dma_map_page(ndev->device,
-				c->inline_page, 0, NVMET_RDMA_INLINE_DATA_SIZE,
+				c->inline_page, 0, inline_data_size,
 				DMA_FROM_DEVICE);
 		if (ib_dma_mapping_error(ndev->device, c->sge[1].addr))
 			goto out_free_inline_page;
-		c->sge[1].length = NVMET_RDMA_INLINE_DATA_SIZE;
+		c->sge[1].length = inline_data_size;
 		c->sge[1].lkey = ndev->pd->local_dma_lkey;
 	}
 
@@ -225,7 +229,7 @@ static int nvmet_rdma_alloc_cmd(struct nvmet_rdma_device *ndev,
 out_free_inline_page:
 	if (!admin) {
 		__free_pages(c->inline_page,
-				get_order(NVMET_RDMA_INLINE_DATA_SIZE));
+				get_order(inline_data_size));
 	}
 out_unmap_cmd:
 	ib_dma_unmap_single(ndev->device, c->sge[0].addr,
@@ -240,11 +244,13 @@ static int nvmet_rdma_alloc_cmd(struct nvmet_rdma_device *ndev,
 static void nvmet_rdma_free_cmd(struct nvmet_rdma_device *ndev,
 		struct nvmet_rdma_cmd *c, bool admin)
 {
-	if (!admin) {
+	int inline_data_size = ndev->inline_data_size;
+
+	if (!admin && inline_data_size) {
 		ib_dma_unmap_page(ndev->device, c->sge[1].addr,
-				NVMET_RDMA_INLINE_DATA_SIZE, DMA_FROM_DEVICE);
+				inline_data_size, DMA_FROM_DEVICE);
 		__free_pages(c->inline_page,
-				get_order(NVMET_RDMA_INLINE_DATA_SIZE));
+				get_order(inline_data_size));
 	}
 	ib_dma_unmap_single(ndev->device, c->sge[0].addr,
 				sizeof(*c->nvme_cmd), DMA_FROM_DEVICE);
@@ -544,7 +550,7 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 	if (!nvme_is_write(rsp->req.cmd))
 		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 
-	if (off + len > NVMET_RDMA_INLINE_DATA_SIZE) {
+	if (off + len > rsp->queue->dev->inline_data_size) {
 		pr_err("invalid inline data offset!\n");
 		return NVME_SC_SGL_INVALID_OFFSET | NVME_SC_DNR;
 	}
@@ -793,6 +799,7 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 static struct nvmet_rdma_device *
 nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 {
+	struct nvmet_port *port = cm_id->context;
 	struct nvmet_rdma_device *ndev;
 	int ret;
 
@@ -807,6 +814,7 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 	if (!ndev)
 		goto out_err;
 
+	ndev->inline_data_size = port->inline_data_size;
 	ndev->device = cm_id->device;
 	kref_init(&ndev->ref);
 
@@ -1379,6 +1387,15 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 		return -EINVAL;
 	}
 
+	if (port->inline_data_size < 0) {
+		port->inline_data_size = NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
+	} else if (port->inline_data_size > NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
+		pr_err("invalid inline_data_size %d (max supported is %u)\n",
+			port->inline_data_size,
+			NVMET_RDMA_MAX_INLINE_DATA_SIZE);
+		return -EINVAL;
+	}
+
 	ret = inet_pton_with_scope(&init_net, af, port->disc_addr.traddr,
 			port->disc_addr.trsvcid, &addr);
 	if (ret) {
@@ -1418,8 +1435,9 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 		goto out_destroy_id;
 	}
 
-	pr_info("enabling port %d (%pISpcs)\n",
-		le16_to_cpu(port->disc_addr.portid), (struct sockaddr *)&addr);
+	pr_info("enabling port %d (%pISpcs) inline_data_size %d\n",
+		le16_to_cpu(port->disc_addr.portid), (struct sockaddr *)&addr,
+		port->inline_data_size);
 	port->priv = cm_id;
 	return 0;
 
@@ -1456,7 +1474,6 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_RDMA,
-	.sqe_inline_size	= NVMET_RDMA_INLINE_DATA_SIZE,
 	.msdbd			= 1,
 	.has_keyed_sgls		= 1,
 	.add_port		= nvmet_rdma_add_port,
-- 
1.8.3.1
