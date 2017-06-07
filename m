From: kai.heng.feng@canonical.com (Kai-Heng Feng)
Date: Wed,  7 Jun 2017 15:25:42 +0800
Subject: [PATCH 1/2] nvme: only consider exit latency when choosing useful
 non-op power states
Message-ID: <20170607072543.14071-1-kai.heng.feng@canonical.com>

When a NVMe is in non-op states, the latency is exlat.
The latency will be enlat + exlat only when the NVMe tries to transit
from operational state right atfer it begins to transit to
non-operational state, which should be a rare case.

Therefore, as Andy Lutomirski suggests, use exlat only when deciding power
states to trainsit to.

Signed-off-by: Kai-Heng Feng <kai.heng.feng at canonical.com>
---
 drivers/nvme/host/core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0f9cc0c55e15..c07d8d4e18c9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1342,7 +1342,7 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 	 * transitioning between power states.  Therefore, when running
 	 * in any given state, we will enter the next lower-power
 	 * non-operational state after waiting 50 * (enlat + exlat)
-	 * microseconds, as long as that state's total latency is under
+	 * microseconds, as long as that state's exit latency is under
 	 * the requested maximum latency.
 	 *
 	 * We will not autonomously enter any non-operational state for
@@ -1387,7 +1387,7 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 		 * lowest-power state, not the number of states.
 		 */
 		for (state = (int)ctrl->npss; state >= 0; state--) {
-			u64 total_latency_us, transition_ms;
+			u64 total_latency_us, exit_latency_us, transition_ms;
 
 			if (target)
 				table->entries[state] = target;
@@ -1408,12 +1408,15 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 			      NVME_PS_FLAGS_NON_OP_STATE))
 				continue;
 
-			total_latency_us =
-				(u64)le32_to_cpu(ctrl->psd[state].entry_lat) +
-				+ le32_to_cpu(ctrl->psd[state].exit_lat);
-			if (total_latency_us > ctrl->ps_max_latency_us)
+			exit_latency_us =
+				(u64)le32_to_cpu(ctrl->psd[state].exit_lat);
+			if (exit_latency_us > ctrl->ps_max_latency_us)
 				continue;
 
+			total_latency_us =
+				exit_latency_us +
+				le32_to_cpu(ctrl->psd[state].entry_lat);
+
 			/*
 			 * This state is good.  Use it as the APST idle
 			 * target for higher power states.
-- 
2.13.0
