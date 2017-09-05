From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue,  5 Sep 2017 13:59:16 +0300
Subject: [PATCH 2/3] nvmet-rdma: use SRQ per completion vector
In-Reply-To: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
References: <1504609157-3004-1-git-send-email-maxg@mellanox.com>
Message-ID: <1504609157-3004-3-git-send-email-maxg@mellanox.com>

In order to save resource allocation and utilize the completion
locality in a better way, allocate Shared Receive Queues (SRQs) per
completion vector (and not per device). Assosiate each created QP/CQ
with an appropriate SRQ according to the queue index. This association
will reduce the lock contention in the fast path and increase the
locality in memory buffers.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/rdma.c |  132 ++++++++++++++++++++++++++++++++------------
 1 files changed, 97 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index fb322b3..1b52080 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -37,6 +37,8 @@
  */
 #define NVMET_RDMA_INLINE_DATA_SIZE	PAGE_SIZE
 
+struct nvmet_rdma_srq;
+
 struct nvmet_rdma_cmd {
 	struct ib_sge		sge[2];
 	struct ib_cqe		cqe;
@@ -45,7 +47,7 @@ struct nvmet_rdma_cmd {
 	struct page		*inline_page;
 	struct nvme_command     *nvme_cmd;
 	struct nvmet_rdma_queue	*queue;
-	struct ib_srq		*srq;
+	struct nvmet_rdma_srq   *nsrq;
 };
 
 enum {
@@ -87,6 +89,7 @@ struct nvmet_rdma_queue {
 	struct ib_cq		*cq;
 	atomic_t		sq_wr_avail;
 	struct nvmet_rdma_device *dev;
+	struct nvmet_rdma_srq   *nsrq;
 	spinlock_t		state_lock;
 	enum nvmet_rdma_queue_state state;
 	struct nvmet_cq		nvme_cq;
@@ -104,18 +107,25 @@ struct nvmet_rdma_queue {
 
 	int			idx;
 	int			host_qid;
+	int			comp_vector;
 	int			recv_queue_size;
 	int			send_queue_size;
 
 	struct list_head	queue_list;
 };
 
+struct nvmet_rdma_srq {
+	struct ib_srq            *srq;
+	struct nvmet_rdma_cmd    *srq_cmds;
+	size_t                   srq_size;
+	struct nvmet_rdma_device *ndev;
+};
+
 struct nvmet_rdma_device {
 	struct ib_device	*device;
 	struct ib_pd		*pd;
-	struct ib_srq		*srq;
-	struct nvmet_rdma_cmd	*srq_cmds;
-	size_t			srq_size;
+	struct nvmet_rdma_srq	**srqs;
+	int			srq_count;
 	struct kref		ref;
 	struct list_head	entry;
 };
@@ -443,8 +453,8 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 		cmd->sge[0].addr, cmd->sge[0].length,
 		DMA_FROM_DEVICE);
 
-	if (cmd->srq)
-		return ib_post_srq_recv(cmd->srq, &cmd->wr, &bad_wr);
+	if (cmd->nsrq)
+		return ib_post_srq_recv(cmd->nsrq->srq, &cmd->wr, &bad_wr);
 	return ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, &bad_wr);
 }
 
@@ -779,22 +789,42 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	nvmet_rdma_handle_command(queue, rsp);
 }
 
-static void nvmet_rdma_destroy_srq(struct nvmet_rdma_device *ndev)
+static void nvmet_rdma_destroy_srq(struct nvmet_rdma_srq *nsrq)
+{
+	if (!nsrq)
+		return;
+
+	nvmet_rdma_free_cmds(nsrq->ndev, nsrq->srq_cmds, nsrq->srq_size, false);
+	ib_destroy_srq(nsrq->srq);
+
+	kfree(nsrq);
+}
+
+static void nvmet_rdma_destroy_srqs(struct nvmet_rdma_device *ndev)
 {
-	if (!ndev->srq)
+	int i;
+
+	if (!ndev->srqs)
 		return;
 
-	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size, false);
-	ib_destroy_srq(ndev->srq);
+	for (i = 0; i < ndev->srq_count; i++)
+		nvmet_rdma_destroy_srq(ndev->srqs[i]);
+
+	kfree(ndev->srqs);
 }
 
-static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
+static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev, int index)
 {
 	struct ib_srq_init_attr srq_attr = { NULL, };
+	struct nvmet_rdma_srq *nsrq;
 	struct ib_srq *srq;
 	size_t srq_size;
 	int ret, i;
 
+	nsrq = kzalloc(sizeof(*nsrq), GFP_KERNEL);
+	if (!nsrq)
+		return -ENOMEM;
+
 	srq_size = 4095;	/* XXX: tune */
 
 	srq_attr.attr.max_wr = srq_size;
@@ -808,27 +838,57 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
 		 * non-shared receive queues.
 		 */
 		pr_info("SRQ requested but not supported.\n");
+		kfree(nsrq);
 		return 0;
 	}
 
