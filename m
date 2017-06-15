From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Jun 2017 19:34:55 +0300
Subject: [PATCH 1/2] nvme: use a single NVME_AQ_DEPTH
Message-ID: <1497544496-25134-1-git-send-email-sagi@grimberg.me>

No need to differentiate fabrics from pci/loop. Will
help us to consolidate some code in the future.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c     |  8 +-------
 drivers/nvme/host/fc.c          |  2 +-
 drivers/nvme/host/pci.c         |  1 -
 drivers/nvme/host/rdma.c        | 10 +++++-----
 drivers/nvme/target/discovery.c |  2 +-
 drivers/nvme/target/loop.c      |  4 +---
 drivers/nvme/target/rdma.c      |  2 +-
 include/linux/nvme.h            |  2 +-
 8 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 6e6864516ce6..64db2c46c5ea 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -394,13 +394,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	cmd.connect.opcode = nvme_fabrics_command;
 	cmd.connect.fctype = nvme_fabrics_type_connect;
 	cmd.connect.qid = 0;
-
-	/*
-	 * fabrics spec sets a minimum of depth 32 for admin queue,
-	 * so set the queue with this depth always until
-	 * justification otherwise.
-	 */
-	cmd.connect.sqsize = cpu_to_le16(NVMF_AQ_DEPTH - 1);
+	cmd.connect.sqsize = cpu_to_le16(NVME_AQ_DEPTH - 1);
 
 	/*
 	 * Set keep-alive timeout in seconds granularity (ms * 1000)
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5165007e86a6..5d5ecefd8dbe 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -36,7 +36,7 @@
  */
 #define NVME_FC_NR_AEN_COMMANDS	1
 #define NVME_FC_AQ_BLKMQ_DEPTH	\
-	(NVMF_AQ_DEPTH - NVME_FC_NR_AEN_COMMANDS)
+	(NVME_AQ_DEPTH - NVME_FC_NR_AEN_COMMANDS)
 #define AEN_CMDID_BASE		(NVME_FC_AQ_BLKMQ_DEPTH + 1)
 
 enum nvme_fc_queue_flags {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0f09a2d5cf7a..0f14e61889a8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -36,7 +36,6 @@
 #include "nvme.h"
 
 #define NVME_Q_DEPTH		1024
-#define NVME_AQ_DEPTH		256
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 01dc723e6acf..bc0322bf7d27 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -48,7 +48,7 @@
  */
 #define NVME_RDMA_NR_AEN_COMMANDS      1
 #define NVME_RDMA_AQ_BLKMQ_DEPTH       \
-	(NVMF_AQ_DEPTH - NVME_RDMA_NR_AEN_COMMANDS)
+	(NVME_AQ_DEPTH - NVME_RDMA_NR_AEN_COMMANDS)
 
 struct nvme_rdma_device {
 	struct ib_device       *dev;
@@ -719,7 +719,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	if (ret)
 		goto requeue;
 
-	ret = nvme_rdma_init_queue(ctrl, 0, NVMF_AQ_DEPTH);
+	ret = nvme_rdma_init_queue(ctrl, 0, NVME_AQ_DEPTH);
 	if (ret)
 		goto requeue;
 
@@ -1291,8 +1291,8 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 	 * specified by the Fabrics standard.
 	 */
 	if (priv.qid == 0) {
-		priv.hrqsize = cpu_to_le16(NVMF_AQ_DEPTH);
-		priv.hsqsize = cpu_to_le16(NVMF_AQ_DEPTH - 1);
+		priv.hrqsize = cpu_to_le16(NVME_AQ_DEPTH);
+		priv.hsqsize = cpu_to_le16(NVME_AQ_DEPTH - 1);
 	} else {
 		/*
 		 * current interpretation of the fabrics spec
@@ -1530,7 +1530,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 {
 	int error;
 
-	error = nvme_rdma_init_queue(ctrl, 0, NVMF_AQ_DEPTH);
+	error = nvme_rdma_init_queue(ctrl, 0, NVME_AQ_DEPTH);
 	if (error)
 		return error;
 
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index c7a90384dd75..8f3b57b4c97b 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -53,7 +53,7 @@ static void nvmet_format_discovery_entry(struct nvmf_disc_rsp_page_hdr *hdr,
 	e->portid = port->disc_addr.portid;
 	/* we support only dynamic controllers */
 	e->cntlid = cpu_to_le16(NVME_CNTLID_DYNAMIC);
-	e->asqsz = cpu_to_le16(NVMF_AQ_DEPTH);
+	e->asqsz = cpu_to_le16(NVME_AQ_DEPTH);
 	e->subtype = type;
 	memcpy(e->trsvcid, port->disc_addr.trsvcid, NVMF_TRSVCID_SIZE);
 	memcpy(e->traddr, port->disc_addr.traddr, NVMF_TRADDR_SIZE);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f67606523724..86c09e2a1490 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -21,8 +21,6 @@
 #include "../host/nvme.h"
 #include "../host/fabrics.h"
 
-#define NVME_LOOP_AQ_DEPTH		256
-
 #define NVME_LOOP_MAX_SEGMENTS		256
 
 /*
@@ -31,7 +29,7 @@
  */
 #define NVME_LOOP_NR_AEN_COMMANDS	1
 #define NVME_LOOP_AQ_BLKMQ_DEPTH	\
-	(NVME_LOOP_AQ_DEPTH - NVME_LOOP_NR_AEN_COMMANDS)
+	(NVME_AQ_DEPTH - NVME_LOOP_NR_AEN_COMMANDS)
 
 struct nvme_loop_iod {
 	struct nvme_request	nvme_req;
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 9e45cde63376..32aa10b521c8 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1027,7 +1027,7 @@ nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
 	queue->recv_queue_size = le16_to_cpu(req->hsqsize) + 1;
 	queue->send_queue_size = le16_to_cpu(req->hrqsize);
 
-	if (!queue->host_qid && queue->recv_queue_size > NVMF_AQ_DEPTH)
+	if (!queue->host_qid && queue->recv_queue_size > NVME_AQ_DEPTH)
 		return NVME_RDMA_CM_INVALID_HSQSIZE;
 
 	/* XXX: Should we enforce some kind of max for IO queues? */
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 6d476f242ee6..72ded9cdf964 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -87,7 +87,7 @@ enum {
 	NVMF_RDMA_CMS_RDMA_CM	= 1, /* Sockets based endpoint addressing */
 };
 
-#define NVMF_AQ_DEPTH		32
+#define NVME_AQ_DEPTH		256
 
 enum {
 	NVME_REG_CAP	= 0x0000,	/* Controller Capabilities */
-- 
2.7.4
