From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Sun, 10 Jun 2018 22:03:41 -0400
Subject: [PATCH] nvme-cli: fix compilation error
Message-ID: <20180611020341.2647-1-chaitanya.kulkarni@wdc.com>

[root at q nvme-cli]# git log -1
commit 80f2d776e41128fbf7676d665dd6c9ee5aeeffcd (HEAD -> master, origin/master, origin/HEAD)
Merge: 2dda3f7 6d4b4b3
Author: Keith Busch <keith.busch at intel.com>
Date:   Fri Jun 8 16:19:27 2018 -0600

    Merge pull request #365 from maximveligan/master

    Wrote man page for telemetry

[root at q nvme-cli]# make
NVME_VERSION = 1.5.182.g80f2
cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 -DLIBUUID -DNVME_VERSION='"1.5.182.g80f2"' -c nvme-print.c
nvme-print.c: In function ?show_self_test_log?:
nvme-print.c:1282:4: error: format ?%lx? expects argument of type ?long unsigned int?, but argument 2 has type ?__le64? [-Werror=format=]
    le64_to_cpu(self_test->result[i].power_on_hours));
    ^
cc1: all warnings being treated as errors
make: *** [nvme-print.o] Error 1
[root at qemu nvme-cli]#

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 nvme-print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nvme-print.c b/nvme-print.c
index 3f679d2..0d91a82 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1278,7 +1278,7 @@ void show_self_test_log(struct nvme_self_test_log *self_test, const char *devnam
 
 		temp = self_test->result[i].valid_diagnostic_info;
 		printf("  Valid Diagnostic Information : %#x\n", temp);
-		printf("  Power on hours (POH)         : %#"PRIx64"\n",
+		printf("  Power on hours (POH)         : %#llx\n",
 			le64_to_cpu(self_test->result[i].power_on_hours));
 
 		if (temp & NVME_SELF_TEST_VALID_NSID)
-- 
2.17.0
