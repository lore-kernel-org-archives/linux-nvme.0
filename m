From: jeff.lien@wdc.com (jeffreyalien)
Date: Fri, 10 Nov 2017 15:12:03 -0600
Subject: [PATCH] NVMe: Add Quirk Delay Before CHK RDY for WDC SN200
Message-ID: <20171110211203.4782-1-jeff.lien@wdc.com>

Signed-off-by: jeffreyalien <jeff.lien at wdc.com>
---
 drivers/nvme/host/core.c | 2 ++
 drivers/nvme/host/nvme.h | 7 +++++++
 drivers/nvme/host/pci.c  | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37f9039bb9ca..f5bdf9c970e1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1435,6 +1435,8 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 
 	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
 		msleep(NVME_QUIRK_DELAY_AMOUNT);
+	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY_2)
+		msleep(NVME_QUIRK_DELAY_AMOUNT_2);
 
 	return nvme_wait_ready(ctrl, cap, false);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d3f3c4447515..3102124cb2a4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -80,6 +80,12 @@ enum nvme_quirks {
 	 * Supports the LighNVM command set if indicated in vs[1].
 	 */
 	NVME_QUIRK_LIGHTNVM			= (1 << 6),
+	/*
+	 * The controller needs a delay before starts checking the device
+	 * readiness, which is done by reading the NVME_CSTS_RDY bit.
+	 */
+	NVME_QUIRK_DELAY_BEFORE_CHK_RDY_2	= (1 << 7),
+
 };
 
 /*
@@ -109,6 +115,7 @@ static inline struct nvme_request *nvme_req(struct request *req)
  * found empirically.
  */
 #define NVME_QUIRK_DELAY_AMOUNT		2000
+#define NVME_QUIRK_DELAY_AMOUNT_2	2300
 
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3f5a04c586ce..826817f4c95e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2519,6 +2519,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
+	{ PCI_DEVICE(0x1c58, 0x0023),	/* WDC SN200 adapter */
+		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY_2, },
 	{ PCI_DEVICE(0x1c5f, 0x0540),	/* Memblaze Pblaze4 adapter */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x144d, 0xa821),   /* Samsung PM1725 */
-- 
2.14.2.746.g8fb8a94
