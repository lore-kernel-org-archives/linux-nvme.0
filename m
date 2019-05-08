From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Wed, 8 May 2019 19:38:50 +0000
Subject: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
In-Reply-To: <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain>
 <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
Message-ID: <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>

> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng at canonical.com>
> Sent: Wednesday, May 8, 2019 2:30 PM
> To: Keith Busch
> Cc: Keith Busch; axboe at fb.com; hch at lst.de; sagi at grimberg.me; linux-
> nvme at lists.infradead.org; linux-kernel at vger.kernel.org; Limonciello, Mario
> Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3 on
> Suspend-to-Idle
> 
> 
> [EXTERNAL EMAIL]
> 
>@03:16, Keith Busch <kbusch@kernel.org> wrote:
> 
> > On Thu, May 09, 2019@02:59:55AM +0800, Kai-Heng Feng wrote:
> >> +static int nvme_do_resume_from_idle(struct pci_dev *pdev)
> >> +{
> >> +	struct nvme_dev *ndev = pci_get_drvdata(pdev);
> >> +	int result;
> >> +
> >> +	pdev->dev_flags &= ~PCI_DEV_FLAGS_NO_D3;
> >> +	ndev->ctrl.suspend_to_idle = false;
> >> +
> >> +	result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> >> +	if (result < 0)
> >> +		goto out;
> >> +
> >> +	result = nvme_pci_configure_admin_queue(ndev);
> >> +	if (result)
> >> +		goto out;
> >> +
> >> +	result = nvme_alloc_admin_tags(ndev);
> >> +	if (result)
> >> +		goto out;
> >> +
> >> +	ndev->ctrl.max_hw_sectors = NVME_MAX_KB_SZ << 1;
> >> +	ndev->ctrl.max_segments = NVME_MAX_SEGS;
> >> +	mutex_unlock(&ndev->shutdown_lock);
> >
> > This lock was never locked.
> 
> Yea, will fix this.
> 
> >
> > But I think these special suspend/resume routines are too similar to the
> > existing ones, they should just incorporate this feature if we need to
> > do this.
> 
> That?s my original direction, but this requires a new bool to
> nvme_dev_disable(), so it becomes
> static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown, bool
> suspend_to_idle)
> 
> And it starts to get messy.
> 

The existing routines have an implied assumption that firmware will come swinging
with a hammer to control the rails the SSD sits on.
With S2I everything needs to come from the driver side and it really is a
different paradigm.
