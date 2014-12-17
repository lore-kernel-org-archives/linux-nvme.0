From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Wed, 17 Dec 2014 22:02:06 +0000
Subject: [PATCHv2][qemu-nvme] Enhancements to the CMB feature for NVM
 Express 1.2 devices.
Message-ID: <36F6EBABA23FEF4391AF72944D2289016ECA2B15@BBYEXM01.pmc-sierra.internal>

This patch adds additional configurability to the Controller Memory
Buffer of the QEMU 1.2 device and adds support for the CMBLOC and
CMBSZ registers which were added as part of the 1.2 specification.

The command-line argument cmb=<cmb> is now more than a flag and can be
used to set the size of the CMB (in MB). In additional the CMBLOC and
CMBSZ register are setup to reflect their appropriate values.

Signed-off-by: Stephen Bates <sbates at raithlin.com>
---
 hw/block/nvme.c |   26 ++++++++++++++++++--------
 hw/block/nvme.h |   45 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index f6369c5..6ad3377 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -9,7 +9,7 @@
  */
 
 /**
- * Reference Specs: http://www.nvmexpress.org, 1.1, 1.0e
+ * Reference Specs: http://www.nvmexpress.org, 1.2, 1.1, 1.0e
  *
  *  http://www.nvmexpress.org/resources/
  */
@@ -56,7 +56,7 @@
  *  meta=<int>       : Meta-data size, Default:0
  *  oncs=<oncs>      : Optional NVMe command support, Default:DSM
  *  oacs=<oacs>      : Optional Admin command support, Default:Format
- *  cmb=<cmb>        : Controller Memory Buffer, Default:0
+ *  cmb=<cmb>        : Controller Memory Buffer, size in MB, Default:0
  *
  * The logical block formats all start at 512 byte blocks and double for the
  * next index. If meta-data is non-zero, half the logical block formats will
@@ -1980,14 +1980,24 @@ static void nvme_init_pci(NvmeCtrl *n)
     msi_init(&n->parent_obj, 0x50, 32, true, false);
 
     if (n->cmb) {
-        n->cmbuf = g_malloc0(0x8000000);
-        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n, "nvme-cmb", 0x8000000);
-        pci_register_bar(&n->parent_obj, 2,
+
+        /* If CMB is requested it is setup here. Currently n->cmb
+         * determines size in MB. All other properties are hard-coded
+         * (for now) to:
+         * CMBSZ  = SQS=1, CQS=1, LISTS=1, RDS=0, WDS=0, SZU=1MB
+         * CMBLOC = BIR=2, OFST=0
+         */
+
+        n->bar.cmbloc = 2;
+        n->bar.cmbsz = 0x7 | (0x2<<8) | (n->cmb << 12);
+
+        n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
+        memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n, "nvme-cmb",
+                              NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
+        pci_register_bar(&n->parent_obj, NVME_CMBLOC_BIR(n->bar.cmbloc),
             PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64,
             &n->ctrl_mem);
 
-        n->bar.cmbloc = 2; /* BAR 2 is exclusive for CMB */
-        n->bar.cmbsz = 0x7 | (0x8000 << 12); /* CQ, SQ, and PRP's, 4k sized units , 32k units */
     }
 }
 
@@ -2070,7 +2080,7 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT8("dps", NvmeCtrl, dps, 0),
     DEFINE_PROP_UINT8("mc", NvmeCtrl, mc, 0),
     DEFINE_PROP_UINT8("meta", NvmeCtrl, meta, 0),
