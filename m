From: luto@kernel.org (Andy Lutomirski)
Date: Fri, 21 Apr 2017 16:19:22 -0700
Subject: [PATCH 1/3] nvme: Fix APST comment
In-Reply-To: <cover.1492816561.git.luto@kernel.org>
References: <cover.1492816561.git.luto@kernel.org>
Message-ID: <5339459748cb9c7918ea7c8d846ae462e48fedc3.1492816561.git.luto@kernel.org>

There was a typo in the description of the timeout heuristic.

Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eeb409c287b8..b0c692a14e9b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1267,7 +1267,7 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 	 * heuristic: we are willing to spend at most 2% of the time
 	 * transitioning between power states.  Therefore, when running
 	 * in any given state, we will enter the next lower-power
-	 * non-operational state after waiting 100 * (enlat + exlat)
+	 * non-operational state after waiting 50 * (enlat + exlat)
 	 * microseconds, as long as that state's total latency is under
 	 * the requested maximum latency.
 	 *
-- 
2.9.3
