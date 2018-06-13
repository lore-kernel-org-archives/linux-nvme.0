From: revanth.rajashekar@intel.com (Revanth Rajashekar)
Date: Wed, 13 Jun 2018 13:53:52 -0600
Subject: [PATCH] nvme-cli: Implement printing the get timestamp feature.
Message-ID: <20180613195352.11657-1-revanth.rajashekar@intel.com>

Signed-off-by: Revanth Rajashekar <revanth.rajashekar at intel.com>
---
 nvme-print.c | 15 +++++++++++++++
 nvme.c       |  3 +++
 nvme.h       |  6 ++++++
 3 files changed, 24 insertions(+)

diff --git a/nvme-print.c b/nvme-print.c
index cdaf1cb..242eb4e 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1450,6 +1450,7 @@ char *nvme_feature_to_string(int feature)
 	case NVME_FEAT_HOST_ID:		return "Host Identifier";
 	case NVME_FEAT_RESV_MASK:	return "Reservation Notification Mask";
 	case NVME_FEAT_RESV_PERSIST:	return "Reservation Persistence";
+	case NVME_FEAT_TIMESTAMP:	return "Timestamp";
 	default:			return "Unknown";
 	}
 }
@@ -1634,6 +1635,17 @@ static void show_auto_pst(struct nvme_auto_pst *apst)
 	}
 }
 
+static void show_timestamp(struct nvme_timestamp *ts)
+{
+	printf("\tThe timestamp is : %lu\n", int48_to_long(ts->timestamp));
+	printf("\t%s\n", (ts->attr & 2) ? "The Timestamp field was initialized with a "\
+			"Timestamp value using a Set Features command." : "The Timestamp field was initialized "\
+			"to ?0? by a Controller Level Reset.");
+	printf("\t%s\n", (ts->attr & 1) ? "The controller may have stopped counting during vendor specific "\
+			"intervals after the Timestamp value was initialized" : "The controller counted time in milliseconds "\
+			"continuously since the Timestamp value was initialized.");
+}
+
 static void show_host_mem_buffer(struct nvme_host_mem_buffer *hmb)
 {
 	printf("\tHost Memory Descriptor List Entry Count (HMDLEC): %u\n", hmb->hmdlec);
@@ -1807,6 +1819,9 @@ void nvme_feature_show_fields(__u32 fid, unsigned int result, unsigned char *buf
 	case NVME_FEAT_RESV_PERSIST:
 		printf("\tPersist Through Power Loss (PTPL): %s\n", (result & 0x00000001) ? "True":"False");
 		break;
+	case NVME_FEAT_TIMESTAMP:
+		show_timestamp((struct nvme_timestamp *)buf);
+		break;
 	}
 }
 
diff --git a/nvme.c b/nvme.c
index db0337a..2dd74d2 100644
--- a/nvme.c
+++ b/nvme.c
@@ -2072,6 +2072,9 @@ static int get_feature(int argc, char **argv, struct command *cmd, struct plugin
 	case NVME_FEAT_PLM_CONFIG:
 		cfg.data_len = 512;
 		break;
+	case NVME_FEAT_TIMESTAMP:
+		cfg.data_len = 8;
+		break;
 	}
 
 	if (cfg.sel == 3)
diff --git a/nvme.h b/nvme.h
index 94e42f1..5098b0e 100644
--- a/nvme.h
+++ b/nvme.h
@@ -76,6 +76,12 @@ struct nvme_auto_pst {
 	__u32	rsvd32;
 };
 
+struct nvme_timestamp {
+	__u8 timestamp[6];
+	__u8 attr;
+	__u8 rsvd;
+};
+
 struct nvme_controller_list {
 	__le16 num;
 	__le16 identifier[];
-- 
2.17.1
