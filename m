From: keith.busch@intel.com (Keith Busch)
Date: Fri, 29 Sep 2017 08:42:42 -0600
Subject: [PATCH] nvme-pci: Use PCI bus address for data/queues in CMB
In-Reply-To: <1506662966-10865-1-git-send-email-abhishek.shah@broadcom.com>
References: <1506662966-10865-1-git-send-email-abhishek.shah@broadcom.com>
Message-ID: <20170929144242.GN8463@localhost.localdomain>

On Fri, Sep 29, 2017@10:59:26AM +0530, Abhishek Shah wrote:
> Currently, NVMe PCI host driver is programming CMB dma address as
> I/O SQs addresses. This results in failures on systems where 1:1
> outbound mapping is not used (example Broadcom iProc SOCs) because
> CMB BAR will be progammed with PCI bus address but NVMe PCI EP will
> try to access CMB using dma address.
> 
> To have CMB working on systems without 1:1 outbound mapping, we
> program PCI bus address for I/O SQs instead of dma address. This
> approach will work on systems with/without 1:1 outbound mapping.
> 
> The patch is tested on Broadcom Stingray platform(arm64), which
> does not have 1:1 outbound mapping, as well as on x86 platform,
> which has 1:1 outbound mapping.
> 
> Fixes: 8ffaadf7 ("NVMe: Use CMB for the IO SQes if available")
> Cc: stable at vger.kernel.org
> Signed-off-by: Abhishek Shah <abhishek.shah at broadcom.com>
> Reviewed-by: Anup Patel <anup.patel at broadcom.com>
> Reviewed-by: Ray Jui <ray.jui at broadcom.com>
> Reviewed-by: Scott Branden <scott.branden at broadcom.com>

Thanks for the patch.

On a similar note, we also break CMB usage in virutalization with direct
assigned devices: the guest doesn't know the host physical bus address,
so it sets the CMB queue address incorrectly there, too. I don't know of
a way to fix that other than disabling CMB.


>  static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
>  {
> +	int rc;
>  	u64 szu, size, offset;
>  	resource_size_t bar_size;
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
> @@ -1553,6 +1574,13 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
>  
>  	dev->cmb_dma_addr = dma_addr;
>  	dev->cmb_size = size;
> +
> +	rc = nvme_find_cmb_bus_addr(pdev, dma_addr, size, &dev->cmb_bus_addr);
> +	if (rc) {
> +		iounmap(cmb);
> +		return NULL;
> +	}
> +
>  	return cmb;
>  }

Minor suggestion: it's a little simpler if you find the bus address
before ioremap:

---
@@ -1554,6 +1554,10 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
 		size = bar_size - offset;
 
 	dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(dev->cmbloc)) + offset;
+
+	if (nvme_find_cmb_bus_addr(pdev, dma_addr, size, &dev->cmb_bus_addr))
+		return NULL;
+
 	cmb = ioremap_wc(dma_addr, size);
 	if (!cmb)
 		return NULL;
--
