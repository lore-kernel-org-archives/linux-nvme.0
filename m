From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Nov 2015 11:55:28 -0700
Subject: [PATCH] lightnvm: Simplify config when disabled
Message-ID: <1448304928-10120-1-git-send-email-keith.busch@intel.com>

We shouldn't compile an object file to get empty implementations; conforms
to linux coding style on conditional compilation.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/Makefile   |  3 ++-
 drivers/nvme/host/lightnvm.c | 13 -------------
 drivers/nvme/host/nvme.h     | 14 ++++++++++++++
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 219dc206..a5fe239 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -1,4 +1,5 @@
 
 obj-$(CONFIG_BLK_DEV_NVME)     += nvme.o
 
-nvme-y		+= pci.o scsi.o lightnvm.o
+lightnvm-$(CONFIG_NVM)	:= lightnvm.o
+nvme-y		+= pci.o scsi.o $(lightnvm-y)
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 9202d1a..07451d6 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -22,8 +22,6 @@
 
 #include "nvme.h"
 
-#ifdef CONFIG_NVM
-
 #include <linux/nvme.h>
 #include <linux/bitops.h>
 #include <linux/lightnvm.h>
@@ -588,14 +586,3 @@ int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 	return 0;
 }
-#else
-int nvme_nvm_register(struct request_queue *q, char *disk_name)
-{
-	return 0;
-}
-void nvme_nvm_unregister(struct request_queue *q, char *disk_name) {};
-int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *id)
-{
-	return 0;
-}
-#endif /* CONFIG_NVM */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fdb4e5b..044253d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -136,8 +136,22 @@ int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr);
 int nvme_sg_io32(struct nvme_ns *ns, unsigned long arg);
 int nvme_sg_get_version_num(int __user *ip);
 
+#ifdef CONFIG_NVM
 int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *id);
 int nvme_nvm_register(struct request_queue *q, char *disk_name);
 void nvme_nvm_unregister(struct request_queue *q, char *disk_name);
+#else
+static inline int nvme_nvm_register(struct request_queue *q, char *disk_name)
+{
+	return 0;
+}
+
+static inline void nvme_nvm_unregister(struct request_queue *q, char *disk_name) {};
+
+static inline int nvme_nvm_ns_supported(struct nvme_ns *ns, struct nvme_id_ns *id)
+{
+	return 0;
+}
+#endif /* CONFIG_NVM */
 
 #endif /* _NVME_H */
-- 
2.6.2.307.g37023ba
