From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 30 May 2019 19:18:56 +0900
Subject: [PATCH v3 2/3] nvme: add thermal zone devices
In-Reply-To: <CAC5umyhusw+sQOn5H7ZMP=aVi00GY7R_Jff6447R=yXyUpjFoQ@mail.gmail.com>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
 <20190529151517.GC28274@minwooim-desktop>
 <CAC5umyhusw+sQOn5H7ZMP=aVi00GY7R_Jff6447R=yXyUpjFoQ@mail.gmail.com>
Message-ID: <20190530101854.GA8843@minwooim-desktop>

On 19-05-30 01:47:08, Akinobu Mita wrote:
> 2019?5?30?(?) 0:15 Minwoo Im <minwoo.im.dev at gmail.com>:
> >
> > > +/**
> > > + * nvme_thermal_zones_register() - register nvme thermal zone devices
> > > + * @ctrl: controller instance
> > > + *
> > > + * This function creates up to nine thermal zone devices for all implemented
> > > + * temperature sensors including the composite temperature.
> > > + * Each thermal zone device provides a single trip point temperature that is
> > > + * associated with an over temperature threshold.
> > > + */
> > > +static int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > > +{
> > > +     struct nvme_smart_log *log;
> > > +     int ret;
> > > +     int i;
> > > +
> > > +     log = kzalloc(sizeof(*log), GFP_KERNEL);
> > > +     if (!log)
> > > +             return 0; /* non-fatal error */
> >
> > Do we need to print something like warning here? If kzalloc() fails, it
> > would be good to be distinguished between the nvme failure and internal
> > failure like this.
> 
> We usually remove the error message on kmalloc failure because it's
> redundant as long as we don't set __GFP_NOWARN.

I see what you point.

> 
> > > +
> > > +     ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > > +                        log, sizeof(*log), 0);
> > > +     if (ret) {
> > > +             dev_err(ctrl->device, "Failed to get SMART log: %d\n", ret);
> > > +             /* If the device provided a response, then it's non-fatal */
> > > +             if (ret > 0)
> > > +                     ret = 0;
> >
> > It seems like that nvme_init_identify() is just check the internal error
> > which is in negative value now as you have posted.  Why don't we just
> > return the value of "ret" itself without updating it to 0 ?
> 
> Both ways work for me.
> 
> I personally prefer not to return (leak) the nvme status code from
> foo_register() function.

Okay.  In the perspective of registration, the nvme status might not be
needed to be returned.  But I think if we return the nvme status here,
it would be great for the later time when we need to figure out if the nvme
command has failed or not.

But, amyway, I'm fine with this :)

Thanks for your comment on this trivial query.

> 
> > > +             goto free_log;
> > > +     }
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > > +             struct thermal_zone_device *tzdev;
> > > +             int temp;
> > > +
> > > +             if (i)
> > > +                     temp = le16_to_cpu(log->temp_sensor[i - 1]);
> > > +             else
> > > +                     temp = get_unaligned_le16(log->temperature);
> > > +
> > > +             /*
> > > +              * All implemented temperature sensors report a non-zero value
> > > +              * in temperature sensor fields in the smart log page.
> > > +              */
> > > +             if (!temp)
> > > +                     continue;
> > > +             if (ctrl->tzdev[i])
> > > +                     continue;
> > > +
> > > +             tzdev = nvme_thermal_zone_register(ctrl, i);
> > > +             if (!IS_ERR(tzdev))
> > > +                     ctrl->tzdev[i] = tzdev;
> > > +     }
> > > +
> > > +free_log:
> > > +     kfree(log);
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +/**
> > > + * nvme_thermal_zones_unregister() - unregister nvme thermal zone devices
> > > + * @ctrl: controller instance
> > > + *
> > > + * This function removes the registered thermal zone devices and symlinks.
> > > + */
> > > +static void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
> > > +{
> > > +     int i;
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > > +             struct thermal_zone_device *tzdev = ctrl->tzdev[i];
> > > +             char name[20];
> >
> > Simple query here :)
> >
> > If we are not going to allow the name of link exceed the length of its
> > own device name like nvmeX_tempY, then can we THERMAL_NAME_LENGTH macro
> > here?  If the name of link is not exactly about the device name itself,
> > then it's fine.  What do you think about it ?
> 
> Of course we can use THERMAL_NAME_LENGTH here.  But this char array is
> used only for the symbolic link name.
> It's not used for thermal cooling device type, thermal zone device type,
> or thermal governor name.  So I just used a random constant to avoid
> confusion.

Agreed.
