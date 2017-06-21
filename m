From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 21 Jun 2017 13:09:23 +0800
Subject: [PATCH 2/3] nvme-cli: add temperature sensor fields in json_smart_log
In-Reply-To: <1498021764-12092-1-git-send-email-guanjunxiong@huawei.com>
References: <1498021764-12092-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <1498021764-12092-3-git-send-email-guanjunxiong@huawei.com>

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
---
 nvme-print.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/nvme-print.c b/nvme-print.c
index 1aacf11..8c873cd 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1522,6 +1522,8 @@ void json_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname)
 void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname)
 {
 	struct json_object *root;
+	int c;
+	char key[21];
 
 	unsigned int temperature = ((smart->temperature[1] << 8) |
 		smart->temperature[0]);
@@ -1558,6 +1560,16 @@ void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 			le32_to_cpu(smart->warning_temp_time));
 	json_object_add_value_int(root, "critical_comp_time",
 			le32_to_cpu(smart->critical_comp_time));
+
+	for (c=0; c < 8; c++) {
+		__s32 temp = le16_to_cpu(smart->temp_sensor[c]);
+
+		if (temp == 0)
+			continue;
+		sprintf(key, "temperature_sensor_%d",c+1);
+		json_object_add_value_int(root, key, temp);
+	}
+
 	json_object_add_value_int(root, "thm_temp1_trans_count",
 			le32_to_cpu(smart->thm_temp1_trans_count));
 	json_object_add_value_int(root, "thm_temp2_trans_count",
-- 
2.11.1
