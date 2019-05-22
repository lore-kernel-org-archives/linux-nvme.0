From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 23 May 2019 00:52:14 +0900
Subject: [PATCH v2 2/4] nvme: add thermal zone infrastructure
In-Reply-To: <20190522154448.GA5393@localhost.localdomain>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
 <20190521161532.GD1639@localhost.localdomain>
 <CAC5umyi4t-r+0WbGjfa=_6ym_n=vcx5855nwL6NxuXH_HhYXkA@mail.gmail.com>
 <20190522154448.GA5393@localhost.localdomain>
Message-ID: <CAC5umyhhO61hjm4vO++YpL8JgcyT05VfDpTpLZx0fQywvd7_kA@mail.gmail.com>

2019?5?23?(?) 0:49 Keith Busch <kbusch at kernel.org>:
>
> On Thu, May 23, 2019@12:44:04AM +0900, Akinobu Mita wrote:
> > 2019?5?22?(?) 1:20 Keith Busch <kbusch at kernel.org>:
> > >
> > > On Wed, May 22, 2019@01:04:07AM +0900, Akinobu Mita wrote:
> > > > +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > > > +{
> > > > +     struct nvme_smart_log *log;
> > > > +     int ret;
> > > > +     int i;
> > > > +
> > > > +     log = kzalloc(sizeof(*log), GFP_KERNEL);
> > > > +     if (!log)
> > > > +             return 0; /* non-fatal error */
> > > > +
> > > > +     ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > > > +                        log, sizeof(*log), 0);
> > > > +     if (ret) {
> > > > +             dev_err(ctrl->device, "Failed to get SMART log: %d\n", ret);
> > > > +             ret = ret > 0 ? -EINVAL : ret;
> > >
> > > A ret > 0 means the device provided a response, so don't return a
> > > negative for that condition, please. That's just going to break
> > > controllers that don't provide smart data, like qemu.
> >
> > After looking at __nvme_submit_sync_cmd(), it returns -EINTR if the device
> > doesn't respond.  So, should this return a negative only when nvme_get_log()
> > returns -EINTR?
> >
> >         ret = nvme_get_log();
> >         if (ret) {
> >                 dev_err(...);
> >                 if (ret != -EINTR)
> >                         ret = 0;
> >                 goto free_log;
> >         }
>
> We return a different negative error if we can't allocate a request,
> like what happens if the controller is dead, like a surprise hot remove.
>
> There's a simpler way to look at this: if ret >= 0, we may proceed,
> otherwise we're done with this controller. Don't make it any more
> complicated than that.

OK.  Sounds good.
