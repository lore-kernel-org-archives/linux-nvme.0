From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 12 Dec 2018 22:38:15 -0800
Subject: [PATCH v2 3/6] nvme-fabrics: allow nvmf_connect_io_queue to poll
In-Reply-To: <20181213063819.13614-1-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
Message-ID: <20181213063819.13614-4-sagi@grimberg.me>

Preparation for polling support for fabrics. Polling support
means that our completion queues are not generating any interrupts
which means we need to poll for the nvmf io queue connect as well.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 4 ++--
 drivers/nvme/host/fabrics.h | 2 +-
 drivers/nvme/host/fc.c      | 2 +-
 drivers/nvme/host/rdma.c    | 2 +-
 drivers/nvme/host/tcp.c     | 2 +-
 drivers/nvme/target/loop.c  | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index d93a169f6403..5ff14f46a8d9 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -441,7 +441,7 @@ EXPORT_SYMBOL_GPL(nvmf_connect_admin_queue);
  *	> 0: NVMe error status code
  *	< 0: Linux errno error code
  */
-int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
+int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll)
 {
 	struct nvme_command cmd;
 	struct nvmf_connect_data *data;
@@ -468,7 +468,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
 			data, sizeof(*data), 0, qid, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, poll);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 81b8fd1c0c5d..cad70a9f976a 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -168,7 +168,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl);
-int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid);
+int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid, bool poll);
 int nvmf_register_transport(struct nvmf_transport_ops *ops);
 void nvmf_unregister_transport(struct nvmf_transport_ops *ops);
 void nvmf_free_options(struct nvmf_ctrl_options *opts);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b79e41938513..89accc76d71c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1975,7 +1975,7 @@ nvme_fc_connect_io_queues(struct nvme_fc_ctrl *ctrl, u16 qsize)
 					(qsize / 5));
 		if (ret)
 			break;
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, i, false);
 		if (ret)
 			break;
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ed726da77b5b..b907ed43814f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -598,7 +598,7 @@ static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 	int ret;
 
 	if (idx)
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx);
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx, false);
 	else
 		ret = nvmf_connect_admin_queue(&ctrl->ctrl);
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 51826479a41e..762a676403ef 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1393,7 +1393,7 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 	int ret;
 
 	if (idx)
-		ret = nvmf_connect_io_queue(nctrl, idx);
+		ret = nvmf_connect_io_queue(nctrl, idx, false);
 	else
 		ret = nvmf_connect_admin_queue(nctrl);
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9908082b32c4..4aac1b4a8112 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -345,7 +345,7 @@ static int nvme_loop_connect_io_queues(struct nvme_loop_ctrl *ctrl)
 	int i, ret;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, i, false);
 		if (ret)
 			return ret;
 		set_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[i].flags);
-- 
2.17.1
