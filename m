From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 Apr 2014 18:53:50 -0600
Subject: [PATCH] NVMe: Protect against badly formatted CQEs
Message-ID: <1398387230-23686-1-git-send-email-keith.busch@intel.com>

If a misbehaving device posts a CQE with a command id < depth but for
one that was never allocated, the command info will have a callback
function set to NULL and we don't want to try invoking that.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index efa9c8f..d4aa4ff 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -247,8 +247,9 @@ static void *free_cmdid(struct nvme_queue *nvmeq, int cmdid,
 	void *ctx;
 	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
 
-	if (cmdid >= nvmeq->q_depth) {
-		*fn = special_completion;
+	if (cmdid >= nvmeq->q_depth || !info[cmdid].fn) {
+		if (fn)
+			*fn = special_completion;
 		return CMD_CTX_INVALID;
 	}
 	if (fn)
-- 
1.7.10.4
