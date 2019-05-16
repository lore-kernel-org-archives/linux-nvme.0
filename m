From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 16 May 2019 23:30:10 +0900
Subject: [PATCH 2/2] nvme-pci: support thermal zone
In-Reply-To: <20190515170320.GA21663@localhost.localdomain>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-3-git-send-email-akinobu.mita@gmail.com>
 <20190515170320.GA21663@localhost.localdomain>
Message-ID: <CAC5umyi97O+-4Dpspx-mouSReJBxqDXvigxw-SzDSa4BeEM9Ng@mail.gmail.com>

2019?5?16?(?) 2:08 Keith Busch <kbusch at kernel.org>:
>
> On Thu, May 16, 2019@12:17:17AM +0900, Akinobu Mita wrote:
> > This enables to use thermal zone interfaces for NVMe
> > temperature sensors.
> >
> > Cc: Zhang Rui <rui.zhang at intel.com>
> > Cc: Eduardo Valentin <edubezval at gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano at linaro.org>
> > Cc: Keith Busch <keith.busch at intel.com>
> > Cc: Jens Axboe <axboe at fb.com>
> > Cc: Christoph Hellwig <hch at lst.de>
> > Cc: Sagi Grimberg <sagi at grimberg.me>
> > Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> > ---
> >  drivers/nvme/host/pci.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index fad5395..88a25dc 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2470,6 +2470,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
> >       if (dev->ctrl.admin_q)
> >               blk_put_queue(dev->ctrl.admin_q);
> >       kfree(dev->queues);
> > +     nvme_thermal_zones_unregister(&dev->ctrl);
>
> This unregister should probably go in the nvme_remove() rather than in
> the last reference release.

You are right.  It is too late to unregister and it caused a lot of
sysfs_remove_link() failures when removing driver.
