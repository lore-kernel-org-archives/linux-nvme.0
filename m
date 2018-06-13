From: revanth.rajashekar@intel.com (Revanth Rajashekar)
Date: Wed, 13 Jun 2018 14:39:29 -0600
Subject: [PATCH] nvme-cli: Implement printing the get Keep Alive Timer feature
Message-ID: <20180613203929.12777-1-revanth.rajashekar@intel.com>

Signed-off-by: Revanth Rajashekar <revanth.rajashekar at intel.com>
---
 nvme-print.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/nvme-print.c b/nvme-print.c
index cdaf1cb..74af732 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1807,6 +1807,9 @@ void nvme_feature_show_fields(__u32 fid, unsigned int result, unsigned char *buf
 	case NVME_FEAT_RESV_PERSIST:
 		printf("\tPersist Through Power Loss (PTPL): %s\n", (result & 0x00000001) ? "True":"False");
 		break;
+	case NVME_FEAT_KATO:
+		printf("\tKeep Alive Timeout (KATO) in milliseconds: %u\n", result);
+		break;
 	}
 }
 
-- 
2.17.1
