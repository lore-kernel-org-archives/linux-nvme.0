From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:23:06 -0700
Subject: [PATCH 15/18] add missing endianess conversions in json_smart_log
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-16-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 nvme-print.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index f9a8ff6..ac56fce 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1395,8 +1395,10 @@ void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 	json_object_add_value_float(root, "unsafe_shutdowns", unsafe_shutdowns);
 	json_object_add_value_float(root, "media_errors", media_errors);
 	json_object_add_value_float(root, "num_err_log_entries", num_err_log_entries);
-	json_object_add_value_int(root, "warning_temp_time", smart->warning_temp_time);
-	json_object_add_value_int(root, "critical_comp_time", smart->critical_comp_time);
+	json_object_add_value_int(root, "warning_temp_time",
+			le32_to_cpu(smart->warning_temp_time));
+	json_object_add_value_int(root, "critical_comp_time",
+			le32_to_cpu(smart->critical_comp_time));
 
 	json_print_object(root, NULL);
 	printf("\n");
-- 
2.1.4