-	ndev->srq_cmds = nvmet_rdma_alloc_cmds(ndev, srq_size, false);
-	if (IS_ERR(ndev->srq_cmds)) {
-		ret = PTR_ERR(ndev->srq_cmds);
+	nsrq->srq_cmds = nvmet_rdma_alloc_cmds(ndev, srq_size, false);
+	if (IS_ERR(nsrq->srq_cmds)) {
+		ret = PTR_ERR(nsrq->srq_cmds);
 		goto out_destroy_srq;
 	}
 
-	ndev->srq = srq;
-	ndev->srq_size = srq_size;
+	nsrq->srq = srq;
+	nsrq->srq_size = srq_size;
+	nsrq->ndev = ndev;
+	ndev->srqs[index] = nsrq;
 
 	for (i = 0; i < srq_size; i++) {
-		ndev->srq_cmds[i].srq = srq;
-		nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
+		nsrq->srq_cmds[i].nsrq = nsrq;
+		nvmet_rdma_post_recv(ndev, &nsrq->srq_cmds[i]);
 	}
 
 	return 0;
 
 out_destroy_srq:
 	ib_destroy_srq(srq);
+	kfree(nsrq);
+	return ret;
+}
+
+static int nvmet_rdma_init_srqs(struct nvmet_rdma_device *ndev)
+{
+	int srq_count = ndev->device->num_comp_vectors;
+	int i, ret;
+
+	ndev->srqs = kzalloc(srq_count * sizeof(*ndev->srqs), GFP_KERNEL);
+	if (!ndev->srqs)
+		return -ENOMEM;
+
+	for (i = 0; i < srq_count; i++) {
+		ret = nvmet_rdma_init_srq(ndev, i);
+		if (ret)
+			goto err_srq;
+	}
+
+	ndev->srq_count = srq_count;
+	return 0;
+
+err_srq:
+	while (--i >= 0)
+		nvmet_rdma_destroy_srq(ndev->srqs[i]);
+
+	kfree(ndev->srqs);
 	return ret;
 }
 
@@ -841,7 +901,7 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 	list_del(&ndev->entry);
 	mutex_unlock(&device_list_mutex);
 
-	nvmet_rdma_destroy_srq(ndev);
+	nvmet_rdma_destroy_srqs(ndev);
 	ib_dealloc_pd(ndev->pd);
 
 	kfree(ndev);
@@ -872,7 +932,7 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 		goto out_free_dev;
 
 	if (nvmet_rdma_use_srq) {
-		ret = nvmet_rdma_init_srq(ndev);
+		ret = nvmet_rdma_init_srqs(ndev);
 		if (ret)
 			goto out_free_pd;
 	}
@@ -896,14 +956,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
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
@@ -911,7 +964,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
 
 	queue->cq = ib_alloc_cq(ndev->device, queue,
-			nr_cqe + 1, comp_vector,
+			nr_cqe + 1, queue->comp_vector,
 			IB_POLL_WORKQUEUE);
 	if (IS_ERR(queue->cq)) {
 		ret = PTR_ERR(queue->cq);
@@ -933,8 +986,8 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	qp_attr.cap.max_send_sge = max(ndev->device->attrs.max_sge_rd,
 					ndev->device->attrs.max_sge);
 
-	if (ndev->srq) {
-		qp_attr.srq = ndev->srq;
+	if (queue->nsrq) {
+		qp_attr.srq = queue->nsrq->srq;
 	} else {
 		/* +1 for drain */
 		qp_attr.cap.max_recv_wr = 1 + queue->recv_queue_size;
@@ -953,7 +1006,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 		 __func__, queue->cq->cqe, qp_attr.cap.max_send_sge,
 		 qp_attr.cap.max_send_wr, queue->cm_id);
 
-	if (!ndev->srq) {
+	if (!queue->nsrq) {
 		for (i = 0; i < queue->recv_queue_size; i++) {
 			queue->cmds[i].queue = queue;
 			nvmet_rdma_post_recv(ndev, &queue->cmds[i]);
@@ -982,7 +1035,7 @@ static void nvmet_rdma_free_queue(struct nvmet_rdma_queue *queue)
 	nvmet_sq_destroy(&queue->nvme_sq);
 
 	nvmet_rdma_destroy_queue_ib(queue);
-	if (!queue->dev->srq) {
+	if (!queue->nsrq) {
 		nvmet_rdma_free_cmds(queue->dev, queue->cmds,
 				queue->recv_queue_size,
 				!queue->host_qid);
@@ -1099,13 +1152,22 @@ static int nvmet_rdma_cm_reject(struct rdma_cm_id *cm_id,
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
+	if (ndev->srqs && ndev->srqs[queue->comp_vector % ndev->srq_count]) {
+		queue->nsrq = ndev->srqs[queue->comp_vector % ndev->srq_count];
+	} else {
 		queue->cmds = nvmet_rdma_alloc_cmds(ndev,
 				queue->recv_queue_size,
 				!queue->host_qid);
@@ -1126,7 +1188,7 @@ static int nvmet_rdma_cm_reject(struct rdma_cm_id *cm_id,
 	return queue;
 
 out_free_cmds:
-	if (!ndev->srq) {
+	if (!queue->nsrq) {
 		nvmet_rdma_free_cmds(queue->dev, queue->cmds,
 				queue->recv_queue_size,
 				!queue->host_qid);
-- 
1.7.1
