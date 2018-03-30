From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 30 Mar 2018 02:57:44 -0400
Subject: [RFC PATCH 5/8] nvmet: export nvmet_add_async_event api
In-Reply-To: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180330065747.20962-6-chaitanya.kulkarni@wdc.com>

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
index a78029e4e5f4..406fc4ca9768 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -117,14 +117,14 @@ static void nvmet_async_event_work(struct work_struct *work)
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
@@ -135,6 +135,8 @@ static void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	mutex_unlock(&ctrl->lock);
 
 	schedule_work(&ctrl->async_event_work);
+
+	return true;
 }
 
 int nvmet_register_transport(struct nvmet_fabrics_ops *ops)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 35c7bec641bf..b51c922fa3f6 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -304,6 +304,8 @@ void nvmet_ns_disable(struct nvmet_ns *ns);
 struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid);
 void nvmet_ns_free(struct nvmet_ns *ns);
 
+bool nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+		u8 event_info, u8 log_page);
 int nvmet_register_transport(struct nvmet_fabrics_ops *ops);
 void nvmet_unregister_transport(struct nvmet_fabrics_ops *ops);
 
-- 
2.14.1
