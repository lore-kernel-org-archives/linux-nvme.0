From: revanth.rajashekar@intel.com (Revanth Rajashekar)
Date: Fri, 15 Jun 2018 12:39:27 -0600
Subject: [4.19 PATCH] nvme.h: resync with nvme-cli
Message-ID: <20180615183927.13798-1-revanth.rajashekar@intel.com>

Added some feature ids present in nvme-cli but not kernel.

Signed-off-by: Revanth Rajashekar <revanth.rajashekar at intel.com>
---
 include/linux/nvme.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 2950ce957656..80dfedcf0bf7 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -749,6 +749,11 @@ enum {
 	NVME_FEAT_HOST_MEM_BUF	= 0x0d,
 	NVME_FEAT_TIMESTAMP	= 0x0e,
 	NVME_FEAT_KATO		= 0x0f,
+	NVME_FEAT_HCTM		= 0x10,
+	NVME_FEAT_NOPSC		= 0x11,
+	NVME_FEAT_RRL		= 0x12,
+	NVME_FEAT_PLM_CONFIG	= 0x13,
+	NVME_FEAT_PLM_WINDOW	= 0x14,
 	NVME_FEAT_SW_PROGRESS	= 0x80,
 	NVME_FEAT_HOST_ID	= 0x81,
 	NVME_FEAT_RESV_MASK	= 0x82,
-- 
2.17.1
