From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Fri, 17 May 2019 01:41:29 +0900
Subject: [PATCH] nvme-cli: remove unused NVME_AER_NOTICE_*
Message-ID: <1558024889-9474-1-git-send-email-akinobu.mita@gmail.com>

NVME_AER_NOTICE_* are unused and these values conflict with the values
defined in the kernel nvme.h.

Cc: Keith Busch <keith.busch at intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 linux/nvme.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index cac4d19..13fa52a 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -589,9 +589,6 @@ enum {
 	NVME_AER_SMART			= 1,
 	NVME_AER_CSS			= 6,
 	NVME_AER_VS			= 7,
-	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
-	NVME_AER_NOTICE_ANA		= 0x0003,
-	NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
 };
 
 struct nvme_lba_range_type {
-- 
2.7.4
