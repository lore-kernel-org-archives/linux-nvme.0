From: kbusch@kernel.org (Keith Busch)
Date: Thu, 23 May 2019 15:59:13 -0600
Subject: [RFC PATCH] nvme: Ignore timeouts while a PCIe reset is pending
In-Reply-To: <3f191e74-09ed-4356-d467-0ae222018e70@intel.com>
References: <20190522003741.26755-1-kenneth.heitke@intel.com>
 <20190522192656.GB5486@localhost.localdomain>
 <20190522200918.GC5486@localhost.localdomain>
 <3f191e74-09ed-4356-d467-0ae222018e70@intel.com>
Message-ID: <20190523215912.GB15192@localhost.localdomain>

On Thu, May 23, 2019@03:57:22PM -0600, Heitke, Kenneth wrote:
> On 5/22/2019 2:09 PM, Keith Busch wrote:
> > @@ -2782,12 +2783,13 @@ static void nvme_reset_prepare(struct pci_dev *pdev)
> >   {
> >   	struct nvme_dev *dev = pci_get_drvdata(pdev);
> >   	nvme_dev_disable(dev, false);
> > +	nvme_sync_queues(&dev->ctrl);
> >   }
> >   static void nvme_reset_done(struct pci_dev *pdev)
> >   {
> >   	struct nvme_dev *dev = pci_get_drvdata(pdev);
> > -	nvme_reset_ctrl_sync(&dev->ctrl);
> > +	nvme_reset_ctrl(&dev->ctrl);
> >   }
> >   static void nvme_shutdown(struct pci_dev *pdev)
> > --
> > 
> 
> For my specific case, is the sync_queues and reset_ctrl change needed as
> well?

I shouldn't have included the sync_queue part.

Definitely need the nvme_reset_ctrl change as blk_cfg_access is still
set here so need to reset asynchronously to unblock new timeouts.
