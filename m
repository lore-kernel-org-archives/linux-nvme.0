From: alex.williamson@redhat.com (Alex Williamson)
Date: Tue, 24 Jul 2018 14:09:31 -0600
Subject: [PATCH v3 2/3] PCI: Samsung SM961/PM961 NVMe disable before FLR
 quirk
In-Reply-To: <1532461998.20066.5.camel@gmail.com>
References: <20180724160440.2729.75178.stgit@gimli.home>
 <20180724161440.2729.89835.stgit@gimli.home>
 <1532461998.20066.5.camel@gmail.com>
Message-ID: <20180724140931.040a2d97@t450s.home>

On Wed, 25 Jul 2018 04:53:18 +0900
Minwoo Im <minwoo.im.dev@gmail.com> wrote:

> Hi Alex,
> 
> On Tue, 2018-07-24@10:14 -0600, Alex Williamson wrote:
> > The Samsung SM961/PM961 (960 EVO) sometimes fails to return from FLR
> > with the PCI config space reading back as -1.??A reproducible instance
> > of this behavior is resolved by clearing the enable bit in the NVMe
> > configuration register and waiting for the ready status to clear
> > (disabling the NVMe controller) prior to FLR.
> > 
> > Signed-off-by: Alex Williamson <alex.williamson at redhat.com>
> > ---
> > ?drivers/pci/quirks.c |???83
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> > ?1 file changed, 83 insertions(+)
> > 
> > diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> > index e72c8742aafa..3899cdd2514b 100644
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -28,6 +28,7 @@
> > ?#include <linux/platform_data/x86/apple.h>
> > ?#include <linux/pm_runtime.h>
> > ?#include <linux/switchtec.h>
> > +#include <linux/nvme.h>
> > ?#include <asm/dma.h>	/* isa_dma_bridge_buggy */
> > ?#include "pci.h"
> > ?
> > @@ -3669,6 +3670,87 @@ static int reset_chelsio_generic_dev(struct pci_dev
> > *dev, int probe)
> > ?#define PCI_DEVICE_ID_INTEL_IVB_M_VGA??????0x0156
> > ?#define PCI_DEVICE_ID_INTEL_IVB_M2_VGA?????0x0166
> > ?
> > +/*
> > + * The Samsung SM961/PM961 controller can sometimes enter a fatal state after
> > + * FLR where config space reads from the device return -1.??We seem to be
> > + * able to avoid this condition if we disable the NVMe controller prior to
> > + * FLR.??This quirk is generic for any NVMe class device requiring similar
> > + * assistance to quiesce the device prior to FLR.
> > + *
> > + * NVMe specification: https://nvmexpress.org/resources/specifications/
> > + * Revision 1.0e:  
> 
> It seems too old version of NVMe specification. ?Do you have any special reason
> to comment the specified 1.0 version instead of 1.3 or something newer?

I wanted to show that I'm using NVMe features that have been available
since the initial release and there's no reason to check the version
field for their support.

> > + *????Chapter 2: Required and optional PCI config registers
> > + *????Chapter 3: NVMe control registers
> > + *????Chapter 7.3: Reset behavior
> > + */
> > +static int nvme_disable_and_flr(struct pci_dev *dev, int probe)  
> 
> The name of this function seems able to be started with 'reset_' prefix just
> like other quirks for reset.
> What about reset_samsung_pm961 or something?

I'm fine with any generic prefix, but I'm not fine with obfuscating the
purpose of the function behind a vendor/device specific name.  If
someone else comes along needing this same functionality, they'll
probably be reluctant to even look at what a "reset_samsung_sm961"
function does.  If they do, they might still be reluctant to reuse
something so obviously made for a specific device.  I thought this was
pretty descriptive of what it's doing.  Prefixing with 'reset_' is a
tad redundant.

> > +{
> > +	void __iomem *bar;
> > +	u16 cmd;
> > +	u32 cfg;
> > +
> > +	if (dev->class != PCI_CLASS_STORAGE_EXPRESS ||
> > +	????!pcie_has_flr(dev) || !pci_resource_start(dev, 0))
> > +		return -ENOTTY;
> > +
> > +	if (probe)
> > +		return 0;
> > +
> > +	bar = pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> > +	if (!bar)
> > +		return -ENOTTY;
> > +
> > +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> > +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
> > +
> > +	cfg = readl(bar + NVME_REG_CC);
> > +
> > +	/* Disable controller if enabled */
> > +	if (cfg & NVME_CC_ENABLE) {
> > +		u64 cap = readq(bar + NVME_REG_CAP);
> > +		unsigned long timeout;
> > +
> > +		/*
> > +		?* Per nvme_disable_ctrl() skip shutdown notification as it
> > +		?* could complete commands to the admin queue.??We only
> > intend
> > +		?* to quiesce the device before reset.
> > +		?*/
> > +		cfg &= ~(NVME_CC_SHN_MASK | NVME_CC_ENABLE);
> > +
> > +		writel(cfg, bar + NVME_REG_CC);
> > +
> > +		/*
> > +		?* Some controllers require an additional delay here, see
> > +		?* NVME_QUIRK_DELAY_BEFORE_CHK_RDY.??None of those are yet
> > +		?* supported by this quirk.
> > +		?*/
> > +
> > +		/* Cap register provides max timeout in 500ms increments */
> > +		timeout = ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
> > +
> > +		for (;;) {
> > +			u32 status = readl(bar + NVME_REG_CSTS);
> > +
> > +			/* Ready status becomes zero on disable complete */
> > +			if (!(status & NVME_CSTS_RDY))
> > +				break;
> > +
> > +			msleep(100);
> > +
> > +			if (time_after(jiffies, timeout)) {
> > +				pci_warn(dev, "Timeout waiting for NVMe ready
> > status to clear after disable\n");
> > +				break;
> > +			}
> > +		}
> > +	}
> > +
> > +	pci_iounmap(dev, bar);
> > +
> > +	pcie_flr(dev);
> > +
> > +	return 0;
> > +}
> > +
> > ?static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
> > ?	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
> > ?		?reset_intel_82599_sfp_virtfn },
> > @@ -3676,6 +3758,7 @@ static const struct pci_dev_reset_methods
> > pci_dev_reset_methods[] = {
> > ?		reset_ivb_igd },
> > ?	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
> > ?		reset_ivb_igd },
> > +	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },  
> 
> Why don't we just define a macro just like other DEVICE_IDs. (e.g.
> PCIE_DEVICE_ID_INTEL_82599_SFP_VF).
> 
> #define PCI_DEVICE_ID_SAMSUNG_PM961 ?0xa804

include/linux/pci_ids.h"
/*
 *      PCI Class, Vendor and Device IDs
 *
 *      Please keep sorted.
 *
 *      Do not add new entries to this file unless the definitions
 *      are shared between multiple drivers.
 */

Those other devices are relatively old, they were probably #define'd
before we started the policy in the header.  Thanks,

Alex

> > ?	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
> > ?		reset_chelsio_generic_dev },
> > ?	{ 0 }
> > 
> > 
> > _______________________________________________
> > Linux-nvme mailing list
> > Linux-nvme at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-nvme  
