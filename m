From: james.p.freyensee@intel.com (Jay Freyensee)
Date: Thu,  2 Jun 2016 08:51:25 -0700
Subject: [PATCH] nvme: initialize variable before logical OR'ing it
Message-ID: <1464882685-4531-1-git-send-email-james.p.freyensee@intel.com>

It is typically not good coding or secure coding practice
to logical OR a variable without an initialization value first.
Here on this line:

integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;

BLK_INTEGRITY_DEVICE_CAPABLE is being OR'ed to a member variable
never set to an initial value. This patch fixes that.

Signed-off-by: Jay Freyensee <james.p.freyensee at intel.com>
Reviewed-by: Ming Lin <ming.l at samsung.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>

---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f6f6fdf..33fe610 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -843,6 +843,7 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 {
 	struct blk_integrity integrity;
 
+	memset(&integrity, 0, sizeof(integrity));
 	switch (ns->pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
 		integrity.profile = &t10_pi_type3_crc;
-- 
2.4.3
