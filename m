From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri,  3 Jun 2016 14:44:18 +0200
Subject: [PATCH] nvme: lightnvme: make MLC num_pairs little endian
Message-ID: <1464957858-59392-1-git-send-email-jthumshirn@suse.de>

According to the OpenChannel SSD interface specification the NAND flash
MLC page pairing information's number of page page pairings field is the
first two bytes in the MLC Page Pairing data structure. The hardware's
data structure itself is little endian so annotate it as such, like the
rest of lighnvm's data structures.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/lightnvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 9461dd6..ea36cbb 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -156,7 +156,7 @@ struct nvme_nvm_completion {
 
 #define NVME_NVM_LP_MLC_PAIRS 886
 struct nvme_nvm_lp_mlc {
-	__u16			num_pairs;
+	__le16			num_pairs;
 	__u8			pairs[NVME_NVM_LP_MLC_PAIRS];
 };
 
-- 
1.8.5.6
