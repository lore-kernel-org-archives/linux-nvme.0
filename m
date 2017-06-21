From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 21 Jun 2017 13:09:22 +0800
Subject: [PATCH 1/3] nvme-cli: add thermal management fields for smart-log
In-Reply-To: <1498021764-12092-1-git-send-email-guanjunxiong@huawei.com>
References: <1498021764-12092-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <1498021764-12092-2-git-send-email-guanjunxiong@huawei.com>

NVMe 1.3 introduce new thermal management temperature related
fields into the smart log page. Those fileds include
two temperature transition counts and two total time.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
---
 linux/nvme.h |  6 +++++-
 nvme-print.c | 12 ++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index b2c8dbb..d5f89f9 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -327,7 +327,11 @@ struct nvme_smart_log {
 	__le32			warning_temp_time;
 	__le32			critical_comp_time;
 	__le16			temp_sensor[8];
-	__u8			rsvd216[296];
+	__le32			thm_temp1_trans_count;
+	__le32			thm_temp2_trans_count;
+	__le32			thm_temp1_total_time;
+	__le32			thm_temp2_total_time;
+	__u8			rsvd232[280];
 };
 
 enum {
diff --git a/nvme-print.c b/nvme-print.c
index 2da5acd..1aacf11 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -901,6 +901,10 @@ void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 		printf("Temperature Sensor %d                : %d C\n", c + 1,
 			temp - 273);
 	}
+	printf("Thermal Management T1 Trans Count   : %u\n", le32_to_cpu(smart->thm_temp1_trans_count));
+	printf("Thermal Management T2 Trans Count   : %u\n", le32_to_cpu(smart->thm_temp2_trans_count));
+	printf("Thermal Management T1 Total Time    : %u\n", le32_to_cpu(smart->thm_temp1_total_time));
+	printf("Thermal Management T2 Total Time    : %u\n", le32_to_cpu(smart->thm_temp2_total_time));
 }
 
 char *nvme_feature_to_string(int feature)
@@ -1554,6 +1558,14 @@ void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 			le32_to_cpu(smart->warning_temp_time));
 	json_object_add_value_int(root, "critical_comp_time",
 			le32_to_cpu(smart->critical_comp_time));
+	json_object_add_value_int(root, "thm_temp1_trans_count",
+			le32_to_cpu(smart->thm_temp1_trans_count));
+	json_object_add_value_int(root, "thm_temp2_trans_count",
+			le32_to_cpu(smart->thm_temp2_trans_count));
+	json_object_add_value_int(root, "thm_temp1_total_time",
+			le32_to_cpu(smart->thm_temp1_total_time));
+	json_object_add_value_int(root, "thm_temp2_total_time",
+			le32_to_cpu(smart->thm_temp2_total_time));
 
 	json_print_object(root, NULL);
 	printf("\n");
-- 
2.11.1
