From: ednadols@linux.microsoft.com (Edmund Nadolski)
Date: Mon, 29 Apr 2019 10:35:33 -0700
Subject: [PATCH 2/2] nvme: add clarifying comments and fix some typos
In-Reply-To: <20190429173533.10366-1-ednadols@linux.microsoft.com>
References: <20190429173533.10366-1-ednadols@linux.microsoft.com>
Message-ID: <20190429173533.10366-3-ednadols@linux.microsoft.com>

Add comment descriptions for struct fields per NVMe spec.

Signed-off-by: Edmund Nadolski <ednadols at linux.microsoft.com>
---
 drivers/nvme/host/nvme.h | 32 ++++++++++++++++----------------
 drivers/nvme/host/pci.c  |  2 +-
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 527d64545023..61736d1ef15e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -177,7 +177,7 @@ struct nvme_ctrl {
 	u16 cntlid;
 
 	u32 ctrl_config;
-	u16 mtfa;
+	u16 mtfa;		/* maximum time for firmware activation */
 	u32 queue_count;
 
 	u64 cap;
@@ -185,23 +185,23 @@ struct nvme_ctrl {
 	u32 max_hw_sectors;
 	u32 max_segments;
 	u16 crdt[3];
-	u16 oncs;
-	u16 oacs;
-	u16 nssa;
+	u16 oncs;		/* optional nvm command support */
+	u16 oacs;		/* optional admin command support */
+	u16 nssa;		/* nvme subsystem streams available */
 	u16 nr_streams;
 	u32 max_namespaces;
 	atomic_t abort_limit;
-	u8 vwc;
-	u32 vs;
-	u32 sgls;
-	u16 kas;
-	u8 npss;
-	u8 apsta;
-	u32 oaes;
+	u8 vwc;			/* volatile write cache */
+	u32 vs;			/* version */
+	u32 sgls;		/* scatter gather list support */
+	u16 kas;		/* keep alive support */
+	u8 npss;		/* number of power states supported */
+	u8 apsta;		/* autonomous power state transition */
+	u32 oaes;		/* optional asynchronous events supported */
 	u32 aen_result;
-	u32 ctratt;
+	u32 ctratt;		/* controller attribute */
 	unsigned int shutdown_timeout;
-	unsigned int kato;
+	unsigned int kato;	/* keep alive timeout */
 	bool subsystem;
 	unsigned long quirks;
 	struct nvme_id_power_state psd[32];
@@ -231,8 +231,8 @@ struct nvme_ctrl {
 	bool apst_enabled;
 
 	/* PCIe only: */
-	u32 hmpre;
-	u32 hmmin;
+	u32 hmpre;	/* host memory buffer preferred size */
+	u32 hmmin;	/* host memory buffer minimum size */
 	u32 hmminds;
 	u16 hmmaxd;
 
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
index c1eecde6b853..368371c5cafc 100644
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
