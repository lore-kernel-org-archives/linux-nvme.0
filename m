From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Nov 2015 08:19:49 +0100
Subject: [PATCH 09/47] nvme: add a vendor field to struct nvme_dev
In-Reply-To: <1448090427-18749-1-git-send-email-hch@lst.de>
References: <1448090427-18749-1-git-send-email-hch@lst.de>
Message-ID: <1448090427-18749-10-git-send-email-hch@lst.de>

The SCSI translation layer currently has to poke into the PCI device
structure to find a vendor ID for the device identification fallback.
We won't nessecarily have a PCI device behind the device structure in
the future, so add a new vendor field that can be filled out by the
PCIe driver instead.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Acked-by: Keith Busch <keith.busch at intel.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/nvme.h | 1 +
 drivers/nvme/host/pci.c  | 3 +++
 drivers/nvme/host/scsi.c | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a53977c..02fca73 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -74,6 +74,7 @@ struct nvme_dev {
 	u16 abort_limit;
 	u8 event_limit;
 	u8 vwc;
+	u16 vendor;
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 094c355..79bca52 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3150,6 +3150,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_WORK(&dev->reset_work, nvme_reset_work);
 	dev->dev = get_device(&pdev->dev);
 	pci_set_drvdata(pdev, dev);
+
+	dev->vendor = pdev->vendor;
+
 	result = nvme_set_instance(dev);
 	if (result)
 		goto put_pci;
diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
index c3d8d38..8f2d2c5 100644
--- a/drivers/nvme/host/scsi.c
+++ b/drivers/nvme/host/scsi.c
@@ -657,7 +657,7 @@ static int nvme_trans_device_id_page(struct nvme_ns *ns, struct sg_io_hdr *hdr,
 		inq_response[6] = 0x00;    /* Rsvd */
 		inq_response[7] = 0x44;    /* Designator Length */
 
-		sprintf(&inq_response[8], "%04x", to_pci_dev(dev->dev)->vendor);
+		sprintf(&inq_response[8], "%04x", dev->vendor);
 		memcpy(&inq_response[12], dev->model, sizeof(dev->model));
 		sprintf(&inq_response[52], "%04x", tmp_id);
 		memcpy(&inq_response[56], dev->serial, sizeof(dev->serial));
-- 
1.9.1
