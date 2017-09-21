From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Sep 2017 17:01:37 +0300
Subject: [PATCH v2 2/3] nvme-rdma: give up reconnect if state change fails
In-Reply-To: <1506002498-9177-1-git-send-email-sagi@grimberg.me>
References: <1506002498-9177-1-git-send-email-sagi@grimberg.me>
Message-ID: <1506002498-9177-2-git-send-email-sagi@grimberg.me>

If we failed to transition to state LIVE after a successful
reconnect, then controller deletion already started. In this
case there is no point moving forward with reconnect.

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- warn if ctrl state is not deleteing.

 drivers/nvme/host/rdma.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 58983000964b..8441f6b3f617 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -942,7 +942,12 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
+	if (!changed) {
+		/* state change failure is ok if we're in DELETING state */
+		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
+		return;
+	}
+
 	ctrl->ctrl.nr_reconnects = 0;
 
 	nvme_start_ctrl(&ctrl->ctrl);
-- 
2.7.4
