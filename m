From: zwp10758@gmail.com (Weiping Zhang)
Date: Tue, 25 Jun 2019 23:06:36 +0800
Subject: [PATCH v3 5/5] nvme: add support weighted round robin queue
In-Reply-To: <20190624202110.GD6526@minwooim-desktop>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <6e3b0f511a291dd0ce570a6cc5393e10d4509d0e.1561385989.git.zhangweiping@didiglobal.com>
 <20190624202110.GD6526@minwooim-desktop>
Message-ID: <CAA70yB4Japiic4wAG=5ud8LrS2E-SaKxeV8yqG6j0pMCFTWjNQ@mail.gmail.com>

Minwoo Im <minwoo.im.dev at gmail.com> ?2019?6?25??? ??6:01???
>
> > @@ -2627,7 +2752,30 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
> >
> >  static void nvme_pci_get_ams(struct nvme_ctrl *ctrl, u32 *ams)
> >  {
> > -     *ams = NVME_CC_AMS_RR;
> > +     /* if deivce doesn't support WRR, force reset wrr queues to 0 */
> > +     if (!NVME_CAP_AMS_WRRU(ctrl->cap)) {
> > +             wrr_low_queues = 0;
> > +             wrr_medium_queues = 0;
> > +             wrr_high_queues = 0;
> > +             wrr_urgent_queues = 0;
>
> Could we avoid this kind of reset variables in get_XXX() function?  I
> guess it would be great if it just tries to get some value which is
> mainly focused to do.

I think its ok, when we use these variables in nvme_setup_irqs,
we can check ctrl->wrr_enabled, if it was false, skip all wrr_xxx_queues.
In other words, if ctrl->wrr_enabled is true, at least we have one wrr queue.

>
> > +
> > +             *ams = NVME_CC_AMS_RR;
> > +             ctrl->wrr_enabled = false;
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * if device support WRR, check wrr queue count, all wrr queues are
> > +      * 0, don't enable device's WRR.
> > +      */
> > +     if ((wrr_low_queues + wrr_medium_queues + wrr_high_queues +
> > +                             wrr_urgent_queues) > 0) {
> > +             *ams = NVME_CC_AMS_WRRU;
> > +             ctrl->wrr_enabled = true;
> > +     } else {
> > +             *ams = NVME_CC_AMS_RR;
> > +             ctrl->wrr_enabled = false;
>
> These two line can be merged into above condition:
It's ok, and merge comments for NVME_CC_AMS_RR.
>
>         if (!NVME_CAP_AMS_WRRU(ctrl->cap) ||
>                 wrr_low_queues + wrr_medium_queues + wrr_high_queues +
>                         wrr_urgent_queues <= 0) {
>                 *ams = NVME_CC_AMS_RR;
>                 ctrl->wrr_enabled = false;
>         }
