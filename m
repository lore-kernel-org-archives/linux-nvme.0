From: krisman@linux.vnet.ibm.com (Gabriel Krisman Bertazi)
Date: Wed, 19 Oct 2016 01:48:54 -0200
Subject: [PATCH RESEND] nvme: Add tertiary number to NVME_VS
Message-ID: <1476848934-25256-1-git-send-email-krisman@linux.vnet.ibm.com>

NVMe 1.2.1 specification adds a tertiary element to the version number.
This updates the macro and its callers to include the final number and
fixup a single place in nvmet where the version was generated manually.

Signed-off-by: Gabriel Krisman Bertazi <krisman at linux.vnet.ibm.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c   | 8 ++++----
 drivers/nvme/host/pci.c    | 4 ++--
 drivers/nvme/host/scsi.c   | 4 ++--
 drivers/nvme/target/core.c | 2 +-
 include/linux/nvme.h       | 3 ++-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 329381a28edf..09edc981e435 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -900,9 +900,9 @@ static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
 		return -ENODEV;
 	}
 
-	if (ns->ctrl->vs >= NVME_VS(1, 1))
+	if (ns->ctrl->vs >= NVME_VS(1, 1, 0))
 		memcpy(ns->eui, (*id)->eui64, sizeof(ns->eui));
-	if (ns->ctrl->vs >= NVME_VS(1, 2))
+	if (ns->ctrl->vs >= NVME_VS(1, 2, 0))
 		memcpy(ns->uuid, (*id)->nguid, sizeof(ns->uuid));
 
 	return 0;
@@ -1240,7 +1240,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 	page_shift = NVME_CAP_MPSMIN(cap) + 12;
 
-	if (ctrl->vs >= NVME_VS(1, 1))
+	if (ctrl->vs >= NVME_VS(1, 1, 0))
 		ctrl->subsystem = NVME_CAP_NSSRC(cap);
 
 	ret = nvme_identify_ctrl(ctrl, &id);
@@ -1840,7 +1840,7 @@ static void nvme_scan_work(struct work_struct *work)
 		return;
 
 	nn = le32_to_cpu(id->nn);
-	if (ctrl->vs >= NVME_VS(1, 1) &&
+	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
 	    !(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)) {
 		if (!nvme_scan_ns_list(ctrl, nn))
 			goto done;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0fc99f0f2571..3dce5eee67ca 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1214,7 +1214,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	u64 cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 	struct nvme_queue *nvmeq;
 
-	dev->subsystem = readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 1) ?
+	dev->subsystem = readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 1, 0) ?
 						NVME_CAP_NSSRC(cap) : 0;
 
 	if (dev->subsystem &&
@@ -1616,7 +1616,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 			dev->q_depth);
 	}
 
-	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2))
+	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2, 0))
 		dev->cmb = nvme_map_cmb(dev);
 
 	pci_enable_pcie_error_reporting(pdev);
diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index c2a0a1c7d05d..3eaa4d27801e 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -606,7 +606,7 @@ static int nvme_fill_device_id_eui64(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 	eui = id_ns->eui64;
 	len = sizeof(id_ns->eui64);
 
-	if (ns->ctrl->vs >= NVME_VS(1, 2)) {
+	if (ns->ctrl->vs >= NVME_VS(1, 2, 0)) {
 		if (bitmap_empty(eui, len * 8)) {
 			eui = id_ns->nguid;
 			len = sizeof(id_ns->nguid);
@@ -679,7 +679,7 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 {
 	int res;
 
-	if (ns->ctrl->vs >= NVME_VS(1, 1)) {
+	if (ns->ctrl->vs >= NVME_VS(1, 1, 0)) {
 		res = nvme_fill_device_id_eui64(ns, hdr, resp, alloc_len);
 		if (res != -EOPNOTSUPP)
 			return res;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 6559d5afa7bf..2af31cb3db69 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -882,7 +882,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	if (!subsys)
 		return NULL;
 
-	subsys->ver = (1 << 16) | (2 << 8) | 1; /* NVMe 1.2.1 */
+	subsys->ver = NVME_VS(1, 2, 1) /* NVMe 1.2.1 */
 
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
