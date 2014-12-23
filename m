From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Tue, 23 Dec 2014 17:27:46 +0000
Subject: [PATCH][qemu-nvme] Improved support for CMBLOC and CMBSZ
Message-ID: <36F6EBABA23FEF4391AF72944D2289016ECA91F8@BBYEXM01.pmc-sierra.internal>

Added the ability to set the fields of the CMBLOC and CMBSZ registers
and ensured those registers are set correctly at initialization.

Signed-off-by: Stephen Bates <stephen.bates at pmcs.com>
---
 hw/block/nvme.c |   14 ++++++++++++--
 hw/block/nvme.h |   19 +++++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index b1bc0c7..4e81fb1 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1992,8 +1992,18 @@ static void nvme_init_pci(NvmeCtrl *n)
          * CMBLOC = BIR=2, OFST=0
          */
 
-        n->bar.cmbloc = 2;
-        n->bar.cmbsz = 0x7 | (0x2<<8) | (n->cmb << 12);
+        n->bar.cmbloc = 0;
+        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
+        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
+
+        n->bar.cmbsz = 0;
+        NVME_CMBSZ_SET_SQS(n->bar.cmbsz,   1);
+        NVME_CMBSZ_SET_CQS(n->bar.cmbsz,   1);
+        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 1);
+        NVME_CMBSZ_SET_RDS(n->bar.cmbsz,   0);
+        NVME_CMBSZ_SET_WDS(n->bar.cmbsz,   0);
+        NVME_CMBSZ_SET_SZU(n->bar.cmbsz,   2);
+        NVME_CMBSZ_SET_SZ(n->bar.cmbsz,    n->cmb);
 
         n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
         memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n, "nvme-cmb",
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 49a838d..3c0fda9 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -152,6 +152,10 @@ enum NvmeCmblocMask {
 #define NVME_CMBLOC_BIR(cmbloc) ((cmbloc >> CMBLOC_BIR_SHIFT)  & CMBLOC_BIR_MASK)
 #define NVME_CMBLOC_OFST(cmbloc)((cmbloc >> CMBLOC_OFST_SHIFT) & CMBLOC_OFST_MASK)
 
+#define NVME_CMBLOC_SET_BIR(cmbloc, val)   (cmbloc |= (uint64_t)(val & CMBLOC_BIR_MASK)  \
+                                                                   << CMBLOC_BIR_SHIFT)
+#define NVME_CMBLOC_SET_OFST(cmbloc, val)  (cmbloc |= (uint64_t)(val & CMBLOC_OFST_MASK)  \
+                                                                   << CMBLOC_OFST_SHIFT)
 enum NvmeCmbszShift {
     CMBSZ_SQS_SHIFT   = 0,
     CMBSZ_CQS_SHIFT   = 1,
@@ -180,6 +184,21 @@ enum NvmeCmbszMask {
 #define NVME_CMBSZ_SZU(cmbsz)  ((cmbsz >> CMBSZ_SZU_SHIFT)   & CMBSZ_SZU_MASK)
 #define NVME_CMBSZ_SZ(cmbsz)   ((cmbsz >> CMBSZ_SZ_SHIFT)    & CMBSZ_SZ_MASK)
 
+#define NVME_CMBSZ_SET_SQS(cmbsz, val)   (cmbsz |= (uint64_t)(val & CMBSZ_SQS_MASK)  \
+                                                                << CMBSZ_SQS_SHIFT)
+#define NVME_CMBSZ_SET_CQS(cmbsz, val)   (cmbsz |= (uint64_t)(val & CMBSZ_CQS_MASK)  \
+                                                                 << CMBSZ_CQS_SHIFT)
+#define NVME_CMBSZ_SET_LISTS(cmbsz, val) (cmbsz |= (uint64_t)(val & CMBSZ_LISTS_MASK)  \
+                                                                << CMBSZ_LISTS_SHIFT)
+#define NVME_CMBSZ_SET_RDS(cmbsz, val)   (cmbsz |= (uint64_t)(val & CMBSZ_RDS_MASK)  \
+                                                                << CMBSZ_RDS_SHIFT)
+#define NVME_CMBSZ_SET_WDS(cmbsz, val)   (cmbsz |= (uint64_t)(val & CMBSZ_WDS_MASK)  \
+                                                                << CMBSZ_WDS_SHIFT)
+#define NVME_CMBSZ_SET_SZU(cmbsz, val)   (cmbsz |= (uint64_t)(val & CMBSZ_SZU_MASK)  \
+                                                                << CMBSZ_SZU_SHIFT)
+#define NVME_CMBSZ_SET_SZ(cmbsz, val)    (cmbsz |= (uint64_t)(val & CMBSZ_SZ_MASK)  \
+                                                                << CMBSZ_SZ_SHIFT)
+
 #define NVME_CMBSZ_GETSIZE(cmbsz) (NVME_CMBSZ_SZ(cmbsz) * (1<<(12+4*NVME_CMBSZ_SZU(cmbsz))))
 
 typedef struct NvmeCmd {
-- 
1.7.10.4
