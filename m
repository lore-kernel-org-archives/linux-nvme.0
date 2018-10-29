From: lijie34@huawei.com (lijie)
Date: Mon, 29 Oct 2018 21:03:49 +0800
Subject: [PATCH] nvme-cli:fix a typo in SELF-TEST log
Message-ID: <1540818229-16288-1-git-send-email-lijie34@huawei.com>

This patch fixes a typo in SELF-TEST log.
---
 nvme-print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-print.c b/nvme-print.c
index 3195cdc..4cf4609 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1482,7 +1482,7 @@ void show_self_test_log(struct nvme_self_test_log *self_test, const char *devnam
 		"Operation was aborted due to a removal of a namespace from the namespace inventory",
 		"Operation was aborted due to the processing of a Format NVM command",
 		"A fatal error or unknown test error occurred while the controller was executing the"\
-		" device self-test operation andthe operation did not complete",
+		" device self-test operation and the operation did not complete",
 		"Operation completed with a segment that failed and the segment that failed is not known",
 		"Operation completed with one or more failed segments and the first segment that failed "\
 		"is indicated in the SegmentNumber field",
-- 
2.6.4.windows.1
