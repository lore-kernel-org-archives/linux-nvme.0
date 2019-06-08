From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun,  9 Jun 2019 03:02:18 +0900
Subject: [PATCH 2/3] nvme-pci: remove queue_count_ops for write,poll_queues
In-Reply-To: <20190608180219.17523-1-minwoo.im.dev@gmail.com>
References: <20190608180219.17523-1-minwoo.im.dev@gmail.com>
Message-ID: <20190608180219.17523-3-minwoo.im.dev@gmail.com>

queue_count_set() seems like that it has been provided to limit the
number of queue entries for write/poll queues.  But, the
queue_count_set() has been doing nothing but a parameter check even it
has num_possible_cpus() which is nop.

This patch removes entire queue_count_ops from the write_queues and
poll_queues.

Cc: Jens Axboe <axboe at fb.com>
Cc: Ming Lei <ming.lei at redhat.com>
Cc: Keith Busch <kbusch at kernel.org>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/pci.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 047785023892..20193b11ab0d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -68,20 +68,14 @@ static int io_queue_depth = 1024;
 module_param_cb(io_queue_depth, &io_queue_depth_ops, &io_queue_depth, 0644);
 MODULE_PARM_DESC(io_queue_depth, "set io queue depth, should >= 2");
 
-static int queue_count_set(const char *val, const struct kernel_param *kp);
-static const struct kernel_param_ops queue_count_ops = {
-	.set = queue_count_set,
-	.get = param_get_int,
-};
-
 static int write_queues;
-module_param_cb(write_queues, &queue_count_ops, &write_queues, 0644);
+module_param(write_queues, int, 0644);
 MODULE_PARM_DESC(write_queues,
 	"Number of queues to use for writes. If not set, reads and writes "
 	"will share a queue set.");
 
 static int poll_queues;
-module_param_cb(poll_queues, &queue_count_ops, &poll_queues, 0644);
+module_param(poll_queues, int, 0644);
 MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 
 struct nvme_dev;
@@ -146,19 +140,6 @@ static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 	return param_set_int(val, kp);
 }
 
-static int queue_count_set(const char *val, const struct kernel_param *kp)
-{
-	int n, ret;
-
-	ret = kstrtoint(val, 10, &n);
-	if (ret)
-		return ret;
-	if (n > num_possible_cpus())
-		n = num_possible_cpus();
-
-	return param_set_int(val, kp);
-}
-
 static inline unsigned int sq_idx(unsigned int qid, u32 stride)
 {
 	return qid * 2 * stride;
-- 
2.21.0
