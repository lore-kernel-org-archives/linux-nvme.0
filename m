From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Mar 2019 18:55:05 +0100
Subject: [PATCH 12/17] nvme: disable Write Zeroes for qemu controllers
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
Message-ID: <20190313175510.20725-13-hch@lst.de>

Qemu started out with a broken implementation of Write Zeroes written
by yours truly.  Disable Write Zeroes on qemu for now, eventually
we need to go back and make all the qemu quirks version specific,
but that is left for another time.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Keith Busch <keith.busch at intel.com>
Tested-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 5 +++++
 drivers/nvme/host/pci.c  | 3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b92fab434066..951e9f31b57c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1531,7 +1531,8 @@ static inline void nvme_config_write_zeroes(struct nvme_ns *ns)
 	u32 max_sectors;
 	unsigned short bs = 1 << ns->lba_shift;
 
-	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES))
+	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES) ||
+	    (ns->ctrl->quirks & NVME_QUIRK_DISABLE_WRITE_ZEROES))
 		return;
 	/*
 	 * Even though NVMe spec explicitly states that MDTS is not
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b91f1838bbd5..527d64545023 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -87,6 +87,11 @@ enum nvme_quirks {
 	 * Ignore device provided subnqn.
 	 */
 	NVME_QUIRK_IGNORE_DEV_SUBNQN		= (1 << 8),
+
+	/*
+	 * Broken Write Zeroes.
+	 */
+	NVME_QUIRK_DISABLE_WRITE_ZEROES		= (1 << 9),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f54718b63637..3a2377888a46 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2975,7 +2975,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0xf1a6),	/* Intel 760p/Pro 7600p */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
-		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
+		.driver_data = NVME_QUIRK_IDENTIFY_CNS |
+				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
-- 
2.20.1