-    DEFINE_PROP_UINT8("cmb", NvmeCtrl, cmb, 0),
+    DEFINE_PROP_UINT16("cmb", NvmeCtrl, cmb, 0),
     DEFINE_PROP_UINT16("oacs", NvmeCtrl, oacs, NVME_OACS_FORMAT),
     DEFINE_PROP_UINT16("oncs", NvmeCtrl, oncs, NVME_ONCS_DSM),
     DEFINE_PROP_UINT16("vid", NvmeCtrl, vid, PCI_VENDOR_ID_INTEL),
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index c8aed7d..49a838d 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -139,6 +139,49 @@ enum NvmeAqaMask {
 #define NVME_AQA_ASQS(aqa) ((aqa >> AQA_ASQS_SHIFT) & AQA_ASQS_MASK)
 #define NVME_AQA_ACQS(aqa) ((aqa >> AQA_ACQS_SHIFT) & AQA_ACQS_MASK)
 
+enum NvmeCmblocShift {
+    CMBLOC_BIR_SHIFT  = 0,
+    CMBLOC_OFST_SHIFT = 12,
+};
+
+enum NvmeCmblocMask {
+    CMBLOC_BIR_MASK  = 0x7,
+    CMBLOC_OFST_MASK = 0xfffff,
+};
+
+#define NVME_CMBLOC_BIR(cmbloc) ((cmbloc >> CMBLOC_BIR_SHIFT)  & CMBLOC_BIR_MASK)
+#define NVME_CMBLOC_OFST(cmbloc)((cmbloc >> CMBLOC_OFST_SHIFT) & CMBLOC_OFST_MASK)
+
+enum NvmeCmbszShift {
+    CMBSZ_SQS_SHIFT   = 0,
+    CMBSZ_CQS_SHIFT   = 1,
+    CMBSZ_LISTS_SHIFT = 2,
+    CMBSZ_RDS_SHIFT   = 3,
+    CMBSZ_WDS_SHIFT   = 4,
+    CMBSZ_SZU_SHIFT   = 8,
+    CMBSZ_SZ_SHIFT    = 12,
+};
+
+enum NvmeCmbszMask {
+    CMBSZ_SQS_MASK   = 0x1,
+    CMBSZ_CQS_MASK   = 0x1,
+    CMBSZ_LISTS_MASK = 0x1,
+    CMBSZ_RDS_MASK   = 0x1,
+    CMBSZ_WDS_MASK   = 0x1,
+    CMBSZ_SZU_MASK   = 0xf,
+    CMBSZ_SZ_MASK    = 0xfffff,
+};
+
+#define NVME_CMBSZ_SQS(cmbsz)  ((cmbsz >> CMBSZ_SQS_SHIFT)   & CMBSZ_SQS_MASK)
+#define NVME_CMBSZ_CQS(cmbsz)  ((cmbsz >> CMBSZ_CQS_SHIFT)   & CMBSZ_CQS_MASK)
+#define NVME_CMBSZ_LISTS(cmbsz)((cmbsz >> CMBSZ_LISTS_SHIFT) & CMBSZ_LISTS_MASK)
+#define NVME_CMBSZ_RDS(cmbsz)  ((cmbsz >> CMBSZ_RDS_SHIFT)   & CMBSZ_RDS_MASK)
+#define NVME_CMBSZ_WDS(cmbsz)  ((cmbsz >> CMBSZ_WDS_SHIFT)   & CMBSZ_WDS_MASK)
+#define NVME_CMBSZ_SZU(cmbsz)  ((cmbsz >> CMBSZ_SZU_SHIFT)   & CMBSZ_SZU_MASK)
+#define NVME_CMBSZ_SZ(cmbsz)   ((cmbsz >> CMBSZ_SZ_SHIFT)    & CMBSZ_SZ_MASK)
+
+#define NVME_CMBSZ_GETSIZE(cmbsz) (NVME_CMBSZ_SZ(cmbsz) * (1<<(12+4*NVME_CMBSZ_SZU(cmbsz))))
+
 typedef struct NvmeCmd {
     uint8_t     opcode;
     uint8_t     fuse;
@@ -772,7 +815,7 @@ typedef struct NvmeCtrl {
     uint8_t     cqes_pending;
     uint16_t    vid;
     uint16_t    did;
-    uint8_t     cmb;
+    uint16_t    cmb;
     uint8_t     *cmbuf;
 
     char            *serial;
-- 
1.7.10.4
