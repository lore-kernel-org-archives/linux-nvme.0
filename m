From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 14 Feb 2019 14:50:54 -0800
Subject: [PATCH 3/6] nvme-pci: Check kstrtoint() return value in
 queue_count_set()
In-Reply-To: <20190214225057.195397-1-bvanassche@acm.org>
References: <20190214225057.195397-1-bvanassche@acm.org>
Message-ID: <20190214225057.195397-4-bvanassche@acm.org>

This patch avoids that the compiler complains about 'ret' being set
but not being used when building with W=1.

Fixes: 3b6592f70ad7 ("nvme: utilize two queue maps, one for reads and one for writes") # v5.0-rc1
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9bc585415d9b..03b9524a1e0b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -157,6 +157,8 @@ static int queue_count_set(const char *val, const struct kernel_param *kp)
 	int n = 0, ret;
 
 	ret = kstrtoint(val, 10, &n);
+	if (ret)
+		return ret;
 	if (n > num_possible_cpus())
 		n = num_possible_cpus();
 
-- 
2.21.0.rc0.258.g878e2cd30e-goog
