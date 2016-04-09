From: nab@daterainc.com (Nicholas A. Bellinger)
Date: Sat,  9 Apr 2016 03:04:42 +0000
Subject: [PATCH] nvme/host: Add missing blk_integrity tag_size + flags
 assignments
Message-ID: <1460171082-7212-1-git-send-email-nab@daterainc.com>

From: Nicholas Bellinger <nab@linux-iscsi.org>

While doing recent bring-up of nvme/host with target-core T10-PI,
I noticed /sys/block/nvme*/integrity/device_is_integrity_capable
was false, and /sys/block/nvme*/integrity/tag_size contained
a bogus value.

AFAICT outside of blk_integrity_compare() for DM + MD these
are informational values, but go ahead and add the missing
assignments for nvme/host to match what SCSI does within
sd_dif_config_host() for consistency's sake.

Cc: Keith Busch <keith.busch at intel.com>
Cc: Jay Freyensee <james.p.freyensee at intel.com>
Cc: Martin K. Petersen <martin.petersen at oracle.com>
Cc: Sagi Grimberg <sagig at grimberg.me>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Jens Axboe <axboe at fb.com>
Signed-off-by: Nicholas Bellinger <nab at linux-iscsi.org>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b8e22fe..cbd08f8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -674,10 +674,14 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 	switch (ns->pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
 		integrity.profile = &t10_pi_type3_crc;
+		integrity.tag_size = sizeof(u16) + sizeof(u32);
+		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
 		break;
 	case NVME_NS_DPS_PI_TYPE1:
 	case NVME_NS_DPS_PI_TYPE2:
 		integrity.profile = &t10_pi_type1_crc;
+		integrity.tag_size = sizeof(u16);
+		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
 		break;
 	default:
 		integrity.profile = NULL;
-- 
1.9.1
