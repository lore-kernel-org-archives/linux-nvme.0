From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Tue, 19 Mar 2019 16:41:10 +0200
Subject: [PATCH 3/9] nvme/core: add NVME_CTRL_SUSPENDED controller state
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
Message-ID: <20190319144116.400-4-mlevitsk@redhat.com>

This state will be used by a controller that is going to
suspended state, and will later be used by mdev
framework to detect this and flush its queues

Signed-off-by: Maxim Levitsky <mlevitsk at redhat.com>
---
 drivers/nvme/host/core.c | 15 +++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6a9dd68c0f4f..cf9de026cb93 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -320,6 +320,19 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_RESETTING:
+		case NVME_CTRL_CONNECTING:
+		case NVME_CTRL_SUSPENDED:
+			changed = true;
+			/* FALLTHRU */
+		default:
+			break;
+		}
+		break;
+	case NVME_CTRL_SUSPENDED:
+		switch (old_state) {
+		case NVME_CTRL_NEW:
+		case NVME_CTRL_LIVE:
+		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			/* FALLTHRU */
@@ -332,6 +345,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_ADMIN_ONLY:
+		case NVME_CTRL_SUSPENDED:
 			changed = true;
 			/* FALLTHRU */
 		default:
@@ -354,6 +368,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		case NVME_CTRL_ADMIN_ONLY:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
+		case NVME_CTRL_SUSPENDED:
 			changed = true;
 			/* FALLTHRU */
 		default:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c4a1bb41abf0..9320b0a87d79 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -142,6 +142,7 @@ static inline u16 nvme_req_qid(struct request *req)
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
 	NVME_CTRL_LIVE,
+	NVME_CTRL_SUSPENDED,
 	NVME_CTRL_ADMIN_ONLY,    /* Only admin queue live */
 	NVME_CTRL_RESETTING,
 	NVME_CTRL_CONNECTING,
-- 
2.17.2
