From: jeff.lien@wdc.com (jeffreyalien)
Date: Fri, 10 Nov 2017 16:04:59 -0600
Subject: [PATCH] NVMe: Add Quirk Delay Before CHK RDY for WDC SN200
Message-ID: <20171110220459.5554-1-jeff.lien@wdc.com>

Signed-off-by: jeffreyalien <jeff.lien at wdc.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 drivers/nvme/host/pci.c  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d3f3c4447515..044af553204c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -108,7 +108,7 @@ static inline struct nvme_request *nvme_req(struct request *req)
  * NVME_QUIRK_DELAY_BEFORE_CHK_RDY quirk enabled. The value (in ms) was
  * found empirically.
  */
-#define NVME_QUIRK_DELAY_AMOUNT		2000
+#define NVME_QUIRK_DELAY_AMOUNT		2300
 
 enum nvme_ctrl_state {
 	NVME_CTRL_NEW,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3f5a04c586ce..75539f7c58b9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2519,6 +2519,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
+	{ PCI_DEVICE(0x1c58, 0x0023),	/* WDC SN200 adapter */
+		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c5f, 0x0540),	/* Memblaze Pblaze4 adapter */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x144d, 0xa821),   /* Samsung PM1725 */
-- 
2.14.2.746.g8fb8a94
