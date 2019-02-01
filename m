From: indou.takao@jp.fujitsu.com (Takao Indoh)
Date: Fri, 1 Feb 2019 21:46:15 +0900
Subject: [PATCH] nvme: Enable acceleration feature of A64FX processor
Message-ID: <20190201124615.16107-1-indou.takao@jp.fujitsu.com>

From: Takao Indoh <indou.takao@fujitsu.com>

Fujitsu A64FX processor has a feature to accelerate data transfer of
internal bus by relaxed ordering. It is enabled when the bit 56 of dma
address is set to 1.

This patch introduces this acceleration feature to the NVMe driver to
enhance NVMe device performance.

Signed-off-by: Takao Indoh <indou.takao at fujitsu.com>
---
 drivers/nvme/host/core.c |  6 ++++
 drivers/nvme/host/nvme.h |  7 +++++
 drivers/nvme/host/pci.c  | 65 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 150e49723c15..8167c3756b05 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -37,6 +37,9 @@
 
 #define NVME_MINORS		(1U << MINORBITS)
 
+DEFINE_STATIC_KEY_FALSE(nvme_quirk_a64fx_force_relax_key);
+EXPORT_SYMBOL_GPL(nvme_quirk_a64fx_force_relax_key);
+
 unsigned int admin_timeout = 60;
 module_param(admin_timeout, uint, 0644);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
@@ -2493,6 +2496,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		ctrl->quirks &= ~NVME_QUIRK_NO_DEEPEST_PS;
 	}
 
+	if (ctrl->quirks & NVME_QUIRK_A64FX_FORCE_RELAX)
+		static_branch_enable(&nvme_quirk_a64fx_force_relax_key);
+
 	ctrl->crdt[0] = le16_to_cpu(id->crdt1);
 	ctrl->crdt[1] = le16_to_cpu(id->crdt2);
 	ctrl->crdt[2] = le16_to_cpu(id->crdt3);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ab961bdeea89..fe02d021ee9c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -23,6 +23,7 @@
 #include <linux/sed-opal.h>
 #include <linux/fault-inject.h>
 #include <linux/rcupdate.h>
+#include <linux/jump_label.h>
 
 extern unsigned int nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
@@ -37,6 +38,8 @@ extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
 
+DECLARE_STATIC_KEY_FALSE(nvme_quirk_a64fx_force_relax_key);
+
 enum {
 	NVME_NS_LBA		= 0,
 	NVME_NS_LIGHTNVM	= 1,
@@ -95,6 +98,10 @@ enum nvme_quirks {
 	 * Ignore device provided subnqn.
 	 */
 	NVME_QUIRK_IGNORE_DEV_SUBNQN		= (1 << 8),
+	/*
+	 * Force relaxed ordering for A64FX controller
+	 */
+	NVME_QUIRK_A64FX_FORCE_RELAX		= (1 << 9),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9bc585415d9b..cffe390d4c41 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -835,6 +835,45 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 	return BLK_STS_OK;
 }
 
+static inline void nvme_pci_enable_a64fx_relax_bit(struct nvme_sgl_desc *sge)
+{
+	sge->addr |= (1ULL << 56);
+}
+
+/*
+ * A64FX's controller allow relaxed order by setting 1 on bit 56 of dma address
+ * for performance enhancement.
+ *
+ * This traverses the sgl list and set the bit on ever dma address for
+ * data read.
+ */
+static void nvme_pci_quirk_a64fx_force_relax(struct request *req,
+		struct nvme_rw_command *cmd, int entries)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct nvme_sgl_desc *sg_list;
+	int i, j;
+
+	/* do nothing if sgl is not used or command is not read */
+	if (!iod->use_sgl || cmd->opcode != nvme_cmd_read)
+		return;
+
+	if (entries == 1) {
+		nvme_pci_enable_a64fx_relax_bit(&cmd->dptr.sgl);
+		return;
+	}
+
+	i = 0; j = 0;
+	sg_list = nvme_pci_iod_list(req)[j];
+	do {
+		if (i == SGES_PER_PAGE) {
+			i = 0;
+			sg_list = nvme_pci_iod_list(req)[++j];
+		}
+		nvme_pci_enable_a64fx_relax_bit(&sg_list[i++]);
+	} while (--entries > 0);
+}
+
 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -869,6 +908,9 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	if (ret != BLK_STS_OK)
 		goto out_unmap;
 
+	if (static_branch_unlikely(&nvme_quirk_a64fx_force_relax_key))
+		nvme_pci_quirk_a64fx_force_relax(req, &cmnd->rw, nr_mapped);
+
 	ret = BLK_STS_IOERR;
 	if (blk_integrity_rq(req)) {
 		if (blk_rq_count_integrity_sg(q, req->bio) != 1)
@@ -2748,6 +2790,27 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
+/*
+ * PCI vendor id of Fujitsu and device id for root port in the A64FX processor
+ */
+#define PCI_VENDOR_ID_FUJITSU			0x10cf
+#define PCI_DEVICE_ID_FUJITSU_A64FX_ROOTPORT	0x1952
+
+static unsigned long check_system_vendor_acceleration(void)
+{
+	struct pci_dev *pdev_root;
+	/*
+	 * When Fujitsu A64FX Root Port is found, acceleration feature
+	 * can be enabled.
+	 */
+	pdev_root = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
+	if (pdev_root && (pdev_root->vendor == PCI_VENDOR_ID_FUJITSU) &&
+	    (pdev_root->device == PCI_DEVICE_ID_FUJITSU_A64FX_ROOTPORT))
+		return NVME_QUIRK_A64FX_FORCE_RELAX;
+
+	return 0;
+}
+
 static void nvme_async_probe(void *data, async_cookie_t cookie)
 {
 	struct nvme_dev *dev = data;
@@ -2794,6 +2857,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
+	quirks |= check_system_vendor_acceleration();
+
 	/*
 	 * Double check that our mempool alloc size will cover the biggest
 	 * command we support.
-- 
2.20.1
