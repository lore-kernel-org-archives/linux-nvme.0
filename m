From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 16 Jul 2018 12:59:08 +0300
Subject: [PATCH v1] nvmet: Don't use uuid_le type
Message-ID: <20180716095908.7690-1-andriy.shevchenko@linux.intel.com>

Don't use sizeof(uuid_le) where none of the parameters is type of uuid_le.
Since both arguments are u8 [16], use plain number there.

Moreover, uuid_le is a deprecated type, and nvmet is using uuid_t
already.

Signed-off-by: Andy Shevchenko <andriy.shevchenko at linux.intel.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 38803576d5e1..f832be8245cd 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -308,7 +308,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 */
 	id->nmic = (1 << 0);
 
-	memcpy(&id->nguid, &ns->nguid, sizeof(uuid_le));
+	memcpy(&id->nguid, &ns->nguid, 16);
 
 	id->lbaf[0].ds = ns->blksize_shift;
 
-- 
2.18.0
