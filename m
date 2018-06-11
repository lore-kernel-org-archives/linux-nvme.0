From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 11 Jun 2018 13:04:29 -0400
Subject: [PATCH V2] nvme-cli: fix compilation error
Message-ID: <20180611170429.3313-1-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Changes since V1:-
1. Use typecast instead of changing the format specifier.
---
 nvme-print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-print.c b/nvme-print.c
index b73a006..cdaf1cb 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1338,7 +1338,7 @@ void show_self_test_log(struct nvme_self_test_log *self_test, const char *devnam
 		temp = self_test->result[i].valid_diagnostic_info;
 		printf("  Valid Diagnostic Information : %#x\n", temp);
 		printf("  Power on hours (POH)         : %#"PRIx64"\n",
-			le64_to_cpu(self_test->result[i].power_on_hours));
+			(uint64_t)le64_to_cpu(self_test->result[i].power_on_hours));
 
 		if (temp & NVME_SELF_TEST_VALID_NSID)
 			printf("  Namespace Identifier         : %#x\n",
-- 
2.17.0
