From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 27 Jun 2018 14:53:23 +0200
Subject: [PATCH v5 1/2] nvme: cache struct nvme_ctrl reference to struct
 nvme_request
In-Reply-To: <20180627125324.22064-1-jthumshirn@suse.de>
References: <20180627125324.22064-1-jthumshirn@suse.de>
Message-ID: <20180627125324.22064-2-jthumshirn@suse.de>

From: Sagi Grimberg <sagi@grimberg.me>

We will need to reference the controller in the setup and completion
time for tracing and future traffic based keep alive support.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

---
Changes to v4:
- Move caching from nvme_setup_cmd to .init_request (Keith)
---
 drivers/nvme/host/core.c   | 1 +
 drivers/nvme/host/fc.c     | 1 +
 drivers/nvme/host/nvme.h   | 1 +
 drivers/nvme/host/pci.c    | 2 ++
 drivers/nvme/host/rdma.c   | 1 +
 drivers/nvme/target/loop.c | 1 +
 6 files changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e541fe268bcf..99dd62c1076c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -652,6 +652,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	}
 
 	cmd->common.command_id = req->tag;
+
 	if (ns)
 		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
 	else
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
index 9f5fc7b7fd7f..36344710050b 100644
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
2.16.4
