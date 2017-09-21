From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Sep 2017 17:01:36 +0300
Subject: [PATCH 1/3] nvme-core: Use nvme_wq to queue async events and fw
 activation
Message-ID: <1506002498-9177-1-git-send-email-sagi@grimberg.me>

async_event_work might race as it is executed from two different
workqueues at the moment.

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5589f67d2cd8..bb2aad078637 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2676,7 +2676,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	case NVME_SC_ABORT_REQ:
 		++ctrl->event_limit;
 		if (ctrl->state == NVME_CTRL_LIVE)
-			schedule_work(&ctrl->async_event_work);
+			queue_work(nvme_wq, &ctrl->async_event_work);
 		break;
 	default:
 		break;
@@ -2691,7 +2691,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		nvme_queue_scan(ctrl);
 		break;
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
-		schedule_work(&ctrl->fw_act_work);
+		queue_work(nvme_wq, &ctrl->fw_act_work);
 		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
-- 
2.7.4
