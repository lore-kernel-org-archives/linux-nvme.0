From: cgxu519@gmx.com (Chengguang Xu)
Date: Tue, 11 Dec 2018 07:24:34 +0800
Subject: [PATCH] nvme: add __exit annotation
Message-ID: <20181210232434.11615-1-cgxu519@gmx.com>

Add __exit annotation to cleanup helper which is only
called once in the module.

Signed-off-by: Chengguang Xu <cgxu519 at gmx.com>
---
 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 962012135b62..e63a445f18b6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3746,7 +3746,7 @@ int __init nvme_core_init(void)
 	return result;
 }
 
-void nvme_core_exit(void)
+void __exit nvme_core_exit(void)
 {
 	ida_destroy(&nvme_subsystems_ida);
 	class_destroy(nvme_subsys_class);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 081cbdcce880..e6b4856b25fd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -572,6 +572,6 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 }
 
 int __init nvme_core_init(void);
-void nvme_core_exit(void);
+void __exit nvme_core_exit(void);
 
 #endif /* _NVME_H */
-- 
2.17.2
