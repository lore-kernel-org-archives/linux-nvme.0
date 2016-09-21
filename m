From: krisman@linux.vnet.ibm.com (Gabriel Krisman Bertazi)
Date: Wed, 21 Sep 2016 17:05:52 -0300
Subject: [PATCH] nvme: Add tertiary number to NVME_VS
Message-ID: <1474488352-20601-1-git-send-email-krisman@linux.vnet.ibm.com>

NVMe 1.2.1 specification adds a tertiary element to the version number.
This updates the macro and its callers to include the final number and
fixup a single place in nvmet where the version was generated manually.

For versions prior to 1.2.1, which didn't have the tertiary number, it's
ok to assume the last number as zero, because that bit would be
reserved, and the specification defines reserved bits as 0.

Signed-off-by: Gabriel Krisman Bertazi <krisman at linux.vnet.ibm.com>
---
 drivers/nvme/host/core.c   | 8 ++++----
 drivers/nvme/host/pci.c    | 4 ++--
 drivers/nvme/host/scsi.c   | 4 ++--
 drivers/nvme/target/core.c | 2 +-
 include/linux/nvme.h       | 3 ++-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2feacc70bf61..139d4827f227 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -920,9 +920,9 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		ns->type = NVME_NS_LIGHTNVM;
 	}
 
-	if (ns->ctrl->vs >= NVME_VS(1, 1))
+	if (ns->ctrl->vs >= NVME_VS(1, 1, 0))
 		memcpy(ns->eui, id->eui64, sizeof(ns->eui));
-	if (ns->ctrl->vs >= NVME_VS(1, 2))
+	if (ns->ctrl->vs >= NVME_VS(1, 2, 0))
 		memcpy(ns->uuid, id->nguid, sizeof(ns->uuid));
 
 	old_ms = ns->ms;
@@ -1232,7 +1232,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 	page_shift = NVME_CAP_MPSMIN(cap) + 12;
 
-	if (ctrl->vs >= NVME_VS(1, 1))
+	if (ctrl->vs >= NVME_VS(1, 1, 0))
 		ctrl->subsystem = NVME_CAP_NSSRC(cap);
 
 	ret = nvme_identify_ctrl(ctrl, &id);
@@ -1815,7 +1815,7 @@ static void nvme_scan_work(struct work_struct *work)
 		return;
 
 	nn = le32_to_cpu(id->nn);
-	if (ctrl->vs >= NVME_VS(1, 1) &&
+	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
 	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
 		if (!nvme_scan_ns_list(ctrl, nn))
 			goto done;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 60f7eab11865..633cb05b9342 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1204,7 +1204,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	u64 cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 	struct nvme_queue *nvmeq;
 
-	dev->subsystem = readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 1) ?
+	dev->subsystem = readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 1, 0) ?
 						NVME_CAP_NSSRC(cap) : 0;
 
 	if (dev->subsystem &&
@@ -1642,7 +1642,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 			dev->q_depth);
 	}
 
-	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2))
+	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2, 0))
 		dev->cmb = nvme_map_cmb(dev);
 
 	pci_enable_pcie_error_reporting(pdev);
diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index e947e298a737..d11329742682 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -615,7 +615,7 @@ static int nvme_fill_device_id_eui64(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	eui = id_ns->eui64;
 	len = sizeof(id_ns->eui64);
 
-	if (ns->ctrl->vs >= NVME_VS(1, 2)) {
+	if (ns->ctrl->vs >= NVME_VS(1, 2, 0)) {
 		if (bitmap_empty(eui, len * 8)) {
 			eui = id_ns->nguid;
 			len = sizeof(id_ns->nguid);
@@ -688,7 +688,7 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 {
 	int res;
 
-	if (ns->ctrl->vs >= NVME_VS(1, 1)) {
+	if (ns->ctrl->vs >= NVME_VS(1, 1, 0)) {
 		res = nvme_fill_device_id_eui64(ns, hdr, resp, alloc_len);
 		if (res != -EOPNOTSUPP)
 			return res;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6559d5afa7bf..3b88a24bfabc 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -882,7 +882,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	if (!subsys)
 		return NULL;
 
-	subsys->ver = (1 << 16) | (2 << 8) | 1; /* NVMe 1.2.1 */
+	subsys->ver = NVME_VS(1, 2, 1);
 
 	switch (type) {
 	case NVME_NQN_NVME:
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7676557ce357..086d196e68f7 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -960,6 +960,7 @@ struct nvme_completion {
 	__le16	status;		/* did the command fail, and if so, why? */
 };
 
-#define NVME_VS(major, minor) (((major) << 16) | ((minor) << 8))
+#define NVME_VS(major, minor, tertiary) \
+	(((major) << 16) | ((minor) << 8) | (tertiary))
 
 #endif /* _LINUX_NVME_H */
-- 
2.7.4
