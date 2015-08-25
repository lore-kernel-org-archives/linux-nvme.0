From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Tue, 25 Aug 2015 19:25:00 +0000
Subject: [QEMU-NVME][CMB] Added CMBLOC and CMBSZ params to NVMe devices
Message-ID: <36F6EBABA23FEF4391AF72944D228901EB2F35D2@BBYEXM02.pmc-sierra.internal>

In order to allow for more rigorous testing of the CMB feature in NVMe
1.2 we allow for more flexible setting of the CMBLOC and CMBSZ
registers in NVMe drives. Refer to version 1.2 of the NVM Express
standard for more information on these registers.

Setting CMBSZ to something other than 0 (the default) will implement a
CMB as per the other settings in those registers. Note certain invalid
combinations exist and it is currently a case of buyer beware when you
choose to implement a CMB.

Signed-off-by: Stephen Bates <stephen.bates at pmcs.com>
---
 hw/block/nvme.c | 37 +++++++++++--------------------------
 hw/block/nvme.h |  3 ++-
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 2e4ac19..6bca347 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -56,7 +56,8 @@
  *  meta=<int>       : Meta-data size, Default:0
  *  oncs=<oncs>      : Optional NVMe command support, Default:DSM
  *  oacs=<oacs>      : Optional Admin command support, Default:Format
- *  cmb=<cmb>        : Controller Memory Buffer, size in MB, Default:0
+ *  cmbsz=<cmbsz>    : Controller Memory Buffer CMBSZ register, Default:0
+ *  cmbloc=<cmbloc>  : Controller Memory Buffer CMBLOC register, Default:0
  *
  * The logical block formats all start at 512 byte blocks and double for the
  * next index. If meta-data is non-zero, half the logical block formats will
@@ -131,7 +132,7 @@ static void nvme_process_sq(void *opaque);
 
 static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
-    if (n->cmb && addr >= n->ctrl_mem.addr &&
+    if (n->cmbsz && addr >= n->ctrl_mem.addr &&
                 addr < (n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size))) {
         memcpy(buf, (void *)&n->cmbuf[addr - n->ctrl_mem.addr], size);
     } else {
@@ -141,7 +142,7 @@ static void nvme_addr_read(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 
 static void nvme_addr_write(NvmeCtrl *n, hwaddr addr, void *buf, int size)
 {
-    if (n->cmb && addr >= n->ctrl_mem.addr &&
+    if (n->cmbsz && addr >= n->ctrl_mem.addr &&
                 addr < (n->ctrl_mem.addr + int128_get64(n->ctrl_mem.size))) {
         memcpy((void *)&n->cmbuf[addr - n->ctrl_mem.addr], buf, size);
         return;
@@ -1962,7 +1963,7 @@ static void nvme_init_ctrl(NvmeCtrl *n)
     NVME_CAP_SET_MPSMIN(n->bar.cap, n->mpsmin);
     NVME_CAP_SET_MPSMAX(n->bar.cap, n->mpsmax);
 
-    if (n->cmb)
+    if (n->cmbsz)
         n->bar.vs = 0x00010200;
     else
         n->bar.vs = 0x00010100;
@@ -1989,27 +1990,10 @@ static void nvme_init_pci(NvmeCtrl *n)
     msix_init_exclusive_bar(&n->parent_obj, n->num_queues, 4);
     msi_init(&n->parent_obj, 0x50, 32, true, false);
 
-    if (n->cmb) {
+    if (n->cmbsz) {
 
-        /* If CMB is requested it is setup here. Currently n->cmb
-         * determines size in MB. All other properties are hard-coded
-         * (for now) to:
-         * CMBSZ  = SQS=1, CQS=1, LISTS=1, RDS=0, WDS=0, SZU=1MB
-         * CMBLOC = BIR=2, OFST=0
-         */
-
-        n->bar.cmbloc = 0;
-        NVME_CMBLOC_SET_BIR(n->bar.cmbloc, 2);
-        NVME_CMBLOC_SET_OFST(n->bar.cmbloc, 0);
-
-        n->bar.cmbsz = 0;
-        NVME_CMBSZ_SET_SQS(n->bar.cmbsz,   1);
-        NVME_CMBSZ_SET_CQS(n->bar.cmbsz,   1);
-        NVME_CMBSZ_SET_LISTS(n->bar.cmbsz, 1);
-        NVME_CMBSZ_SET_RDS(n->bar.cmbsz,   0);
-        NVME_CMBSZ_SET_WDS(n->bar.cmbsz,   0);
-        NVME_CMBSZ_SET_SZU(n->bar.cmbsz,   2);
-        NVME_CMBSZ_SET_SZ(n->bar.cmbsz,    n->cmb);
+        n->bar.cmbloc = n->cmbloc;
+        n->bar.cmbsz  = n->cmbsz;
 
         n->cmbuf = g_malloc0(NVME_CMBSZ_GETSIZE(n->bar.cmbsz));
         memory_region_init_io(&n->ctrl_mem, OBJECT(n), &nvme_cmb_ops, n, "nvme-cmb",
@@ -2068,7 +2052,7 @@ static void nvme_exit(PCIDevice *pci_dev)
     g_free(n->sq);
     msix_uninit_exclusive_bar(pci_dev);
     memory_region_unref(&n->iomem);
-    if (n->cmb) {
+    if (n->cmbsz) {
         memory_region_unref(&n->ctrl_mem);
     }
 }
@@ -2100,7 +2084,8 @@ static Property nvme_props[] = {
     DEFINE_PROP_UINT8("dps", NvmeCtrl, dps, 0),
     DEFINE_PROP_UINT8("mc", NvmeCtrl, mc, 0),
     DEFINE_PROP_UINT8("meta", NvmeCtrl, meta, 0),
-    DEFINE_PROP_UINT16("cmb", NvmeCtrl, cmb, 0),
+    DEFINE_PROP_UINT32("cmbsz", NvmeCtrl, cmbsz, 0),
+    DEFINE_PROP_UINT32("cmbloc", NvmeCtrl, cmbloc, 0),
     DEFINE_PROP_UINT16("oacs", NvmeCtrl, oacs, NVME_OACS_FORMAT),
     DEFINE_PROP_UINT16("oncs", NvmeCtrl, oncs, NVME_ONCS_DSM),
     DEFINE_PROP_UINT16("vid", NvmeCtrl, vid, PCI_VENDOR_ID_INTEL),
diff --git a/hw/block/nvme.h b/hw/block/nvme.h
index 3c0fda9..8e0aff7 100644
--- a/hw/block/nvme.h
+++ b/hw/block/nvme.h
@@ -834,7 +834,8 @@ typedef struct NvmeCtrl {
     uint8_t     cqes_pending;
     uint16_t    vid;
     uint16_t    did;
-    uint16_t    cmb;
+    uint32_t    cmbsz;
+    uint32_t    cmbloc;
     uint8_t     *cmbuf;
 
     char            *serial;
-- 
2.1.4
