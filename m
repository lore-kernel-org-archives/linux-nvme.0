From: judy.brock@ssi.samsung.com (Judy Brock-SSI)
Date: Tue, 5 Apr 2016 22:04:22 +0000
Subject: [PATCH] NVMe: Re-introduce polling for completions
In-Reply-To: <20160405213904.GD12625@localhost.localdomain>
References: <1459808689-7689-1-git-send-email-keith.busch@intel.com>
 <20160405123523.GA19495@infradead.org>
 <20160405175437.GC12625@localhost.localdomain>
 <20160405213904.GD12625@localhost.localdomain>
Message-ID: <36E8D38D6B771A4BBDB1C0D800158A51865F402E@SSIEXCH-MB3.ssi.samsung.com>

Going straight to MSI-x is a higher risk change since re-introducing polling restores code that was in place previously with no reported problems whereas changing the init path to something new has no test time on it.

Restoring the polling (with comments as requested) is a harmless way to regain general ecosystem compatibility. 

Thanks,
Judy

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Tuesday, April 05, 2016 2:39 PM
To: Christoph Hellwig
Cc: Jens Axboe; linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: Re-introduce polling for completions

On Tue, Apr 05, 2016@05:54:37PM +0000, Keith Busch wrote:
> On Tue, Apr 05, 2016@05:35:23AM -0700, Christoph Hellwig wrote:
> > So how do any other PCIe device work given that almost no driver 
> > does unconditionaly polling?
> 
> I honestly don't have a good answer to that, and I agree with you that 
> this shouldn't be necessary ... but this is a harmless way to not 
> frustrate people who purchase these devices.
> 
> I suspect other PCI device drivers either at least try to never use 
> the legacy IRQ, or they've never been tested in platforms that break them.

Before I resend with the requested code comments, I'd like to hear your opinion on an alternate solution (patch below).

Currently the driver uses legacy IRQ if available only until we know how many queues it can create. The legacy IRQ use is tripping up some h/w, but I've not heard such issues with MSI/MSI-x.

Would you prefer going straight to MSI-x? The driver does that when there is no INTx, but we wouldn't need to poll from the watchdog timer if we make MSI-x the default behavior,

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index 9e03fe3..5954f40 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1518,7 +1518,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 * If we enable msix early due to not intx, disable it again before
 	 * setting up the full range we need.
 	 */
-	if (!pdev->irq)
+	if (pdev->msi_enabled)
+		pci_disable_msi(pdev);
+	else if (pdev->msix_enabled)
 		pci_disable_msix(pdev);
 
 	for (i = 0; i < nr_io_queues; i++)
@@ -1701,7 +1703,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	if (pci_enable_device_mem(pdev))
 		return result;
 
-	dev->entry[0].vector = pdev->irq;
 	pci_set_master(pdev);
 
 	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) && @@ -1714,13 +1715,18 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	}
 
 	/*
-	 * Some devices don't advertse INTx interrupts, pre-enable a single
-	 * MSIX vec for setup. We'll adjust this later.
+	 * Some devices and/or platforms don't advertise or work with INTx
+	 * interrupts. Pre-enable a single MSIX or MSI vec for setup. We'll
+	 * adjust this later.
 	 */
-	if (!pdev->irq) {
-		result = pci_enable_msix(pdev, dev->entry, 1);
-		if (result < 0)
-			goto disable;
+	if (pci_enable_msix(pdev, dev->entry, 1)) {
+		pci_enable_msi(pdev);
+		dev->entry[0].vector = pdev->irq;
+	}
+
+	if (!dev->entry[0].vector) {
+		result = -ENODEV;
+		goto disable;
 	}
 
 	cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
