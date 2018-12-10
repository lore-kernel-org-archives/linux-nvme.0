From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun,  9 Dec 2018 21:50:02 -0800
Subject: [PATCH 03/12] nvmet: add error-log definitions
In-Reply-To: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
References: <20181210055011.3146-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181210055011.3146-4-chaitanya.kulkarni@wdc.com>

This patch adds necessary fields in the target data structures to
support error log page. For a target controller, we add a new error log
field to maintain the error log, at any given point we maintain error
entries equal to NVMET_ERROR_LOG_SLOTS for each controller. In the
following patch, we also update the error log page entry in the I/O
completion path so we introduce a spinlock for synchronization of the
log.

For nvmet_req, we add a new field error_loc to hold the location of
the error in the command when the actual error occurs for each request
and a starting LBA if applicable.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c  | 5 +++++
 drivers/nvme/target/nvmet.h | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e468100b9211..4ed0022b8450 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -769,6 +769,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->rsp->status = 0;
 	req->rsp->sq_head = 0;
 	req->ns = NULL;
+	req->error_loc = 0;
+	req->error_slba = 0;
 
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
@@ -1174,6 +1176,9 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	/* keep-alive timeout in seconds */
 	ctrl->kato = DIV_ROUND_UP(kato, 1000);
 
+	ctrl->counter = 0;
+	spin_lock_init(&ctrl->error_lock);
+
 	nvmet_start_keep_alive_timer(ctrl);
 
 	mutex_lock(&subsys->lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dafee1af4829..5a19f64de891 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -202,6 +202,10 @@ struct nvmet_ctrl {
 
 	struct device		*p2p_client;
 	struct radix_tree_root	p2p_ns_map;
+
+	spinlock_t		error_lock;
+	u64			counter;
+	struct nvme_error_slot	slots[NVMET_ERROR_LOG_SLOTS];
 };
 
 struct nvmet_subsys {
@@ -317,6 +321,8 @@ struct nvmet_req {
 
 	struct pci_dev		*p2p_dev;
 	struct device		*p2p_client;
+	u16			error_loc;
+	u64			error_slba;
 };
 
 extern struct workqueue_struct *buffered_io_wq;
-- 
2.17.0
