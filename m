From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 5 Jun 2018 10:16:50 -0700
Subject: [PATCH v4 3/3] nvmet-rdma: support max(16KB, PAGE_SIZE) inline data
In-Reply-To: <cover.1528219321.git.swise@opengridcomputing.com>
References: <cover.1528219321.git.swise@opengridcomputing.com>
Message-ID: <051c25edb1b0c0aa84b8195a95bdd3eb30d710f5.1528219321.git.swise@opengridcomputing.com>

The patch enables inline data sizes using up to 4 recv sges, and capping
the size at 16KB or at least 1 page size.  So on a 4K page system, up to
16KB is supported, and for a 64K page system 1 page of 64KB is supported.

We avoid > 0 order page allocations for the inline buffers by using
multiple recv sges, one for each page.  If the device cannot support
the configured inline data size due to lack of enough recv sges, then
log a warning and reduce the inline size.

Add a new configfs port attribute, called param_inline_data_size,
to allow configuring the size of inline data for a given nvmf port.
The maximum size allowed is still enforced by nvmet-rdma with
NVMET_RDMA_MAX_INLINE_DATA_SIZE, which is now max(16KB, PAGE_SIZE).
And the default size, if not specified via configfs, is still PAGE_SIZE.
This preserves the existing behavior, but allows larger inline sizes
for small page systems.  If the configured inline data size exceeds
NVMET_RDMA_MAX_INLINE_DATA_SIZE, a warning is logged and the size is
reduced.  If param_inline_data_size is set to 0, then inline data is
disabled for that nvmf port.

Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/target/admin-cmd.c |   4 +-
 drivers/nvme/target/configfs.c  |  31 +++++++
 drivers/nvme/target/core.c      |   4 +
 drivers/nvme/target/discovery.c |   2 +-
 drivers/nvme/target/nvmet.h     |   2 +-
 drivers/nvme/target/rdma.c      | 174 ++++++++++++++++++++++++++++++----------
 6 files changed, 172 insertions(+), 45 deletions(-)

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
index 52e0c5d..eb5f1b0 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -33,16 +33,17 @@
 #include "nvmet.h"
 
 /*
- * We allow up to a page of inline data to go with the SQE
+ * We allow at least 1 page, up to 4 SGEs, and up to 16KB of inline data
  */
-#define NVMET_RDMA_INLINE_DATA_SIZE	PAGE_SIZE
+#define NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE	PAGE_SIZE
+#define NVMET_RDMA_MAX_INLINE_SGE		4
+#define NVMET_RDMA_MAX_INLINE_DATA_SIZE		max_t(int, SZ_16K, PAGE_SIZE)
 
 struct nvmet_rdma_cmd {
-	struct ib_sge		sge[2];
+	struct ib_sge		sge[NVMET_RDMA_MAX_INLINE_SGE + 1];
 	struct ib_cqe		cqe;
 	struct ib_recv_wr	wr;
-	struct scatterlist	inline_sg;
-	struct page		*inline_page;
+	struct scatterlist	inline_sg[NVMET_RDMA_MAX_INLINE_SGE];
 	struct nvme_command     *nvme_cmd;
 	struct nvmet_rdma_queue	*queue;
 };
@@ -116,6 +117,8 @@ struct nvmet_rdma_device {
 	size_t			srq_size;
 	struct kref		ref;
 	struct list_head	entry;
+	int			inline_data_size;
+	int			inline_page_count;
 };
 
 static bool nvmet_rdma_use_srq;
