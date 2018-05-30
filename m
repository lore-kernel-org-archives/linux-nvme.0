From: hch@lst.de (Christoph Hellwig)
Date: Wed, 30 May 2018 18:45:56 +0200
Subject: [PATCH 08/12] nvmet: mask pending AERs
In-Reply-To: <20180530164600.26856-1-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
Message-ID: <20180530164600.26856-9-hch@lst.de>

Per section 5.2 of the NVMe 1.3 spec:

  "When the controller posts a completion queue entry for an outstanding
  Asynchronous Event Request command and thus reports an asynchronous
  event, subsequent events of that event type are automatically masked by
  the controller until the host clears that event. An event is cleared by
  reading the log page associated with that event using the Get Log Page
  command (see section 5.14)."

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/admin-cmd.c | 1 +
 drivers/nvme/target/core.c      | 9 ++++++++-
 drivers/nvme/target/nvmet.h     | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 4e269a8c8dbe..abf191ee00af 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -144,6 +144,7 @@ static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
 	if (!status)
 		status = nvmet_zero_sgl(req, len, req->data_len - len);
 	ctrl->nr_changed_ns = 0;
+	clear_bit(NVME_AEN_CFG_NS_ATTR, &ctrl->aen_masked);
 	mutex_unlock(&ctrl->lock);
 out:
 	nvmet_req_complete(req, status);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b2da65aec8b7..8e6432b1abed 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -144,6 +144,13 @@ static void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	schedule_work(&ctrl->async_event_work);
 }
 
+static bool nvmet_aen_disabled(struct nvmet_ctrl *ctrl, u32 aen)
+{
+	if (!(READ_ONCE(ctrl->aen_enabled) & aen))
+		return true;
+	return test_and_set_bit(aen, &ctrl->aen_masked);
+}
+
 static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
 {
 	mutex_lock(&ctrl->lock);
@@ -168,7 +175,7 @@ static void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid)
 
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
 		nvmet_add_to_changed_ns_log(ctrl, cpu_to_le32(nsid));
-		if (!(READ_ONCE(ctrl->aen_enabled) & NVME_AEN_CFG_NS_ATTR))
+		if (nvmet_aen_disabled(ctrl, NVME_AEN_CFG_NS_ATTR))
 			continue;
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
 				NVME_AER_NOTICE_NS_CHANGED,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f4d16d9b3582..480dfe10fad9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -139,6 +139,7 @@ struct nvmet_ctrl {
 	u32			kato;
 
 	u32			aen_enabled;
+	unsigned long		aen_masked;
 	struct nvmet_req	*async_event_cmds[NVMET_ASYNC_EVENTS];
 	unsigned int		nr_async_event_cmds;
 	struct list_head	async_events;
-- 
2.17.0
