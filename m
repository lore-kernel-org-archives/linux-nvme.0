From: s.miroshnichenko@yadro.com (Sergey Miroshnichenko)
Date: Fri, 16 Aug 2019 19:50:59 +0300
Subject: [PATCH v5 21/23] nvme-pci: Handle movable BARs
In-Reply-To: <20190816165101.911-1-s.miroshnichenko@yadro.com>
References: <20190816165101.911-1-s.miroshnichenko@yadro.com>
Message-ID: <20190816165101.911-22-s.miroshnichenko@yadro.com>

Hotplugged devices can affect the existing ones by moving their BARs. The
PCI subsystem will inform the NVME driver about this by invoking the
.rescan_prepare() and .rescan_done() hooks, so the BARs can by re-mapped.

Tested under the "randrw" mode of the fio tool. Before the hotplugging:

  % sudo cat /proc/iomem
  ...
                3fe800000000-3fe8007fffff : PCI Bus 0020:0b
                  3fe800000000-3fe8007fffff : PCI Bus 0020:18
                    3fe800000000-3fe8000fffff : 0020:18:00.0
                      3fe800000000-3fe8000fffff : nvme
                    3fe800100000-3fe80017ffff : 0020:18:00.0
  ...

, then another NVME drive was hot-added, so BARs of the 0020:18:00.0 are
moved:

  % sudo cat /proc/iomem
    ...
                3fe800000000-3fe800ffffff : PCI Bus 0020:0b
                  3fe800000000-3fe8007fffff : PCI Bus 0020:10
                    3fe800000000-3fe800003fff : 0020:10:00.0
                      3fe800000000-3fe800003fff : nvme
                    3fe800010000-3fe80001ffff : 0020:10:00.0
                  3fe800800000-3fe800ffffff : PCI Bus 0020:18
                    3fe800800000-3fe8008fffff : 0020:18:00.0
                      3fe800800000-3fe8008fffff : nvme
                    3fe800900000-3fe80097ffff : 0020:18:00.0
    ...

During the rescanning, both READ and WRITE speeds drop to zero for a while
due to driver's pause, then restore.

Cc: linux-nvme at lists.infradead.org
Cc: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko at yadro.com>
---
 drivers/nvme/host/pci.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db160cee42ad..a805d80082ca 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1645,7 +1645,7 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	if (size <= dev->bar_mapped_size)
+	if (dev->bar && size <= dev->bar_mapped_size)
 		return 0;
 	if (size > pci_resource_len(pdev, 0))
 		return -ENOMEM;
@@ -2980,6 +2980,23 @@ static void nvme_error_resume(struct pci_dev *pdev)
 	flush_work(&dev->ctrl.reset_work);
 }
 
+static void nvme_rescan_prepare(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	nvme_dev_disable(dev, false);
+	nvme_dev_unmap(dev);
+	dev->bar = NULL;
+}
+
+static void nvme_rescan_done(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	nvme_dev_map(dev);
+	nvme_reset_ctrl_sync(&dev->ctrl);
+}
+
 static const struct pci_error_handlers nvme_err_handler = {
 	.error_detected	= nvme_error_detected,
 	.slot_reset	= nvme_slot_reset,
@@ -3049,6 +3066,8 @@ static struct pci_driver nvme_driver = {
 #endif
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
+	.rescan_prepare	= nvme_rescan_prepare,
+	.rescan_done	= nvme_rescan_done,
 };
 
 static int __init nvme_init(void)
-- 
2.21.0
