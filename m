From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 21 Feb 2015 15:17:45 +0800
Subject: [PATCH block] NVMe: nvme_meta_noop can be static
In-Reply-To: <201502211535.pykDvoRT%fengguang.wu@intel.com>
References: <201502211535.pykDvoRT%fengguang.wu@intel.com>
Message-ID: <20150221071745.GA54786@lkp-sb04>

drivers/block/nvme-core.c:2008:22: sparse: symbol 'nvme_meta_noop' was not declared. Should it be static?

Signed-off-by: Fengguang Wu <fengguang.wu at intel.com>
---
 nvme-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 3ffa57a..384c786 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2005,7 +2005,7 @@ static int nvme_noop_generate(struct blk_integrity_iter *iter)
 	return 0;
 }
 
-struct blk_integrity nvme_meta_noop = {
+static struct blk_integrity nvme_meta_noop = {
 	.name			= "NVME_META_NOOP",
 	.generate_fn		= nvme_noop_generate,
 	.verify_fn		= nvme_noop_verify,
