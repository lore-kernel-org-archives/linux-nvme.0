From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 16 Nov 2017 19:21:25 +0200
Subject: [PATCH 3/3] nvmet-rdma: use SRQ per completion vector
In-Reply-To: <1510852885-25519-1-git-send-email-maxg@mellanox.com>
References: <1510852885-25519-1-git-send-email-maxg@mellanox.com>
Message-ID: <1510852885-25519-4-git-send-email-maxg@mellanox.com>

In order to save resource allocation and utilize the completion
locality in a better way (compared to SRQ per device), allocate
Shared Receive Queues (SRQs) per completion vector (and not per
device). Associate each created QP/CQ with an appropriate SRQ
according to the queue index. This association will reduce the
lock contention in the fast path (compared to SRQ per
device solution) and increase the locality in memory buffers.
Add new module parameter for SRQ size to adjust it according to
the expected load. User should make sure the size is >= 256 to
avoid lack of resources.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/rdma.c | 189 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 137 insertions(+), 52 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 3ecfc12..5ff6261 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/nvme.h>
 #include <linux/slab.h>
+#include <rdma/srq_pool.h>
 #include <linux/string.h>
 #include <linux/wait.h>
 #include <linux/inet.h>
@@ -37,6 +38,8 @@
  */
 #define NVMET_RDMA_INLINE_DATA_SIZE	PAGE_SIZE
 
