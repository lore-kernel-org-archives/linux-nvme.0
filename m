From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 24 May 2017 15:06:30 -0700
Subject: [PATCH 1/2] nvme: Wait at least 6000ms before entering the deepest
 idle state
In-Reply-To: <cover.1495663545.git.luto@kernel.org>
References: <cover.1495663545.git.luto@kernel.org>
Message-ID: <6760ae9459ba19657f8009a9231b97a71114a1e5.1495663545.git.luto@kernel.org>

This should at least make vendors less nervous about Linux's APST
policy.  I'm not aware of any concrete bugs it would fix (although I
was hoping it would fix the Samsung/Dell quirk).

Cc: stable at vger.kernel.org # v4.11
Cc: Kai-Heng Feng <kai.heng.feng at canonical.com>
Cc: Mario Limonciello <mario_limonciello at dell.com>
Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/core.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d5e0906262ea..381e9f813385 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1325,13 +1325,7 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 	/*
 	 * APST (Autonomous Power State Transition) lets us program a
 	 * table of power state transitions that the controller will
-	 * perform automatically.  We configure it with a simple
-	 * heuristic: we are willing to spend at most 2% of the time
-	 * transitioning between power states.  Therefore, when running
-	 * in any given state, we will enter the next lower-power
-	 * non-operational state after waiting 50 * (enlat + exlat)
-	 * microseconds, as long as that state's total latency is under
-	 * the requested maximum latency.
+	 * perform automatically.
 	 *
 	 * We will not autonomously enter any non-operational state for
 	 * which the total latency exceeds ps_max_latency_us.  Users
@@ -1405,9 +1399,39 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 			/*
 			 * This state is good.  Use it as the APST idle
 			 * target for higher power states.
+			 *
+			 * Intel RSTe supposedly uses the following algorithm:
+			 * 60ms delay to transition to the first
+			 * non-operational state and 1000*exlat to each
+			 * additional state.  This is problematic.  60ms is
+			 * too short if the first non-operational state has
+			 * high latency, and 1000*exlat into a state is
+			 * absurdly slow.  (exlat=22ms seems typical for the
+			 * deepest state.  A delay of 22 seconds to enter that
+			 * state means that it will almost never be entered at
+			 * all, wasting power and, worse, turning otherwise
+			 * easy-to-detect hardware/firmware bugs into sporadic
+			 * problems.
+			 *
+			 * Linux is willing to spend at most 2% of the time
+			 * transitioning between power states.  Therefore,
+			 * when running in any given state, we will enter the
+			 * next lower-power non-operational state after
+			 * waiting 50 * (enlat + exlat) microseconds, as long
+			 * as that state's total latency is under the
+			 * requested maximum latency.
 			 */
 			transition_ms = total_latency_us + 19;
 			do_div(transition_ms, 20);
+
+			/*
+			 * Some vendors have expressed nervousness about
+			 * entering the deepest state after less than six
+			 * seconds.
+			 */
+			if (state == ctrl->npss && transition_ms < 6000)
+				transition_ms = 6000;
+
 			if (transition_ms > (1 << 24) - 1)
 				transition_ms = (1 << 24) - 1;
 
-- 
2.9.4
