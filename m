From: keith.busch@intel.com (Keith Busch)
Date: Fri,  4 Mar 2016 13:15:17 -0700
Subject: [PATCHv2] NVMe: Create discard zero quirk white list
Message-ID: <1457122517-18658-1-git-send-email-keith.busch@intel.com>

The NVMe specification does not require discarded blocks return zeroes on
read, but provides that behavior as a possibility. Some applications more
efficiently use an SSD if reads on discarded blocks were deterministically
zero, based on the "discard_zeroes_data" queue attribute.

There is no specification defined way to determine device behavior on
discarded blocks, so the driver always left the queue setting disabled. We
can only know behavior based on individual device models, so this patch
adds a flag to the NVMe "quirk" list that vendors may set if they know
their controller works that way. The patch also sets the new flag for one
such known device.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Suggested-by: Artur Paszkiewicz <artur.paszkiewicz at intel.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
v1 -> v2:
  Fixed merge error creating duplicate flag value.

 drivers/nvme/host/core.c | 8 +++++++-
 drivers/nvme/host/nvme.h | 6 ++++++
 drivers/nvme/host/pci.c  | 3 ++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1100a6d..d07925d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -587,8 +587,14 @@ static void nvme_init_integrity(struct nvme_ns *ns)
 
 static void nvme_config_discard(struct nvme_ns *ns)
 {
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 logical_block_size = queue_logical_block_size(ns->queue);
-	ns->queue->limits.discard_zeroes_data = 0;
+
+	if (ctrl->quirks & NVME_QUIRK_DISCARD_ZEROES)
+		ns->queue->limits.discard_zeroes_data = 1;
+	else
+		ns->queue->limits.discard_zeroes_data = 0;
+
 	ns->queue->limits.discard_alignment = logical_block_size;
 	ns->queue->limits.discard_granularity = logical_block_size;
 	blk_queue_max_discard_sectors(ns->queue, 0xffffffff);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b760de1..f846da4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -59,6 +59,12 @@ enum nvme_quirks {
 	 * correctly.
 	 */
 	NVME_QUIRK_IDENTIFY_CNS			= (1 << 1),
+
+	/*
+	 * The controller deterministically returns O's on reads to discarded
+	 * logical blocks.
+	 */
+	NVME_QUIRK_DISCARD_ZEROES		= (1 << 2),
 };
 
 struct nvme_ctrl {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5869f20..86b4c78 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2164,7 +2164,8 @@ static const struct pci_error_handlers nvme_err_handler = {
 
 static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0953),
-		.driver_data = NVME_QUIRK_STRIPE_SIZE, },
+		.driver_data = NVME_QUIRK_STRIPE_SIZE |
+				NVME_QUIRK_DISCARD_ZEROES, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
-- 
2.7.2
