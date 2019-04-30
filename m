From: ednadols@linux.microsoft.com (Edmund Nadolski)
Date: Tue, 30 Apr 2019 13:09:05 -0700
Subject: [PATCH v2 2/2] nvme: fix some typos
In-Reply-To: <20190430200905.28341-1-ednadols@linux.microsoft.com>
References: <20190430200905.28341-1-ednadols@linux.microsoft.com>
Message-ID: <20190430200905.28341-3-ednadols@linux.microsoft.com>

Corrects a few trivial typos.

Signed-off-by: Edmund Nadolski <ednadols at linux.microsoft.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 drivers/nvme/host/pci.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 527d64545023..01dca6c18d7b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -290,7 +290,7 @@ struct nvme_ns_ids {
 /*
  * Anchor structure for namespaces.  There is one for each namespace in a
  * NVMe subsystem that any of our controllers can see, and the namespace
- * structure for each controller is chained of it.  For private namespaces
+ * structure for each controller is chained off it.  For private namespaces
  * there is a 1:1 relation to our namespace structures, that is ->list
  * only ever has a single entry for private namespaces.
  */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9b02c4576591..5b69147a7250 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -227,7 +227,7 @@ struct nvme_iod {
 };
 
 /*
- * Check we didin't inadvertently grow the command struct
+ * Check we didn't inadvertently grow the command struct
  */
 static inline void _nvme_check_size(void)
 {
-- 
2.20.1