+struct nvmet_rdma_srq;
+
 struct nvmet_rdma_cmd {
 	struct ib_sge		sge[2];
 	struct ib_cqe		cqe;
@@ -45,7 +48,7 @@ struct nvmet_rdma_cmd {
 	struct page		*inline_page;
 	struct nvme_command     *nvme_cmd;
 	struct nvmet_rdma_queue	*queue;
-	struct ib_srq		*srq;
+	struct nvmet_rdma_srq   *nsrq;
 };
 
 enum {
@@ -87,6 +90,7 @@ struct nvmet_rdma_queue {
 	struct ib_cq		*cq;
 	atomic_t		sq_wr_avail;
 	struct nvmet_rdma_device *dev;
+	struct nvmet_rdma_srq   *nsrq;
 	spinlock_t		state_lock;
 	enum nvmet_rdma_queue_state state;
 	struct nvmet_cq		nvme_cq;
@@ -104,17 +108,24 @@ struct nvmet_rdma_queue {
 
 	int			idx;
 	int			host_qid;
+	int			comp_vector;
 	int			recv_queue_size;
 	int			send_queue_size;
 
 	struct list_head	queue_list;
 };
 
+struct nvmet_rdma_srq {
+	struct ib_srq            *srq;
+	struct nvmet_rdma_cmd    *cmds;
+	struct nvmet_rdma_device *ndev;
+};
+
 struct nvmet_rdma_device {
 	struct ib_device	*device;
 	struct ib_pd		*pd;
-	struct ib_srq		*srq;
-	struct nvmet_rdma_cmd	*srq_cmds;
+	struct nvmet_rdma_srq	**srqs;
+	int			srq_count;
 	size_t			srq_size;
 	struct kref		ref;
 	struct list_head	entry;
@@ -124,6 +135,16 @@ struct nvmet_rdma_device {
 module_param_named(use_srq, nvmet_rdma_use_srq, bool, 0444);
 MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
 
+static int srq_size_set(const char *val, const struct kernel_param *kp);
+static const struct kernel_param_ops srq_size_ops = {
+	.set = srq_size_set,
+	.get = param_get_int,
+};
+
+static int nvmet_rdma_srq_size = 4095;
+module_param_cb(srq_size, &srq_size_ops, &nvmet_rdma_srq_size, 0644);
+MODULE_PARM_DESC(srq_size, "set Shared Receive Queue (SRQ) size, should >= 256 (default: 4095)");
+
 static DEFINE_IDA(nvmet_rdma_queue_ida);
 static LIST_HEAD(nvmet_rdma_queue_list);
 static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
@@ -140,6 +161,17 @@ struct nvmet_rdma_device {
 
 static struct nvmet_fabrics_ops nvmet_rdma_ops;
 
+static int srq_size_set(const char *val, const struct kernel_param *kp)
+{
+	int n = 0, ret;
+
+	ret = kstrtoint(val, 10, &n);
+	if (ret != 0 || n < 256)
+		return -EINVAL;
+
+	return param_set_int(val, kp);
+}
+
 /* XXX: really should move to a generic header sooner or later.. */
 static inline u32 get_unaligned_le24(const u8 *p)
 {
@@ -443,8 +475,8 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 		cmd->sge[0].addr, cmd->sge[0].length,
 		DMA_FROM_DEVICE);
 
-	if (cmd->srq)
-		return ib_post_srq_recv(cmd->srq, &cmd->wr, &bad_wr);
+	if (cmd->nsrq)
+		return ib_post_srq_recv(cmd->nsrq->srq, &cmd->wr, &bad_wr);
 	return ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, &bad_wr);
 }
 
@@ -781,56 +813,107 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	nvmet_rdma_handle_command(queue, rsp);
 }
 
-static void nvmet_rdma_destroy_srq(struct nvmet_rdma_device *ndev)
+static void nvmet_rdma_destroy_srq(struct nvmet_rdma_srq *nsrq)
 {
-	if (!ndev->srq)
+	nvmet_rdma_free_cmds(nsrq->ndev, nsrq->cmds, nsrq->ndev->srq_size, false);
+	ib_srq_pool_put(nsrq->ndev->pd, nsrq->srq);
+
+	kfree(nsrq);
+}
+
+static void nvmet_rdma_destroy_srqs(struct nvmet_rdma_device *ndev)
+{
+	int i;
+
+	if (!ndev->srqs)
 		return;
 
-	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size, false);
-	ib_destroy_srq(ndev->srq);
+	for (i = 0; i < ndev->srq_count; i++)
+		nvmet_rdma_destroy_srq(ndev->srqs[i]);
+
+	ib_srq_pool_destroy(ndev->pd);
+	kfree(ndev->srqs);
 }
 
-static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
+static struct nvmet_rdma_srq *
+nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
 {
-	struct ib_srq_init_attr srq_attr = { NULL, };
+	size_t srq_size = ndev->srq_size;
+	struct nvmet_rdma_srq *nsrq;
 	struct ib_srq *srq;
-	size_t srq_size;
 	int ret, i;
 
-	srq_size = 4095;	/* XXX: tune */
+	nsrq = kzalloc(sizeof(*nsrq), GFP_KERNEL);
+	if (!nsrq)
+		return ERR_PTR(-ENOMEM);
 
-	srq_attr.attr.max_wr = srq_size;
-	srq_attr.attr.max_sge = 2;
-	srq_attr.attr.srq_limit = 0;
-	srq_attr.srq_type = IB_SRQT_BASIC;
-	srq = ib_create_srq(ndev->pd, &srq_attr);
-	if (IS_ERR(srq)) {
-		/*
-		 * If SRQs aren't supported we just go ahead and use normal
-		 * non-shared receive queues.
-		 */
-		pr_info("SRQ requested but not supported.\n");
-		return 0;
+	srq = ib_srq_pool_get(ndev->pd);
+	if (!srq) {
+		ret = -EAGAIN;
+		goto out_free_nsrq;
 	}
 
-	ndev->srq_cmds = nvmet_rdma_alloc_cmds(ndev, srq_size, false);
-	if (IS_ERR(ndev->srq_cmds)) {
-		ret = PTR_ERR(ndev->srq_cmds);
-		goto out_destroy_srq;
+	nsrq->cmds = nvmet_rdma_alloc_cmds(ndev, srq_size, false);
+	if (IS_ERR(nsrq->cmds)) {
+		ret = PTR_ERR(nsrq->cmds);
+		goto out_put_srq;
 	}
 
-	ndev->srq = srq;
-	ndev->srq_size = srq_size;
+	nsrq->srq = srq;
+	nsrq->ndev = ndev;
 
 	for (i = 0; i < srq_size; i++) {
-		ndev->srq_cmds[i].srq = srq;
-		nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
+		nsrq->cmds[i].nsrq = nsrq;
+		nvmet_rdma_post_recv(ndev, &nsrq->cmds[i]);
+	}
+
+	return nsrq;
+
+out_put_srq:
+	ib_srq_pool_put(ndev->pd, srq);
+out_free_nsrq:
+	kfree(nsrq);
+	return ERR_PTR(ret);
+}
+
+static int nvmet_rdma_init_srqs(struct nvmet_rdma_device *ndev)
+{
+	struct ib_srq_init_attr srq_attr = { NULL, };
+	int i, ret;
+
+	ndev->srq_size = min(ndev->device->attrs.max_srq_wr,
+			nvmet_rdma_srq_size);
+	ndev->srq_count = min(ndev->device->num_comp_vectors,
+			ndev->device->attrs.max_srq);
+
+	ndev->srqs = kcalloc(ndev->srq_count, sizeof(*ndev->srqs), GFP_KERNEL);
+	if (!ndev->srqs)
+		return -ENOMEM;
+
+	srq_attr.attr.max_wr = ndev->srq_size;
+	srq_attr.attr.max_sge = 2;
+	srq_attr.attr.srq_limit = 0;
+	srq_attr.srq_type = IB_SRQT_BASIC;
+	ret = ib_srq_pool_init(ndev->pd, ndev->srq_count, &srq_attr);
+	if (ret)
+		goto err_free;
+
+	for (i = 0; i < ndev->srq_count; i++) {
+		ndev->srqs[i] = nvmet_rdma_init_srq(ndev);
+		if (IS_ERR(ndev->srqs[i]))
+			goto err_srq;
 	}
 
 	return 0;
 
-out_destroy_srq:
-	ib_destroy_srq(srq);
+err_srq:
+	while (--i >= 0)
+		nvmet_rdma_destroy_srq(ndev->srqs[i]);
+	ib_srq_pool_destroy(ndev->pd);
+err_free:
+	kfree(ndev->srqs);
+	ndev->srq_count = 0;
+	ndev->srq_size = 0;
 	return ret;
 }
 
@@ -843,7 +926,7 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 	list_del(&ndev->entry);
 	mutex_unlock(&device_list_mutex);
 
-	nvmet_rdma_destroy_srq(ndev);
+	nvmet_rdma_destroy_srqs(ndev);
 	ib_dealloc_pd(ndev->pd);
 
 	kfree(ndev);
@@ -874,7 +957,7 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 		goto out_free_dev;
 
 	if (nvmet_rdma_use_srq) {
-		ret = nvmet_rdma_init_srq(ndev);
+		ret = nvmet_rdma_init_srqs(ndev);
 		if (ret)
 			goto out_free_pd;
 	}
@@ -898,14 +981,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 {
 	struct ib_qp_init_attr qp_attr;
 	struct nvmet_rdma_device *ndev = queue->dev;
-	int comp_vector, nr_cqe, ret, i;
-
-	/*
-	 * Spread the io queues across completion vectors,
-	 * but still keep all admin queues on vector 0.
-	 */
-	comp_vector = !queue->host_qid ? 0 :
-		queue->idx % ndev->device->num_comp_vectors;
+	int nr_cqe, ret, i;
 
 	/*
 	 * Reserve CQ slots for RECV + RDMA_READ/RDMA_WRITE + RDMA_SEND.
@@ -913,7 +989,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
 
 	queue->cq = ib_alloc_cq(ndev->device, queue,
-			nr_cqe + 1, comp_vector,
+			nr_cqe + 1, queue->comp_vector,
 			IB_POLL_WORKQUEUE);
 	if (IS_ERR(queue->cq)) {
 		ret = PTR_ERR(queue->cq);
@@ -935,8 +1011,8 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	qp_attr.cap.max_send_sge = max(ndev->device->attrs.max_sge_rd,
 					ndev->device->attrs.max_sge);
 
-	if (ndev->srq) {
-		qp_attr.srq = ndev->srq;
+	if (queue->nsrq) {
+		qp_attr.srq = queue->nsrq->srq;
 	} else {
 		/* +1 for drain */
 		qp_attr.cap.max_recv_wr = 1 + queue->recv_queue_size;
@@ -955,7 +1031,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 		 __func__, queue->cq->cqe, qp_attr.cap.max_send_sge,
 		 qp_attr.cap.max_send_wr, queue->cm_id);
 
-	if (!ndev->srq) {
+	if (!queue->nsrq) {
 		for (i = 0; i < queue->recv_queue_size; i++) {
 			queue->cmds[i].queue = queue;
 			nvmet_rdma_post_recv(ndev, &queue->cmds[i]);
@@ -984,7 +1060,7 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 	nvmet_sq_destroy(&queue->nvme_sq);
 
 	nvmet_rdma_destroy_queue_ib(queue);
-	if (!queue->dev->srq) {
+	if (!queue->nsrq) {
 		nvmet_rdma_free_cmds(queue->dev, queue->cmds,
 				queue->recv_queue_size,
 				!queue->host_qid);
@@ -1101,13 +1177,22 @@ static int nvmet_rdma_cm_reject(struct rdma_cm_id *cm_id,
 		goto out_destroy_sq;
 	}
 
+	/*
+	 * Spread the io queues across completion vectors,
+	 * but still keep all admin queues on vector 0.
+	 */
+	queue->comp_vector = !queue->host_qid ? 0 :
+		queue->idx % ndev->device->num_comp_vectors;
+
 	ret = nvmet_rdma_alloc_rsps(queue);
 	if (ret) {
 		ret = NVME_RDMA_CM_NO_RSC;
 		goto out_ida_remove;
 	}
 
-	if (!ndev->srq) {
+	if (ndev->srqs) {
+		queue->nsrq = ndev->srqs[queue->comp_vector % ndev->srq_count];
+	} else {
 		queue->cmds = nvmet_rdma_alloc_cmds(ndev,
 				queue->recv_queue_size,
 				!queue->host_qid);
@@ -1128,7 +1213,7 @@ static int nvmet_rdma_cm_reject(struct rdma_cm_id *cm_id,
 	return queue;
 
 out_free_cmds:
-	if (!ndev->srq) {
+	if (!queue->nsrq) {
 		nvmet_rdma_free_cmds(queue->dev, queue->cmds,
 				queue->recv_queue_size,
 				!queue->host_qid);
-- 
1.8.3.1
