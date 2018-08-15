From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 Aug 2018 15:58:48 -0400
Subject: [PATCH V4 3/9] nvmet: export nvmet_add_async_event api
In-Reply-To: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
References: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180815195854.15449-4-chaitanya.kulkarni@wdc.com>

This patch changes the return value for nvmet_add_async_event()
and exports the same API.

This change is needed for the target passthru code to generate
async events.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c  | 5 +++--
 drivers/nvme/target/nvmet.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 14b4c4916a8e..4317678df194 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -129,14 +129,14 @@ static void nvmet_async_event_work(struct work_struct *work)
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
@@ -147,6 +147,7 @@ static void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	mutex_unlock(&ctrl->lock);
 
 	schedule_work(&ctrl->async_event_work);
+	return true;
 }
 
 static bool nvmet_aen_disabled(struct nvmet_ctrl *ctrl, u32 aen)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ec9af4ee03b6..221cf6cacd4a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -370,6 +370,8 @@ void nvmet_send_ana_event(struct nvmet_subsys *subsys,
 		struct nvmet_port *port);
 void nvmet_port_send_ana_event(struct nvmet_port *port);
 
+bool nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+		u8 event_info, u8 log_page);
 int nvmet_register_transport(const struct nvmet_fabrics_ops *ops);
 void nvmet_unregister_transport(const struct nvmet_fabrics_ops *ops);
 
-- 
2.14.1
