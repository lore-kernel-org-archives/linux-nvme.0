From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 19 Apr 2017 20:02:14 -0700
Subject: [PATCH 1/5] nvme: Fix APST comment
In-Reply-To: <cover.1492656278.git.luto@kernel.org>
References: <cover.1492656278.git.luto@kernel.org>
Message-ID: <73505aedab12236d4d54add4db0b5c0d27905d8c.1492656278.git.luto@kernel.org>

There was a typo in the description of the timeout heuristic.

Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9583a5f58a1d..4fc58866640e 100644
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
