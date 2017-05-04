From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 May 2017 13:33:12 +0300
Subject: [PATCH 08/11] nvme: Don't allow to reset a reconnecting controller
In-Reply-To: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
Message-ID: <1493893995-27063-9-git-send-email-sagi@grimberg.me>

The reset operation is guaranteed to fail for all scenarios
but the esoteric case where in the last reconnect attempt
concurrent with the reset we happen to successfully reconnect.

We just deny initiating a reset if we are reconnecting.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5e0906262ea..cfc8f8da89c8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -165,7 +165,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
-		case NVME_CTRL_RECONNECTING:
 			changed = true;
 			/* FALLTHRU */
 		default:
-- 
2.7.4
