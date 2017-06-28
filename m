From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Jun 2017 12:44:50 -0400
Subject: [PATCH] nvme: Quirks for PM1725 controllers
In-Reply-To: <f3690fd0-caa7-fb84-3a81-9a90c90f6db4@grimberg.me>
References: <20170628022757.32309-1-martin.petersen@oracle.com>
 <f3690fd0-caa7-fb84-3a81-9a90c90f6db4@grimberg.me>
Message-ID: <20170628164449.GA2650@localhost.localdomain>

On Wed, Jun 28, 2017@10:27:09AM +0300, Sagi Grimberg wrote:
> 
> > PM1725 controllers have a couple of quirks that need to be handled in
> > the driver:
> > 
> >   - I/O queue depth must be limited to 64 entries on controllers that do
> >     not report MQES.
> 
> I think this can be a new quirk (NVME_QUIRK_QD_LIMIT_64 or something)
> 
> > @@ -1908,6 +1908,12 @@ static int nvme_pci_enable(struct nvme_dev *dev)
> >   		dev_warn(dev->ctrl.device, "detected Apple NVMe controller, "
> >   			"set queue depth=%u to work around controller resets\n",
> >   			dev->q_depth);
> > +	} else if (pdev->vendor == PCI_VENDOR_ID_SAMSUNG &&
> > +		   (pdev->device == 0xa821 || pdev->device == 0xa822) &&
> > +		   NVME_CAP_MQES(cap) == 0) {
> 
> and the this is:
> 
> 	} else if (dev->ctrl.quirks & NVME_QUIRK_QD_LIMIT_64) {
> 
> While its inside the pci driver, I think it would be cleaner to
> use the quirks mechanism.
> 
> Kieth? thoughts?

Yeah, that's better than VID:DID checks. We only get 32 defined quirks
using driver_data, and while we currently can spare 2 of them for q-depth
quirks, I was hoping to use these bits more sparingly.
