From: kbusch@kernel.org (Keith Busch)
Date: Tue, 23 Jul 2019 16:31:45 -0600
Subject: [PATCH] nvme-pci: fix probe and remove race
In-Reply-To: <6e5af7f5-be2a-6cf8-81fc-84ed831cbacd@grimberg.me>
References: <20190719194256.23618-1-sagi@grimberg.me>
 <20190723204643.GC4002@localhost.localdomain>
 <6e5af7f5-be2a-6cf8-81fc-84ed831cbacd@grimberg.me>
Message-ID: <20190723223144.GE4002@localhost.localdomain>

On Tue, Jul 23, 2019@03:21:49PM -0700, Sagi Grimberg wrote:
> 
> > I still think we'd prefer not adding that async domain dependency and
> > relying on timeout to unstuck a hot-removal. So how about we schedule
> > the reset work in probe and have the async part just flush the reset
> > and scan work?
> > 
> > ---
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index db160cee42ad..0c2c4b0c6655 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2695,7 +2695,7 @@ static void nvme_async_probe(void *data, async_cookie_t cookie)
> >   {
> >   	struct nvme_dev *dev = data;
> > -	nvme_reset_ctrl_sync(&dev->ctrl);
> > +	flush_work(&dev->ctrl.reset_work);
> >   	flush_work(&dev->ctrl.scan_work);
> >   	nvme_put_ctrl(&dev->ctrl);
> >   }
> > @@ -2761,6 +2761,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >   	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
> > +	nvme_reset_ctrl(&dev->ctrl);
> >   	nvme_get_ctrl(&dev->ctrl);
> 
> I think you need to get the ref first and then fire the work right?

That ref order doesn't actually matter here. We can't call nvme_remove
during the synchronous part of probe, and the extra ref is just for the
async_schedule callback.
