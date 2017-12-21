From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Dec 2017 12:07:50 +0200
Subject: [PATCH 4.15-rc 1/3] nvme-core: Don't set nvme_wq as MEM_RECLAIM
In-Reply-To: <20171221100752.18386-1-sagi@grimberg.me>
References: <20171221100752.18386-1-sagi@grimberg.me>
Message-ID: <20171221100752.18386-2-sagi@grimberg.me>

From: Roy Shterman <roys@lightbitslabs.com>

nvme_wq is not a MEM_RECLAIM workqueue because it
can allocate memory in some of the works it is executing.

Signed-off-by: Roy Shterman <roys at lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c33f848ab49d..221c97d57562 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3490,7 +3490,7 @@ int __init nvme_core_init(void)
 	int result;
 
 	nvme_wq = alloc_workqueue("nvme-wq",
-			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+			WQ_UNBOUND | WQ_SYSFS, 0);
 	if (!nvme_wq)
 		return -ENOMEM;
 
-- 
2.14.1
