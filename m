From: luto@kernel.org (Andy Lutomirski)
Date: Fri, 21 Apr 2017 16:19:23 -0700
Subject: [PATCH 2/3] nvme: Display raw APST configuration via DYNAMIC_DEBUG
In-Reply-To: <cover.1492816561.git.luto@kernel.org>
References: <cover.1492816561.git.luto@kernel.org>
Message-ID: <54e956746d3df270f0c99010909422d919989b0e.1492816561.git.luto@kernel.org>

Debugging APST is currently a bit of a pain.  This gives optional
simple log messages that describe the APST state.

The easiest way to use this is probably with the nvme_core.dyndbg=+p
module parameter.

Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b0c692a14e9b..05ba4f8bb73b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1278,6 +1278,8 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 
 	unsigned apste;
 	struct nvme_feat_auto_pst *table;
+	u64 max_lat_us = 0;
+	int max_ps = -1;
 	int ret;
 
 	/*
@@ -1299,6 +1301,7 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 	if (ctrl->ps_max_latency_us == 0) {
 		/* Turn off APST. */
 		apste = 0;
+		dev_dbg(ctrl->device, "APST disabled\n");
 	} else {
 		__le64 target = cpu_to_le64(0);
 		int state;
@@ -1348,9 +1351,22 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 
 			target = cpu_to_le64((state << 3) |
 					     (transition_ms << 8));
+
+			if (max_ps == -1)
+				max_ps = state;
+
+			if (total_latency_us > max_lat_us)
+				max_lat_us = total_latency_us;
 		}
 
 		apste = 1;
+
+		if (max_ps == -1) {
+			dev_dbg(ctrl->device, "APST enabled but no non-operational states are available\n");
+		} else {
+			dev_dbg(ctrl->device, "APST enabled: max PS = %d, max round-trip latency = %lluus, table = %*phN\n",
+				max_ps, max_lat_us, (int)sizeof(*table), table);
+		}
 	}
 
 	ret = nvme_set_features(ctrl, NVME_FEAT_AUTO_PST, apste,
-- 
2.9.3
