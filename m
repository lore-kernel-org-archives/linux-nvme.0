From: jonathan.derrick@intel.com (Jon Derrick)
Date: Mon, 22 Jun 2015 15:01:28 -0600
Subject: [PATCH] NVMe: Make nvme_meta_noop to supress Sparse warning
Message-ID: <1435006888-13851-1-git-send-email-jonathan.derrick@intel.com>

Supresses warning emitted by Sparse.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
Warning is:
drivers/block/nvme-core.c:545:22: warning: symbol 'nvme_meta_noop' was
not declared. Should it be static?

 drivers/block/nvme-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index a501d3e..7345a5f 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -542,7 +542,7 @@ static int nvme_noop_generate(struct blk_integrity_iter *iter)
 	return 0;
 }
 
-struct blk_integrity nvme_meta_noop = {
+static struct blk_integrity nvme_meta_noop = {
 	.name			= "NVME_META_NOOP",
 	.generate_fn		= nvme_noop_generate,
 	.verify_fn		= nvme_noop_verify,
-- 
2.1.4
