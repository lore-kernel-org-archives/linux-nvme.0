From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 24 Jan 2019 19:45:39 -0500
Subject: [PATCH] nvme-cli: fix compilation with uint64_t cast
Message-ID: <20190125004539.12211-1-chaitanya.kulkarni@wdc.com>

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Following is the compilation error for reference.

[root at mercury nvme-cli]# make 
cc -D_GNU_SOURCE -D__CHECK_ENDIAN__ -O2 -g -Wall -Werror -std=gnu99 -I. -DLIBUUID -DNVME_VERSION='"1.7.14.g37d4"' nvme.c -o nvme argconfig.o suffix.o parser.o nvme-print.o nvme-ioctl.o nvme-lightnvm.o fabrics.o json.o nvme-models.o plugin.o plugins/intel/intel-nvme.o plugins/lnvm/lnvm-nvme.o plugins/memblaze/memblaze-nvme.o plugins/wdc/wdc-nvme.o plugins/wdc/wdc-utils.o plugins/huawei/huawei-nvme.o plugins/netapp/netapp-nvme.o plugins/toshiba/toshiba-nvme.o plugins/micron/micron-nvme.o plugins/seagate/seagate-nvme.o -luuid
nvme.c: In function ???format???:
nvme.c:3056:38: error: format ???%lu??? expects argument of type ???long unsigned int???, but argument 3 has type ???__u64 {aka long long unsigned int}??? [-Werror=format=]
     "Invalid value for block size (%lu), must be a power of two\n",
                                    ~~^
                                    %llu
      cfg.bs);
      ~~~~~~                           
nvme.c:3091:42: error: format ???%lu??? expects argument of type ???long unsigned int???, but argument 3 has type ???__u64 {aka long long unsigned int}??? [-Werror=format=]
      "LBAF corresponding to block size %lu (LBAF %u) not found\n",
                                        ~~^
                                        %llu
      cfg.bs, lbads);
      ~~~~~~                               



cc1: all warnings being treated as errors
make: *** [nvme] Error 1

Git tree HEAD for reference :-

$ git log -1 
commit 4f474f0f9c0704c538d5bbdb6f4a70f1373b7943
Merge: eb58f54 254bcd6
Author: Keith Busch <keith.busch at intel.com>
Date:   Tue Jan 22 09:27:09 2019 -0700

    Merge pull request #451 from leitao/master
    
    Fix building issues
---
 nvme.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/nvme.c b/nvme.c
index e85834d..8922ec2 100644
--- a/nvme.c
+++ b/nvme.c
@@ -3053,8 +3053,8 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 	if (cfg.bs) {
 		if ((cfg.bs & (~cfg.bs + 1)) != cfg.bs) {
 			fprintf(stderr,
-				"Invalid value for block size (%lu), must be a power of two\n",
-					cfg.bs);
+				"Invalid value for block size (%"PRIu64"), must be a power of two\n",
+				       (uint64_t) cfg.bs);
 				return EINVAL;
 		}
 	}
@@ -3088,8 +3088,8 @@ static int format(int argc, char **argv, struct command *cmd, struct plugin *plu
 			}
 			if (cfg.lbaf == 0xff) {
 				fprintf(stderr,
-					"LBAF corresponding to block size %lu (LBAF %u) not found\n",
-					cfg.bs, lbads);
+					"LBAF corresponding to block size %"PRIu64"(LBAF %u) not found\n",
+					(uint64_t)cfg.bs, lbads);
 				fprintf(stderr,
 					"Please correct block size, or specify LBAF directly\n");
 				return EINVAL;
-- 
2.14.1
