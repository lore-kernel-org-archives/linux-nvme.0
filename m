From: mpatocka@redhat.com (Mikulas Patocka)
Date: Tue, 1 May 2018 19:33:10 -0400 (EDT)
Subject: [PATCH] nvme/pci: Use async_schedule for initial reset work
In-Reply-To: <20180430194533.GC5938@localhost.localdomain>
References: <20180427211708.5604-1-keith.busch@intel.com>
 <CACVXFVNXmzMC9N+EabeXs4-XZLCRSOVdpd901wfojBL_s2YFRQ@mail.gmail.com>
 <20180430194533.GC5938@localhost.localdomain>
Message-ID: <alpine.LRH.2.02.1805011928470.17838@file01.intranet.prod.int.rdu2.redhat.com>



On Mon, 30 Apr 2018, Keith Busch wrote:

> On Sat, Apr 28, 2018@05:11:18PM +0800, Ming Lei wrote:
> > Looks fine,
> > 
> > Reviewed-by: Ming Lei <ming.lei at redhat.com>
> 
> Thanks, Ming.
> 
> Mikulas, would you be able to test this and confirm it works for you?
> This appears successful in my testing, but want to hear from the source
> if possible.
> 
> Thanks,
> Keith

The patch is not correct - scan_work is still called from a workqueue and 
if it's too slow, the nvme device is not found when mounting root.

You can add msleep(10000) at the beginning of nvme_scan_work to test for 
the race condition on your system.

Here I submit the corrected patch - I added 
flush_work(&dev->ctrl.scan_work) to nvme_async_probe

Mikulas



This patch schedules the initial controller reset in an async_domain so
that it can be synchronized from wait_for_device_probe(). This way the
kernel waits for the first nvme controller initialization to complete
for all devices before proceeding with the boot sequence, which may have
nvme dependencies.

Reported-by: Mikulas Patocka <mpatocka at redhat.com>
Tested-by: Mikulas Patocka <mpatocka at redhat.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

Index: linux-4.16.6/drivers/nvme/host/pci.c
===================================================================
--- linux-4.16.6.orig/drivers/nvme/host/pci.c	2018-05-02 01:18:01.000000000 +0200
+++ linux-4.16.6/drivers/nvme/host/pci.c	2018-05-02 01:18:01.000000000 +0200
@@ -13,6 +13,7 @@
  */
 
 #include <linux/aer.h>
+#include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-pci.h>
@@ -2471,6 +2472,13 @@ static unsigned long check_vendor_combin
 	return 0;
 }
 
+static void nvme_async_probe(void *data, async_cookie_t cookie)
+{
+	struct nvme_dev *dev = data;
+	nvme_reset_ctrl_sync(&dev->ctrl);
+	flush_work(&dev->ctrl.scan_work);
+}
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int node, result = -ENOMEM;
@@ -2515,7 +2523,7 @@ static int nvme_probe(struct pci_dev *pd
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
-	nvme_reset_ctrl(&dev->ctrl);
+	async_schedule(nvme_async_probe, dev);
 
 	return 0;
 
