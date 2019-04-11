From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 12 Apr 2019 00:52:38 +0900
Subject: [PATCH 1/2] nvme: pci: Return -EINVAL if given nr_queue larger than
 nr_cpu
In-Reply-To: <20190411155239.1094-1-minwoo.im.dev@gmail.com>
References: <20190411155239.1094-1-minwoo.im.dev@gmail.com>
Message-ID: <20190411155239.1094-2-minwoo.im.dev@gmail.com>

"write_queues" and "poll_queues" can be configured by module parameters
with callback queue_count_set().

This function shall return a error if given number of queue is larger
than nr_possible_cpus due to blk-mq.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a90cf5d63aac..1a7f44924e0f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -152,7 +152,7 @@ static int queue_count_set(const char *val, const struct kernel_param *kp)
 	if (ret)
 		return ret;
 	if (n > num_possible_cpus())
-		n = num_possible_cpus();
+		return -EINVAL;
 
 	return param_set_int(val, kp);
 }
-- 
2.17.1
