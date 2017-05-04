From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 May 2017 13:33:15 +0300
Subject: [PATCH 11/11] nvme: move nr_reconnects to nvme_ctrl
In-Reply-To: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
Message-ID: <1493893995-27063-12-git-send-email-sagi@grimberg.me>

It is not a user option but rather a variable controller
attribute.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/fabrics.c | 2 +-
 drivers/nvme/host/fabrics.h | 2 --
 drivers/nvme/host/nvme.h    | 1 +
 drivers/nvme/host/rdma.c    | 6 +++---
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 990e6fb32a63..466d12b61153 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -474,7 +474,7 @@ EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
 {
 	if (ctrl->opts->max_reconnects != -1 &&
-	    ctrl->opts->nr_reconnects < ctrl->opts->max_reconnects)
+	    ctrl->nr_reconnects < ctrl->opts->max_reconnects)
 		return true;
 
 	return false;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index f5a9c1fb186f..68e8c459bf0c 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -80,7 +80,6 @@ enum {
  * @discovery_nqn: indicates if the subsysnqn is the well-known discovery NQN.
  * @kato:	Keep-alive timeout.
  * @host:	Virtual NVMe host, contains the NQN and Host ID.
- * @nr_reconnects: number of reconnect attempted since the last ctrl failure
  * @max_reconnects: maximum number of allowed reconnect attempts before removing
  *              the controller, (-1) means reconnect forever, zero means remove
  *              immediately;
@@ -98,7 +97,6 @@ struct nvmf_ctrl_options {
 	bool			discovery_nqn;
 	unsigned int		kato;
 	struct nvmf_host	*host;
-	int			nr_reconnects;
 	int			max_reconnects;
 };
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index edf3ee7da553..1d096754b27f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -174,6 +174,7 @@ struct nvme_ctrl {
 	u32 iorcsz;
 	u16 icdoff;
 	u16 maxcmd;
+	int nr_reconnects;
 	struct nvmf_ctrl_options *opts;
 };
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index ae16d44f2ada..b6ef98a3b6f4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -725,7 +725,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	bool changed;
 	int ret;
 
-	++ctrl->ctrl.opts->nr_reconnects;
+	++ctrl->ctrl.nr_reconnects;
 
 	if (ctrl->queue_count > 1) {
 		nvme_rdma_free_io_queues(ctrl);
@@ -771,7 +771,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
-	ctrl->ctrl.opts->nr_reconnects = 0;
+	ctrl->ctrl.nr_reconnects = 0;
 
 	if (ctrl->queue_count > 1) {
 		nvme_start_queues(&ctrl->ctrl);
@@ -787,7 +787,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
 requeue:
 	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
-			ctrl->ctrl.opts->nr_reconnects);
+			ctrl->ctrl.nr_reconnects);
 	nvme_rdma_reconnect_or_remove(ctrl);
 }
 
-- 
2.7.4
