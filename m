From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 20 Mar 2019 15:52:33 -0500
Subject: [PATCH v3] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
In-Reply-To: <20190222194808.15962-1-mr.nuke.me@gmail.com>
References: <20190222194808.15962-1-mr.nuke.me@gmail.com>
Message-ID: <20190320205233.GE251185@google.com>

[+cc Jon, Jens, Christoph, Sagi, Linus, linux-nvme from related discussion]
[+cc Greg, Oliver, who responded to v2 of this patch]

On Fri, Feb 22, 2019@01:48:06PM -0600, Alexandru Gagniuc wrote:
> A SURPRISE removal of a hotplug PCIe device, caused by a Link Down
> event will execute an orderly removal of the driver, which normally
> includes releasing the IRQs with pci_free_irq(_vectors):
> 
>  * SURPRISE removal event causes Link Down
>  * pciehp_disable_slot()
>  * pci_device_remove()
>  * driver->remove()
>  * pci_free_irq(_vectors)()
>  * irq_chip->irq_mask()
>  * pci_msi_mask_irq()
> 
> Eventually, msi_set_mask_bit() will attempt to do MMIO over the dead
> link, usually resulting in an Unsupported Request error. This can
> confuse the firmware on FFS machines, and lead to a system crash.
> 
> Since the channel will have been marked "pci_channel_io_perm_failure"
> by the hotplug thread, we know we should avoid sending blind IO to a
> dead link.
> When the device is disconnected, bail out of MSI teardown.
> 
> If device removal and Link Down are independent events, there exists a
> race condition when the Link Down event occurs right after the
> pci_dev_is_disconnected() check. This is outside the scope of this patch.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me at gmail.com>

I had actually applied this to pci/msi with the intent of merging it
for v5.1, but by coincidence I noticed [1], where Jon was basically
solving another piece of the same problem, this time in nvme-pci.

AFAICT, the consensus there was that it would be better to find some
sort of platform solution instead of dealing with it in individual
drivers.  The PCI core isn't really a driver, but I think the same
argument applies to it: if we had a better way to recover from readl()
errors, that way would work equally well in nvme-pci and the PCI core.

It sounds like the problem has two parts: the PCI core part and the
individual driver part.  Solving only the first (eg, with this patch)
isn't enough by itself, and solving the second via some platform
solution would also solve the first.  If that's the case, I don't
think it's worth applying this one, but please correct me if I'm
wrong.

Bjorn

[1] https://lore.kernel.org/lkml/20190222010502.2434-1-jonathan.derrick at intel.com/T/#u

> ---
> Changes since v2:
>  * Updated commit message
> 
>  drivers/pci/msi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 4c0b47867258..6b6541ab264f 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
>  {
>  	struct msi_desc *desc = irq_data_get_msi_desc(data);
>  
> +	if (pci_dev_is_disconnected(msi_desc_to_pci_dev(desc)))
> +		return;
> +
>  	if (desc->msi_attrib.is_msix) {
>  		msix_mask_irq(desc, flag);
>  		readl(desc->mask_base);		/* Flush write to device */
> -- 
> 2.19.2
> 
