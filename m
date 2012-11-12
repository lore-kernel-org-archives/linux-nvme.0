From: Khosrow.Panah@idt.com (Panah, Khosrow)
Date: Mon, 12 Nov 2012 20:18:24 +0000
Subject: Linux-nvme Digest, Vol 8, Issue 2
Message-ID: <83DBBFBAD6CE2C4AA9C5DE7652017DE44BBEF013@corpmail1.na.ads.idt.com>

All,

To address comments received in regards to suggested changes to open source NVME driver to handle reset properly, I have revised the patch to "linux-nvme-a09115b". The patch below should address concerns for allowed timeout value and also disabling controller upon exit.

Khosrow

*** linux-nvme-a09115b/drivers/block/nvme.c     2012-08-07 12:56:23.000000000 -0700
--- nvme.c      2012-11-09 15:15:57.993081635 -0800
***************
*** 1016,1021 ****
--- 1016,1046 ----
        return ERR_PTR(result);
  }

+ static int nvme_disable(struct nvme_dev *dev) {
+       int result = 0;
+       u64 cap;
+       unsigned long timeout;
+
+       cap = readq(&dev->bar->cap);
+       timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
+
+       if (readl(&dev->bar->csts) & NVME_CSTS_RDY) {
+           writel(0, &dev->bar->cc);
+           while (!result && (readl(&dev->bar->csts) & NVME_CSTS_RDY)) {
+                   msleep(100);
+                   if (fatal_signal_pending(current))
+                       result = -EINTR;
+                   if (time_after(jiffies, timeout)) {
+                       dev_err(&dev->pci_dev->dev,
+                               "Device busy; aborting reset\n");
+                       result = -ENODEV;
+                   }
+           }
+       }
+       return result;
+ }
+
  static int __devinit nvme_configure_admin_queue(struct nvme_dev *dev)
  {
        int result = 0;
***************
*** 1038,1044 ****
        dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
        dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;

!       writel(0, &dev->bar->cc);
        writel(aqa, &dev->bar->aqa);
        writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
        writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
--- 1063,1074 ----
        dev->ctrl_config |= NVME_CC_ARB_RR | NVME_CC_SHN_NONE;
        dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;

!       result = nvme_disable(dev);
!       if (result) {
!               nvme_free_queue_mem(nvmeq);
!               return result;
!       }
!
        writel(aqa, &dev->bar->aqa);
        writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
        writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
***************
*** 1692,1697 ****
--- 1722,1728 ----

        nvme_free_queues(dev);
   unmap:
+       nvme_disable(dev);
        iounmap(dev->bar);
   disable_msix:
        pci_disable_msix(pdev);
***************
*** 1711,1716 ****
--- 1742,1748 ----
  {
        struct nvme_dev *dev = pci_get_drvdata(pdev);
        nvme_dev_remove(dev);
+       nvme_disable(dev);
        pci_disable_msix(pdev);
        iounmap(dev->bar);
        nvme_release_instance(dev);
***************
