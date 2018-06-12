From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 12 Jun 2018 15:55:02 -0400
Subject: [PATCH V3 4/8] nvmet: export nvmet_add_async_event api
In-Reply-To: <20180612195506.23616-1-chaitanya.kulkarni@wdc.com>
References: <20180612195506.23616-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180612195506.23616-5-chaitanya.kulkarni@wdc.com>

This patch changes the return value for nvmet_add_async_event()
and exports the same API.

This change is needed for the target passthru code to generate
async events.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c  | 6 ++++--
 drivers/nvme/target/nvmet.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a03da764ecae..4a2b95a51137 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -124,14 +124,14 @@ static void nvmet_async_event_work(struct work_struct *work)
 	}
 }
 
-static void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+bool nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page)
 {
 	struct nvmet_async_event *aen;
 
 	aen = kmalloc(sizeof(*aen), GFP_KERNEL);
 	if (!aen)
-		return;
+		return false;
 
 	aen->event_type = event_type;
 	aen->event_info = event_info;
@@ -142,6 +142,8 @@ static void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	mutex_unlock(&ctrl->lock);
 
 	schedule_work(&ctrl->async_event_work);
+
+	return true;
 }
 
 static bool nvmet_aen_disabled(struct nvmet_ctrl *ctrl, u32 aen)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 480dfe10fad9..be3d2ef173a3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -337,6 +337,8 @@ void nvmet_ns_disable(struct nvmet_ns *ns);
 struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_ns_free(struct nvmet_ns *ns);
 
+bool nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+		u8 event_info, u8 log_page);
 int nvmet_register_transport(const struct nvmet_fabrics_ops *ops);
 void nvmet_unregister_transport(const struct nvmet_fabrics_ops *ops);
 
-- 
2.17.0
