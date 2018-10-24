From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 24 Oct 2018 11:41:32 -0700
Subject: [PATCH] nvme-cli: fix sanitize status endianness
Message-ID: <20181024184132.10795-1-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme-print.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 2799ab7..3195cdc 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1597,9 +1597,10 @@ static void show_sanitize_log_sstat(__u16 status)
 void show_sanitize_log(struct nvme_sanitize_log_page *sanitize, unsigned int mode, const char *devname)
 {
 	int human = mode & HUMAN;
+	__u16 status = le16_to_cpu(sanitize->status) & NVME_SANITIZE_LOG_STATUS_MASK;
 
 	printf("Sanitize Progress                     (SPROG) :  %u", le32_to_cpu(sanitize->progress));
-	if (human && (sanitize->status & NVME_SANITIZE_LOG_STATUS_MASK) == NVME_SANITIZE_LOG_IN_PROGESS)
+	if (human && status == NVME_SANITIZE_LOG_IN_PROGESS)
 		show_sanitize_log_sprog(le32_to_cpu(sanitize->progress));
 	else
 		printf("\n");
@@ -2726,6 +2727,7 @@ void json_sanitize_log(struct nvme_sanitize_log_page *sanitize_log, const char *
 	struct json_object *sstat;
 	const char *status_str;
 	char str[128];
+	__u16 status = le16_to_cpu(sanitize_log->status);
 
 	root = json_create_object();
 	dev = json_create_object();
@@ -2733,12 +2735,12 @@ void json_sanitize_log(struct nvme_sanitize_log_page *sanitize_log, const char *
 
 	json_object_add_value_int(dev, "sprog", le16_to_cpu(sanitize_log->progress));
 	json_object_add_value_int(sstat, "global_erased",
-			(le16_to_cpu(sanitize_log->status) & NVME_SANITIZE_LOG_GLOBAL_DATA_ERASED) >> 8);
+			(status & NVME_SANITIZE_LOG_GLOBAL_DATA_ERASED) >> 8);
 	json_object_add_value_int(sstat, "no_cmplted_passes",
-			(le16_to_cpu(sanitize_log->status) & NVME_SANITIZE_LOG_NUM_CMPLTED_PASS_MASK) >> 3);
+			(status & NVME_SANITIZE_LOG_NUM_CMPLTED_PASS_MASK) >> 3);
 
-	status_str = get_sanitize_log_sstat_status_str(sanitize_log->status);
-	sprintf(str, "(%d) %s", sanitize_log->status & NVME_SANITIZE_LOG_STATUS_MASK, status_str);
+	status_str = get_sanitize_log_sstat_status_str(status);
+	sprintf(str, "(%d) %s", status & NVME_SANITIZE_LOG_STATUS_MASK, status_str);
 	json_object_add_value_string(sstat, "status", str);
 
 	json_object_add_value_object(dev, "sstat", sstat);
-- 
2.17.0
