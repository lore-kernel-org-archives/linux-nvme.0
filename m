From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 27 Sep 2018 18:15:37 -0700
Subject: [PATCH 4/4] nvme-core: support traffic based keep-alive based on
 controller support
In-Reply-To: <20180928011537.30069-1-sagi@grimberg.me>
References: <20180928011537.30069-1-sagi@grimberg.me>
Message-ID: <20180928011537.30069-5-sagi@grimberg.me>

If the controller supports traffic based keep alive, we restart
the keep alive timer if any admin or io commands was completed
during the kato period. This prevents a possible starvation of
keep alive commands in the presence of heavy traffic as in such
case, we already have a health indication from the host perspective.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 11 +++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6bb6214c0634..54a24987a7d4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -251,6 +251,7 @@ void nvme_complete_rq(struct request *req)
 
 	trace_nvme_complete_rq(req);
 
+	nvme_req(req)->ctrl->comp_seen = true;
 	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
 		if ((req->cmd_flags & REQ_NVME_MPATH) &&
 		    blk_path_error(status)) {
@@ -841,6 +842,7 @@ static void nvme_keep_alive_end_io(struct request *rq, blk_status_t status)
 		return;
 	}
 
+	ctrl->comp_seen = false;
 	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
 
@@ -865,6 +867,15 @@ static void nvme_keep_alive_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvme_ctrl, ka_work);
+	bool comp_seen = ctrl->comp_seen;
+
+	if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
+		dev_dbg(ctrl->device,
+			"traffic based keep-alive timer expired, reschedule\n");
+		ctrl->comp_seen = false;
+		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+		return;
+	}
 
 	if (nvme_keep_alive(ctrl)) {
 		/* allocation failure, reset the controller */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ee1c4fc0249c..e9aaae257daa 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -145,6 +145,7 @@ enum nvme_ctrl_state {
 };
 
 struct nvme_ctrl {
+	bool comp_seen;
 	enum nvme_ctrl_state state;
 	bool identified;
 	spinlock_t lock;
-- 
2.17.1
