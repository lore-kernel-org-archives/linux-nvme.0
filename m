From: revanth.rajashekar@intel.com (Revanth Rajashekar)
Date: Wed, 13 Jun 2018 15:21:43 -0600
Subject: [PATCH] nvme-cli: Implement printing get NOPSC feature
Message-ID: <20180613212143.13940-1-revanth.rajashekar@intel.com>

Signed-off-by: Revanth Rajashekar <revanth.rajashekar at intel.com>
---
 linux/nvme.h | 1 +
 nvme-print.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/linux/nvme.h b/linux/nvme.h
index 01b4e6d..e75a4b0 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -857,6 +857,7 @@ enum {
 	NVME_FEAT_HOST_MEM_BUF	= 0x0d,
 	NVME_FEAT_TIMESTAMP	= 0x0e,
 	NVME_FEAT_KATO		= 0x0f,
+	NVME_FEAT_NOPSC		= 0X11,
 	NVME_FEAT_RRL		= 0x12,
 	NVME_FEAT_PLM_CONFIG	= 0x13,
 	NVME_FEAT_PLM_WINDOW	= 0x14,
diff --git a/nvme-print.c b/nvme-print.c
index cdaf1cb..adc7b3a 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1443,6 +1443,7 @@ char *nvme_feature_to_string(int feature)
 	case NVME_FEAT_AUTO_PST:	return "Autonomous Power State Transition";
 	case NVME_FEAT_HOST_MEM_BUF:	return "Host Memory Buffer";
 	case NVME_FEAT_KATO:		return "Keep Alive Timer";
+	case NVME_FEAT_NOPSC:		return "Non-Operational Power State Config";
 	case NVME_FEAT_RRL:		return "Read Recovery Level";
 	case NVME_FEAT_PLM_CONFIG:	return "Predicatable Latency Mode Config";
 	case NVME_FEAT_PLM_WINDOW:	return "Predicatable Latency Mode Window";
@@ -1807,6 +1808,9 @@ void nvme_feature_show_fields(__u32 fid, unsigned int result, unsigned char *buf
 	case NVME_FEAT_RESV_PERSIST:
 		printf("\tPersist Through Power Loss (PTPL): %s\n", (result & 0x00000001) ? "True":"False");
 		break;
+	case NVME_FEAT_NOPSC:
+		printf("\tNon-Operational Power State Permissive Mode Enable (NOPPME): %s\n", (result & 1) ? "True" : "False");
+		break;
 	}
 }
 
-- 
2.17.1
