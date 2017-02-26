From: chaitanya.kulkarni@hgst.com (Chaitanya Kulkarni)
Date: Sat, 25 Feb 2017 23:34:42 -0800
Subject: [PATCH] nvme-cli: smart-log: Allow negative values for temp sensors.
Message-ID: <1488094482-22323-1-git-send-email-chaitanya.kulkarni@hgst.com>

HGST devices allowed to produce valid negative values for
"Temperature Sensor 1" of the smart-log command. Change the
temperature sensor value from unsigned to signed so that
negative values will be printed correctly.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
---
 nvme-print.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 340317a..15129b7 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -805,8 +805,8 @@ void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 	printf("Warning Temperature Time            : %u\n", le32_to_cpu(smart->warning_temp_time));
 	printf("Critical Composite Temperature Time : %u\n", le32_to_cpu(smart->critical_comp_time));
 	for (c=0; c < 8; c++) {
-		__u16 temp = le16_to_cpu(smart->temp_sensor[c]);
-		printf("Temperature Sensor %d                : %u C\n", c + 1,
+		__s32 temp = le16_to_cpu(smart->temp_sensor[c]);
+		printf("Temperature Sensor %d                : %d C\n", c + 1,
 			temp ? temp - 273 : 0);
 	}
 }
-- 
1.9.1
