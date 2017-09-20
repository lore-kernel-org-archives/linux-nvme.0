From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Sep 2017 14:06:13 +0300
Subject: [PATCH 2/2] nvme-rdma: give up reconnect if state change fails
In-Reply-To: <1505905573-25371-1-git-send-email-sagi@grimberg.me>
References: <1505905573-25371-1-git-send-email-sagi@grimberg.me>
Message-ID: <1505905573-25371-2-git-send-email-sagi@grimberg.me>

If we failed to transition to state LIVE after a successful
reconnect, then controller deletion already started. In this
case there is no point moving forward with reconnect.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 58983000964b..4460ec3a2c0f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -942,7 +942,11 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	WARN_ON_ONCE(!changed);
+	if (!changed) {
+		/* We are probably in DELETING state */
+		return;
+	}
+
 	ctrl->ctrl.nr_reconnects = 0;
 
 	nvme_start_ctrl(&ctrl->ctrl);
-- 
2.7.4
