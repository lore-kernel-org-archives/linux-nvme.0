From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 12 Apr 2019 00:52:39 +0900
Subject: [PATCH 2/2] nvme: pci: Do not initialize local_var
In-Reply-To: <20190411155239.1094-1-minwoo.im.dev@gmail.com>
References: <20190411155239.1094-1-minwoo.im.dev@gmail.com>
Message-ID: <20190411155239.1094-3-minwoo.im.dev@gmail.com>

Variable "n" will be assigned once kstrtoint() succeeds, otherwise it
will not be referred because kstrtoint() will return an error which
means go out from this function.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1a7f44924e0f..db894d4a37b6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -146,7 +146,7 @@ static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
 
 static int queue_count_set(const char *val, const struct kernel_param *kp)
 {
-	int n = 0, ret;
+	int n, ret;
 
 	ret = kstrtoint(val, 10, &n);
 	if (ret)
-- 
2.17.1
