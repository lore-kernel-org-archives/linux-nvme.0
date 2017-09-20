From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 20 Sep 2017 12:40:32 +0200
Subject: [PATCH] nvme: make controller 'state' sysfs attribute pollable
Message-ID: <20170920104032.14014-1-jthumshirn@suse.de>

Notify sysfs about changes of a nvme controller so user-space can watch the
file via poll() or select() in order to react to a state change.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index acc816b67582..064d973f1e22 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -237,8 +237,10 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		break;
 	}
 
-	if (changed)
+	if (changed) {
 		ctrl->state = new_state;
+		sysfs_notify(&ctrl->dev->kobj, NULL, "state");
+	}
 
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
-- 
2.13.5
