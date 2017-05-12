From: luto@kernel.org (Andy Lutomirski)
Date: Thu, 11 May 2017 21:06:04 -0700
Subject: [PATCH] nvme: Change our APST table to be no more aggressive than
 Intel RSTe
Message-ID: <ddc5be5d81966effaf73e3cee54330c351bc8169.1494561654.git.luto@kernel.org>

It seems like RSTe is much more conservative with transition timing
that we are.  According to Mario, RSTe programs APST to transition from
active states to the first idle state after 60ms and, thereafter, to
1000 * the exit latency of the target state.

This is IMO a terrible policy.  On my Samsung 950, RSTe would set a
transition time of 22 seconds to the deepest state.  I suspect that
this means that the deepest state will essentially never be used in
practice.  Unfortunately, since RSTe does this, it's what the
manufacturers tested, and hardware or firmware bugs seem to have crept
in.  I'm having a bit of trouble imagining what would go wrong if the
hardware goes to sleep after merely one second that isn't a problem
after 22 seconds.  Maybe some PLLs are extremely slow to stabilize and
the firmware doesn't have appropriate safeguards, or maybe there are
power-fail caps that behave oddly when charged and dischaged too
quickly, but this is just idle speculation on my part.

This patch is a bit more conservative than RSTe's algorithm.  I think
that, if the first idle state has total latency that's too large (even
10ms, say), then 60ms is too fast and risks hurting performance
excessively.  I set the latency to the greater of 60ms and 50 *
(enlat+exlat).

Some testing reports suggest that this will fix the issues we've
seen on Dell laptops.

Cc: stable at vger.kernel.org # v4.11
Cc: Kai-Heng Feng <kai.heng.feng at canonical.com>
Cc: Mario Limonciello <mario_limonciello at dell.com>
Signed-off-by: Andy Lutomirski <luto at kernel.org>
---

Jens et all, I think this might be reasonable to apply for 4.12.

 drivers/nvme/host/core.c | 62 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5249027a76ca..fea682db2176 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1267,13 +1267,7 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
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
@@ -1282,6 +1276,7 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 
 	unsigned apste;
 	struct nvme_feat_auto_pst *table;
+	int first_idle_state = -1;
 	u64 max_lat_us = 0;
 	int max_ps = -1;
 	int ret;
@@ -1311,10 +1306,23 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 		int state;
 
 		/*
+		 * Find the first non-operational state.  We'll need it
+		 * for the idle time calculation.  NPSS, despite the
+		 * name, is the index of the lowest-power state, not the
+		 * number of states.
+		 */
+		for (state = 0; state <= (int)ctrl->npss; state++) {
+			if (ctrl->psd[state].flags &
+			    NVME_PS_FLAGS_NON_OP_STATE) {
+				first_idle_state = state;
+				break;
+			}
+		}
+
+		/*
 		 * Walk through all states from lowest- to highest-power.
 		 * According to the spec, lower-numbered states use more
-		 * power.  NPSS, despite the name, is the index of the
-		 * lowest-power state, not the number of states.
+		 * power.
 		 */
 		for (state = (int)ctrl->npss; state >= 0; state--) {
 			u64 total_latency_us, transition_ms;
@@ -1348,8 +1356,40 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 			 * This state is good.  Use it as the APST idle
 			 * target for higher power states.
 			 */
-			transition_ms = total_latency_us + 19;
-			do_div(transition_ms, 20);
+			if (state == first_idle_state) {
+				/*
+				 * Intel RSTe supposedly uses 60ms for the
+				 * first idle state regardless of its latency.
+				 * This seems overly aggressive -- if the
+				 * first idle state is slow, we could spend
+				 * an excessive fraction of the time
+				 * transitioning back and forth.
+				 *
+				 * Instead, use 50 * (enlat + exlat) so
+				 * we spend at most 2% of the time
+				 * transitioning between power states.
+				 */
+				transition_ms = total_latency_us + 19;
+				do_div(transition_ms, 20);
+
+				/* Don't be more aggressive than Intel RSTe. */
+				if (transition_ms < 60)
+					transition_ms = 60;
+			} else {
+				/*
+				 * Intel RSTe supposedly sets the
+				 * transition time to states after the
+				 * first to 1000 * exlat.  This seems quite
+				 * conservative, but it also seems that vendors
+				 * don't test their hardware with more
+				 * aggressive settings.  (The factor of 1000
+				 * is implicit: exlat is in microsections.)
+				 */
+				transition_ms =
+					le32_to_cpu(ctrl->psd[state].exit_lat);
+			}
+
+			/* Clamp to the maximum time allowed by the spec. */
 			if (transition_ms > (1 << 24) - 1)
 				transition_ms = (1 << 24) - 1;
 
-- 
2.9.3
