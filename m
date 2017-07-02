From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun,  2 Jul 2017 18:01:34 +0300
Subject: [PATCH rfc 3/3] nvmet-rdma: assign cq completion vector based on the
 port allowed cpus
In-Reply-To: <1499007694-7231-1-git-send-email-sagi@grimberg.me>
References: <1499007694-7231-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499007694-7231-4-git-send-email-sagi@grimberg.me>

We first take a cpu assignment from the port configured cpulist
(spread uniformly accross them) with rdma core API.

If the device does not expose a vector affinity mask,  or we
couldn't find a match, we fallback to the old behavior as we
don't have sufficient information to do the "correct" vector
assignment.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/rdma.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 56a4cba690b5..a1725d3e174a 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -889,27 +889,43 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 	return NULL;
 }
 
-static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
+static int nvmet_rdma_assign_vector(struct nvmet_rdma_queue *queue)
 {
-	struct ib_qp_init_attr qp_attr;
-	struct nvmet_rdma_device *ndev = queue->dev;
-	int comp_vector, nr_cqe, ret, i;
+	struct ib_device *dev = queue->dev->device;
+	struct nvmet_port *port = queue->port;
+	int vec, cpu;
 
 	/*
-	 * Spread the io queues across completion vectors,
-	 * but still keep all admin queues on vector 0.
+	 * Spread the io queues across port cpus,
+	 * but still keep all admin queues on cpu 0.
 	 */
-	comp_vector = !queue->host_qid ? 0 :
-		queue->idx % ndev->device->num_comp_vectors;
+	cpu = !queue->host_qid ? 0 : port->cpus[queue->idx % port->nr_cpus];
+
+	if (ib_find_cpu_vector(dev, cpu, &vec))
+		return vec;
+
+	pr_debug("device %s could not provide vector to match cpu %d\n",
+			dev->name, cpu);
+	/*
+	 * No corresponding vector affinity found, fallback to
+	 * the old behavior where we spread vectors all over...
+	 */
+	return !queue->host_qid ? 0 : queue->idx % dev->num_comp_vectors;
+}
+
+static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
+{
+	struct ib_qp_init_attr qp_attr;
+	struct nvmet_rdma_device *ndev = queue->dev;
+	int nr_cqe, ret, i;
 
 	/*
 	 * Reserve CQ slots for RECV + RDMA_READ/RDMA_WRITE + RDMA_SEND.
 	 */
 	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
 
-	queue->cq = ib_alloc_cq(ndev->device, queue,
-			nr_cqe + 1, comp_vector,
-			IB_POLL_WORKQUEUE);
+	queue->cq = ib_alloc_cq(ndev->device, queue, nr_cqe + 1,
+			nvmet_rdma_assign_vector(queue), IB_POLL_WORKQUEUE);
 	if (IS_ERR(queue->cq)) {
 		ret = PTR_ERR(queue->cq);
 		pr_err("failed to create CQ cqe= %d ret= %d\n",
@@ -1080,6 +1096,7 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
 	queue->dev = ndev;
 	queue->cm_id = cm_id;
+	queue->port = cm_id->context;
 
 	spin_lock_init(&queue->state_lock);
 	queue->state = NVMET_RDMA_Q_CONNECTING;
@@ -1198,7 +1215,6 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 		ret = -ENOMEM;
 		goto put_device;
 	}
-	queue->port = cm_id->context;
 
 	if (queue->host_qid == 0) {
 		/* Let inflight controller teardown complete */
-- 
2.7.4
