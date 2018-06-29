From: keith.busch@intel.com (Keith Busch)
Date: Fri, 29 Jun 2018 16:50:00 -0600
Subject: [PATCHv4 1/4] nvme: cache struct nvme_ctrl reference to struct
 nvme_request
In-Reply-To: <20180629225003.16567-1-keith.busch@intel.com>
References: <20180629225003.16567-1-keith.busch@intel.com>
Message-ID: <20180629225003.16567-2-keith.busch@intel.com>

From: Sagi Grimberg <sagi@grimberg.me>

We will need to reference the controller in the setup and completion
time for tracing and future traffic based keep alive support.

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fc.c     | 1 +
 drivers/nvme/host/nvme.h   | 1 +
 drivers/nvme/host/pci.c    | 2 ++
 drivers/nvme/host/rdma.c   | 1 +
 drivers/nvme/target/loop.c | 1 +
 5 files changed, 6 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 41d45a1b5c62..9cc33752539a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1737,6 +1737,7 @@ nvme_fc_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
 	struct nvme_fc_queue *queue = &ctrl->queues[queue_idx];
 
+	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	return __nvme_fc_init_request(ctrl, queue, op, rq, queue->rqcnt++);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0c4a33df3b2f..f2249387b60d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -102,6 +102,7 @@ struct nvme_request {
 	u8			retries;
 	u8			flags;
 	u16			status;
+	struct nvme_ctrl	*ctrl;
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba943f211687..8dcae11bbf3a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -418,6 +418,8 @@ static int nvme_init_request(struct blk_mq_tag_set *set, struct request *req,
 
 	BUG_ON(!nvmeq);
 	iod->nvmeq = nvmeq;
+
+	nvme_req(req)->ctrl = &dev->ctrl;
 	return 0;
 }
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9544625c0b7d..ade55977d432 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -286,6 +286,7 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 	struct ib_device *ibdev = dev->dev;
 	int ret;
 
+	nvme_req(rq)->ctrl = &ctrl->ctrl;
 	ret = nvme_rdma_alloc_qe(ibdev, &req->sqe, sizeof(struct nvme_command),
 			DMA_TO_DEVICE);
 	if (ret)
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d8d91f04bd7e..af7fbf4132b0 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -227,6 +227,7 @@ static int nvme_loop_init_request(struct blk_mq_tag_set *set,
 {
 	struct nvme_loop_ctrl *ctrl = set->driver_data;
 
+	nvme_req(req)->ctrl = &ctrl->ctrl;
 	return nvme_loop_init_iod(ctrl, blk_mq_rq_to_pdu(req),
 			(set == &ctrl->tag_set) ? hctx_idx + 1 : 0);
 }
-- 
2.14.3
