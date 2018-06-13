From: revanth.rajashekar@intel.com (Revanth Rajashekar)
Date: Wed, 13 Jun 2018 14:15:31 -0600
Subject: [PATCH] nvme-cli: Implement printing the get host controlled thermal
 management feature.
Message-ID: <20180613201531.12027-1-revanth.rajashekar@intel.com>

Signed-off-by: Revanth Rajashekar <revanth.rajashekar at intel.com>
---
 linux/nvme.h | 1 +
 nvme-print.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/linux/nvme.h b/linux/nvme.h
index 01b4e6d..62e18fc 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -857,6 +857,7 @@ enum {
 	NVME_FEAT_HOST_MEM_BUF	= 0x0d,
 	NVME_FEAT_TIMESTAMP	= 0x0e,
 	NVME_FEAT_KATO		= 0x0f,
+	NVME_FEAT_HCTM		= 0X10,
 	NVME_FEAT_RRL		= 0x12,
 	NVME_FEAT_PLM_CONFIG	= 0x13,
 	NVME_FEAT_PLM_WINDOW	= 0x14,
diff --git a/nvme-print.c b/nvme-print.c
index cdaf1cb..3ff9b83 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1450,6 +1450,7 @@ char *nvme_feature_to_string(int feature)
 	case NVME_FEAT_HOST_ID:		return "Host Identifier";
 	case NVME_FEAT_RESV_MASK:	return "Reservation Notification Mask";
 	case NVME_FEAT_RESV_PERSIST:	return "Reservation Persistence";
+	case NVME_FEAT_HCTM:		return "Host Controlled Thermal Management";
 	default:			return "Unknown";
 	}
 }
@@ -1807,6 +1808,10 @@ void nvme_feature_show_fields(__u32 fid, unsigned int result, unsigned char *buf
 	case NVME_FEAT_RESV_PERSIST:
 		printf("\tPersist Through Power Loss (PTPL): %s\n", (result & 0x00000001) ? "True":"False");
 		break;
+	case NVME_FEAT_HCTM:
+		printf("\tThermal Management Temperature 1 (TMT1) : %u Kelvin\n", (result >> 16));
+		printf("\tThermal Management Temperature 2 (TMT2) : %u Kelvin\n", (result & 0x0000ffff));
+		break;
 	}
 }
 
-- 
2.17.1
