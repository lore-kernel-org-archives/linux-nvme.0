From: Khosrow.Panah@idt.com (Panah, Khosrow)
Date: Thu, 1 Nov 2012 18:36:42 +0000
Subject: Intel NVMe reset issue
Message-ID: <83DBBFBAD6CE2C4AA9C5DE7652017DE44BBEDADE@corpmail1.na.ads.idt.com>

All,

While testing Intel NVMe driver on Linux, I noticed there are instances controller fails to initialize IDT controller. The problem is related to Intel Linux driver does not wait for "Enable" bit to clear when attempting to setup admin queue.  I am suggesting the following changes to "nvme_configure_admin_queue" routine:

***************
*** 1039,1044 ****
--- 1058,1078 ----
        dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;

        writel(0, &dev->bar->cc);
+       timeout = (5 * HZ) + jiffies;
+       while (!result && (readl(&dev->bar->csts) & NVME_CSTS_RDY)) {
+               msleep(100);
+               if (fatal_signal_pending(current))
+                       result = -EINTR;
+               if (time_after(jiffies, timeout)) {
+                       dev_err(&dev->pci_dev->dev,
+                               "Device busy; aborting initialisation\n");
+                       result = -ENODEV;
+               }
+       }
+       if (result) {
+               nvme_free_queue_mem(nvmeq);
+               return result;
+       }
        writel(aqa, &dev->bar->aqa);
        writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
        writeq(nvmeq->cq_dma_addr, &dev->bar->acq);

Khosrow
