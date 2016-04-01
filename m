From: jonathan.derrick@intel.com (Derrick, Jonathan)
Date: Fri, 1 Apr 2016 16:02:12 +0000
Subject: nvme device timeout
In-Reply-To: <20160329143818.GC27195@localhost.localdomain>
References: <1604554248.106551459228253752.JavaMail.weblogic@epmlwas03c>
 <20160329143818.GC27195@localhost.localdomain>
Message-ID: <8D943B239464E04C9184454D8B3F5CFF0ACD84F3@ORSMSX101.amr.corp.intel.com>

Hi Keith, all,

One of our testers verified that this fixed a similar issue with their platform.

Needs a proper patch+log, but otherwise,
Acked-by: Jon Derrick <jonathan.derrick at intel.com>


-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Tuesday, March 29, 2016 8:38 AM
To: Amit Kumar Pandey <amit.kp at samsung.com>
Cc: Tim Mohlmann <muhlemmer at gmail.com>; linux-nvme at lists.infradead.org
Subject: Re: nvme device timeout


On Tue, Mar 29, 2016@05:10:53AM +0000, Amit Kumar Pandey wrote:
> I fear that test patch may not work for Tim's reported issue. Since nvme_ktherad will not process any CQ until reset_work is completed, it may not be able to complete identify cmd and will result into failure. 
> 
> static int nvme_kthread(void *data)
> /*
> * Skip controllers currently under reset.
> */
>  if (work_pending(&dev->reset_work) || work_busy(&dev->reset_work))
>   continue;

Thanks, good catch!

Have you confirmed that this controller is indeed relying on polling completions during early init, or do you want to try a fix for kthread polling? The test patch is appeneded below if you still need to confirm it.

If the controller really doesn't work with legacy interrupts, would it be possible to permanently set the PCI interrupt pin register to 0? You shouldn't advertise the capability if it doesn't work, and the driver would have used MSI-x if that was the case.

If we absolutely need to add a quirk, either polling or force using MSI-x sound like possible solutions.

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index 680f578..05eb152 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1371,12 +1371,6 @@ static int nvme_kthread(void *data)
 			int i;
 			u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-			/*
-			 * Skip controllers currently under reset.
-			 */
-			if (work_pending(&dev->reset_work) || work_busy(&dev->reset_work))
-				continue;
-
 			if ((dev->subsystem && (csts & NVME_CSTS_NSSRO)) ||
 							csts & NVME_CSTS_CFS) {
 				if (queue_work(nvme_workq, &dev->reset_work)) { @@ -1945,17 +1939,16 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
-	result = nvme_init_identify(&dev->ctrl);
+	dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
+	result = nvme_dev_list_add(dev);
 	if (result)
 		goto out;
 
-	result = nvme_setup_io_queues(dev);
+	result = nvme_init_identify(&dev->ctrl);
 	if (result)
 		goto out;
 
-	dev->ctrl.event_limit = NVME_NR_AEN_COMMANDS;
-
-	result = nvme_dev_list_add(dev);
+	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out;
 
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
