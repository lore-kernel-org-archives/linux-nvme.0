From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat,  4 May 2019 20:39:23 +0900
Subject: [PATCH] nvme-pci: Fix queue_count to consider nr_possible_cpu
Message-ID: <20190504113923.32316-1-minwoo.im.dev@gmail.com>

The parameter should be set with the updated count 'n' instead of
'val' itself.  The local variable 'cnt' is sized in 6bytes because nvme
supports up to 65536 io queues.

Fixes: 3b6592f70("nvme: utilize two queue maps, one for reads and one
for writes")
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3e4fb891a95a..d3be3193d023 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -147,6 +147,7 @@ static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 static int queue_count_set(const char *val, const struct kernel_param *kp)
 {
 	int n, ret;
+	char cnt[6];
 
 	ret = kstrtoint(val, 10, &n);
 	if (ret)
@@ -154,7 +155,8 @@ static int queue_count_set(const char *val, const struct kernel_param *kp)
 	if (n > num_possible_cpus())
 		n = num_possible_cpus();
 
-	return param_set_int(val, kp);
+	sprintf(cnt, "%d", n);
+	return param_set_int(cnt, kp);
 }
 
 static inline unsigned int sq_idx(unsigned int qid, u32 stride)
-- 
2.17.1
