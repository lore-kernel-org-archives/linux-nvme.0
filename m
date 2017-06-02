From: rakesh@tuxera.com (Rakesh Pandit)
Date: Fri, 2 Jun 2017 20:28:38 +0300
Subject: [PATCH] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <024d059e-cd79-78cb-f367-0630d8387ce2@grimberg.me>
References: <20170601140629.15313-1-hch@lst.de>
 <20170601140629.15313-2-hch@lst.de>
 <3db3cb8f-0851-f114-2fc6-4710d5aab2db@grimberg.me>
 <20170601154107.GA8118@lst.de>
 <024d059e-cd79-78cb-f367-0630d8387ce2@grimberg.me>
Message-ID: <20170602172838.GB22858@dhcp-216.srv.tuxera.com>

On Fri, Jun 02, 2017@01:02:09AM +0300, Sagi Grimberg wrote:
> 
> > > Did you catch my proposal to Keith and Rakesh?
> > 
> > I saw it.
> > 
> > > 
> > > I proposed to synchronize with ctrl state NVME_CTRL_RESETTING
> > > before scheduling the reset_work and on removal flow (which is
> > > why the warning exist) simply do a sync cancel of reset_work.
> > > 
> > > IMO, this is better than adding a new state to the ctrl state machine.
> > 
> > Why?  Knowing from the state machine that we're going to reset
> > is very useful and will safe us from doing pointless work elsewhere.
> > There is a reason we have done it that way in Fabrics from the beginning.
> 
> I'm not following, we have not done it for fabrics, we are doing in
> fabrics exactly what I'm proposing.
> 
> > E.g. as the work_busy check in nvme_should_reset can now be replaced
> > with a check for NVME_CTRL_SCHED_RESET and NVME_CTRL_RESETTING and
> > we're much more reliable.
> 
> I agree on the state check, I think it should check NVME_CTRL_RESETTING
> and use that state when we schedule reset_work (like we do in fabrics)
> and drop the redundant WARN_ON in reset_work to protect against the
> special case of controller concurrent deletion (which we remove
> altogether by canceling the reset_work there).
> 
> I think we're in sync about the mechanics, I just understand why we need
> another state here.
> 
> Can something like the (untested) following work?

Logically it should work.

> --
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 2769298e16dc..ca92fa24c6fc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1384,7 +1384,7 @@ static bool nvme_should_reset(struct nvme_dev *dev,
> u32 csts)
>         bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
> 
>         /* If there is a reset ongoing, we shouldn't reset again. */
> -       if (work_busy(&dev->reset_work))
> +       if (dev->ctrl.state == NVME_CTRL_RESETTING)
>                 return false;
> 
>         /* We shouldn't reset unless the controller is on fatal error state
> @@ -2026,8 +2026,8 @@ static int nvme_reset(struct nvme_dev *dev)
>  {
>         if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
>                 return -ENODEV;
> -       if (work_busy(&dev->reset_work))
> -               return -ENODEV;
> +       if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
> +               return -EBUSY;
>         if (!queue_work(nvme_wq, &dev->reset_work))
>                 return -EBUSY;
>         return 0;
> @@ -2194,6 +2194,7 @@ static void nvme_remove(struct pci_dev *pdev)
>  {
>         struct nvme_dev *dev = pci_get_drvdata(pdev);
> 
> +       cancel_work_sync(&dev->reset_work);
>         nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
> 
>         pci_set_drvdata(pdev, NULL);
> --

cancel_work_sync seems to be a good idea but I would still consider
new state to be a better alternative as it seems to make overal design
simpler.

Before using the new state earlier versions of my patch did consider
using RESETTING state for synchronization but we gave up the idea.

Anyway, once we can decide which way to go, I would be happy to give
this a test spin.  You just forgot to remove the now reduntant WARN_ON
in untested one but of course this was just untested and for
demonstration only.

Thanks.
