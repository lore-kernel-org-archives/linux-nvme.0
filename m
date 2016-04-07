From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 7 Apr 2016 06:11:31 -0700
Subject: [PATCH] Avoid reset work on watchdog timer function during error
 recovery
In-Reply-To: <1459974635-16178-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1459974635-16178-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-ID: <20160407131131.GA2063@infradead.org>

On Wed, Apr 06, 2016@05:30:35PM -0300, Guilherme G. Piccoli wrote:
>  	/*
>  	 * Skip controllers currently under reset.
> +	 * Also, skip controllers going through PCI error recovery.
>  	 */
>  	if (!work_pending(&dev->reset_work) && !work_busy(&dev->reset_work) &&
>  	    ((csts & NVME_CSTS_CFS) ||
> -	     (dev->subsystem && (csts & NVME_CSTS_NSSRO)))) {
> +	    (dev->subsystem && (csts & NVME_CSTS_NSSRO))) &&
> +	    !pci_channel_offline(to_pci_dev(dev->dev))) {
>  		if (queue_work(nvme_workq, &dev->reset_work)) {
>  			dev_warn(dev->dev,
>  				"Failed status: 0x%x, reset controller.\n",

This looks correct to me, but the condition is getting basically
unreadable.  Can you factor it out into a little helper returns a
boolean value if we should reset or not, and document each condition,
e.g. something like the function below, just with proper comments:

static bool nvme_should_reset(struct nvme_dev *dev)
{
	u32 csts = readl(dev->bar + NVME_REG_CSTS);

	if (!(csts & NVME_CSTS_CFS) &&
	    !((dev->subsystem && (csts & NVME_CSTS_NSSRO))))
		return false;

	if (work_pending(&dev->reset_work))
		return false;
	if (work_busy(&dev->reset_work))
		return false;
	if (pci_channel_offline(to_pci_dev(dev->dev))
		return false;

	return true;
}