@@ -138,6 +141,11 @@ struct nvmet_rdma_device {
 
 static const struct nvmet_fabrics_ops nvmet_rdma_ops;
 
+static int num_pages(int len)
+{
+	return 1 + (((len - 1) & PAGE_MASK) >> PAGE_SHIFT);
+}
+
 /* XXX: really should move to a generic header sooner or later.. */
 static inline u32 get_unaligned_le24(const u8 *p)
 {
@@ -184,6 +192,71 @@ static inline bool nvmet_rdma_need_data_out(struct nvmet_rdma_rsp *rsp)
 	spin_unlock_irqrestore(&rsp->queue->rsps_lock, flags);
 }
 
+static void nvmet_rdma_free_inline_pages(struct nvmet_rdma_device *ndev,
+				struct nvmet_rdma_cmd *c)
+{
+	struct scatterlist *sg;
+	struct ib_sge *sge;
+	int i;
+
+	if (!ndev->inline_data_size)
+		return;
+
+	sg = c->inline_sg;
+	sge = &c->sge[1];
+
+	for (i = 0; i < ndev->inline_page_count; i++, sg++, sge++) {
+		if (sge->length)
+			ib_dma_unmap_page(ndev->device, sge->addr,
+					sge->length, DMA_FROM_DEVICE);
+		if (sg_page(sg))
+			__free_page(sg_page(sg));
+	}
+}
+
+static int nvmet_rdma_alloc_inline_pages(struct nvmet_rdma_device *ndev,
+				struct nvmet_rdma_cmd *c)
+{
+	struct scatterlist *sg;
+	struct ib_sge *sge;
+	struct page *pg;
+	int len;
+	int i;
+
+	if (!ndev->inline_data_size)
+		return 0;
+
+	sg = c->inline_sg;
+	sg_init_table(sg, ndev->inline_page_count);
+	sge = &c->sge[1];
+	len = ndev->inline_data_size;
+
+	for (i = 0; i < ndev->inline_page_count; i++, sg++, sge++) {
+		pg = alloc_page(GFP_KERNEL);
+		if (!pg)
+			goto out_err;
+		sg_assign_page(sg, pg);
+		sge->addr = ib_dma_map_page(ndev->device,
+			pg, 0, PAGE_SIZE, DMA_FROM_DEVICE);
+		if (ib_dma_mapping_error(ndev->device, sge->addr))
+			goto out_err;
+		sge->length = min_t(int, len, PAGE_SIZE);
+		sge->lkey = ndev->pd->local_dma_lkey;
+		len -= sge->length;
+	}
+
+	return 0;
+out_err:
+	for (; i >= 0; i--, sg--, sge--) {
+		if (sge->length)
+			ib_dma_unmap_page(ndev->device, sge->addr,
+					sge->length, DMA_FROM_DEVICE);
+		if (sg_page(sg))
+			__free_page(sg_page(sg));
+	}
+	return -ENOMEM;
+}
+
 static int nvmet_rdma_alloc_cmd(struct nvmet_rdma_device *ndev,
 			struct nvmet_rdma_cmd *c, bool admin)
 {
@@ -200,33 +273,17 @@ static int nvmet_rdma_alloc_cmd(struct nvmet_rdma_device *ndev,
 	c->sge[0].length = sizeof(*c->nvme_cmd);
 	c->sge[0].lkey = ndev->pd->local_dma_lkey;
 
-	if (!admin) {
-		c->inline_page = alloc_pages(GFP_KERNEL,
-				get_order(NVMET_RDMA_INLINE_DATA_SIZE));
-		if (!c->inline_page)
-			goto out_unmap_cmd;
-		c->sge[1].addr = ib_dma_map_page(ndev->device,
-				c->inline_page, 0, NVMET_RDMA_INLINE_DATA_SIZE,
-				DMA_FROM_DEVICE);
-		if (ib_dma_mapping_error(ndev->device, c->sge[1].addr))
-			goto out_free_inline_page;
-		c->sge[1].length = NVMET_RDMA_INLINE_DATA_SIZE;
-		c->sge[1].lkey = ndev->pd->local_dma_lkey;
-	}
+	if (!admin && nvmet_rdma_alloc_inline_pages(ndev, c))
+		goto out_unmap_cmd;
 
 	c->cqe.done = nvmet_rdma_recv_done;
 
 	c->wr.wr_cqe = &c->cqe;
 	c->wr.sg_list = c->sge;
-	c->wr.num_sge = admin ? 1 : 2;
+	c->wr.num_sge = admin ? 1 : ndev->inline_page_count + 1;
 
 	return 0;
 
-out_free_inline_page:
-	if (!admin) {
-		__free_pages(c->inline_page,
-				get_order(NVMET_RDMA_INLINE_DATA_SIZE));
-	}
 out_unmap_cmd:
 	ib_dma_unmap_single(ndev->device, c->sge[0].addr,
 			sizeof(*c->nvme_cmd), DMA_FROM_DEVICE);
@@ -240,12 +297,8 @@ static int nvmet_rdma_alloc_cmd(struct nvmet_rdma_device *ndev,
 static void nvmet_rdma_free_cmd(struct nvmet_rdma_device *ndev,
 		struct nvmet_rdma_cmd *c, bool admin)
 {
-	if (!admin) {
-		ib_dma_unmap_page(ndev->device, c->sge[1].addr,
-				NVMET_RDMA_INLINE_DATA_SIZE, DMA_FROM_DEVICE);
-		__free_pages(c->inline_page,
-				get_order(NVMET_RDMA_INLINE_DATA_SIZE));
-	}
+	if (!admin)
+		nvmet_rdma_free_inline_pages(ndev, c);
 	ib_dma_unmap_single(ndev->device, c->sge[0].addr,
 				sizeof(*c->nvme_cmd), DMA_FROM_DEVICE);
 	kfree(c->nvme_cmd);
@@ -429,7 +482,7 @@ static void nvmet_rdma_release_rsp(struct nvmet_rdma_rsp *rsp)
 				rsp->req.sg_cnt, nvmet_data_dir(&rsp->req));
 	}
 
-	if (rsp->req.sg != &rsp->cmd->inline_sg)
+	if (rsp->req.sg != rsp->cmd->inline_sg)
 		sgl_free(rsp->req.sg);
 
 	if (unlikely(!list_empty_careful(&queue->rsp_wr_wait_list)))
@@ -529,10 +582,25 @@ static void nvmet_rdma_read_data_done(struct ib_cq *cq, struct ib_wc *wc)
 static void nvmet_rdma_use_inline_sg(struct nvmet_rdma_rsp *rsp, u32 len,
 		u64 off)
 {
-	sg_init_table(&rsp->cmd->inline_sg, 1);
-	sg_set_page(&rsp->cmd->inline_sg, rsp->cmd->inline_page, len, off);
-	rsp->req.sg = &rsp->cmd->inline_sg;
-	rsp->req.sg_cnt = 1;
+	int sg_count = num_pages(len);
+	struct scatterlist *sg;
+	int i;
+
+	sg = rsp->cmd->inline_sg;
+	for (i = 0; i < sg_count; i++, sg++) {
+		if (i < sg_count - 1)
+			sg_unmark_end(sg);
+		else
+			sg_mark_end(sg);
+		sg->offset = off;
+		sg->length = min_t(int, len, PAGE_SIZE - off);
+		len -= sg->length;
+		if (!i)
+			off = 0;
+	}
+
+	rsp->req.sg = rsp->cmd->inline_sg;
+	rsp->req.sg_cnt = sg_count;
 }
 
 static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
@@ -544,7 +612,7 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 	if (!nvme_is_write(rsp->req.cmd))
 		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 
-	if (off + len > NVMET_RDMA_INLINE_DATA_SIZE) {
+	if (off + len > rsp->queue->dev->inline_data_size) {
 		pr_err("invalid inline data offset!\n");
 		return NVME_SC_SGL_INVALID_OFFSET | NVME_SC_DNR;
 	}
@@ -743,7 +811,7 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
 	srq_size = 4095;	/* XXX: tune */
 
 	srq_attr.attr.max_wr = srq_size;
-	srq_attr.attr.max_sge = 2;
+	srq_attr.attr.max_sge = 1 + ndev->inline_page_count;
 	srq_attr.attr.srq_limit = 0;
 	srq_attr.srq_type = IB_SRQT_BASIC;
 	srq = ib_create_srq(ndev->pd, &srq_attr);
@@ -793,7 +861,10 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 static struct nvmet_rdma_device *
 nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 {
+	struct nvmet_port *port = cm_id->context;
 	struct nvmet_rdma_device *ndev;
+	int inline_page_count;
+	int inline_sge_count;
 	int ret;
 
 	mutex_lock(&device_list_mutex);
@@ -807,6 +878,18 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 	if (!ndev)
 		goto out_err;
 
+	inline_page_count = num_pages(port->inline_data_size);
+	inline_sge_count = max(cm_id->device->attrs.max_sge_rd,
+				cm_id->device->attrs.max_sge) - 1;
+	if (inline_page_count > inline_sge_count) {
+		pr_warn("inline_data_size %d cannot be supported by device %s. Reducing to %lu.\n",
+			port->inline_data_size, cm_id->device->name,
+			inline_sge_count * PAGE_SIZE);
+		port->inline_data_size = inline_sge_count * PAGE_SIZE;
+		inline_page_count = inline_sge_count;
+	}
+	ndev->inline_data_size = port->inline_data_size;
+	ndev->inline_page_count = inline_page_count;
 	ndev->device = cm_id->device;
 	kref_init(&ndev->ref);
 
@@ -881,7 +964,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	} else {
 		/* +1 for drain */
 		qp_attr.cap.max_recv_wr = 1 + queue->recv_queue_size;
-		qp_attr.cap.max_recv_sge = 2;
+		qp_attr.cap.max_recv_sge = 1 + ndev->inline_page_count;
 	}
 
 	ret = rdma_create_qp(queue->cm_id, ndev->pd, &qp_attr);
@@ -1379,6 +1462,15 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 		return -EINVAL;
 	}
 
+	if (port->inline_data_size < 0) {
+		port->inline_data_size = NVMET_RDMA_DEFAULT_INLINE_DATA_SIZE;
+	} else if (port->inline_data_size > NVMET_RDMA_MAX_INLINE_DATA_SIZE) {
+		pr_warn("inline_data_size %u is too large, reducing to %u\n",
+			port->inline_data_size,
+			NVMET_RDMA_MAX_INLINE_DATA_SIZE);
+		port->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
+	}
+
 	ret = inet_pton_with_scope(&init_net, af, port->disc_addr.traddr,
 			port->disc_addr.trsvcid, &addr);
 	if (ret) {
@@ -1418,8 +1510,9 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 		goto out_destroy_id;
 	}
 
-	pr_info("enabling port %d (%pISpcs)\n",
-		le16_to_cpu(port->disc_addr.portid), (struct sockaddr *)&addr);
+	pr_info("enabling port %d (%pISpcs) inline_data_size %d\n",
+		le16_to_cpu(port->disc_addr.portid), (struct sockaddr *)&addr,
+		port->inline_data_size);
 	port->priv = cm_id;
 	return 0;
 
@@ -1456,7 +1549,6 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_RDMA,
-	.sqe_inline_size	= NVMET_RDMA_INLINE_DATA_SIZE,
 	.msdbd			= 1,
 	.has_keyed_sgls		= 1,
 	.add_port		= nvmet_rdma_add_port,
-- 
1.8.3.1
