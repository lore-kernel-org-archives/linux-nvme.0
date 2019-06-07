From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sat, 8 Jun 2019 00:21:12 +0900
Subject: [PATCH v3 2/3] nvme: add thermal zone devices
In-Reply-To: <20190606040506.GA1913@localhost.localdomain>
References: <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
 <20190603023617.GA8567@localhost.localdomain>
 <CAC5umyj9V0sTD-ZsK6Q684wPdMpJGs434vDtZDm6a8gwoz3D7Q@mail.gmail.com>
 <20190606040506.GA1913@localhost.localdomain>
Message-ID: <CAC5umyhx-Ger4ZGcEu+mDNxgPPBCBEROhAEODAKqSv_p9QRw4g@mail.gmail.com>

2019?6?6?(?) 13:05 Eduardo Valentin <edubezval at gmail.com>:

> > > > +static struct thermal_zone_params nvme_tz_params = {
> > > > +     .governor_name = "user_space",
> > >
> > > Also,
> > >
> > > Was there any particular reason why defaulting to user_space here?
> >
> > I only tested with the user_space governor.  There is no cooling device
> > to bind with this.
> >
>
> hmmm.. I see. But was there any particular reason to pick the thermal
> subsystem here if you do not have any cooling? Or is there any specific
> cooling that can be written in future?
>
> If no cooling is expected, why not a simple hwmon?

For example, we can use USB port powered cooling fan with USB hub that
supports per-port power switching.  It can be turned on and off by user
space tool.

> > > > +     .no_hwmon = true,
> > > > +};
> > > > +
> > > > +static struct thermal_zone_device *
> > > > +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, unsigned int sensor)
> > > > +{
> > > > +     struct thermal_zone_device *tzdev;
> > > > +     char name[THERMAL_NAME_LENGTH];
> > > > +     int ret;
> > > > +
> > > > +     snprintf(name, sizeof(name), "nvme%d_temp%u", ctrl->instance, sensor);
> > > > +
> > > > +     tzdev = thermal_zone_device_register(name, 1, 1, ctrl, &nvme_tz_ops,
> > > > +                                          &nvme_tz_params, 0, 0);
> > > > +     if (IS_ERR(tzdev)) {
> > > > +             dev_err(ctrl->device,
> > > > +                     "Failed to register thermal zone device: %ld\n",
> > > > +                     PTR_ERR(tzdev));
> > > > +             return tzdev;
> > > > +     }
> > > > +
> > > > +     snprintf(name, sizeof(name), "temp%d", sensor);
> > > > +     ret = sysfs_create_link(&ctrl->ctrl_device.kobj, &tzdev->device.kobj,
> > > > +                             name);
> > > > +     if (ret)
> > > > +             goto device_unregister;
> > > > +
> > > > +     ret = sysfs_create_link(&tzdev->device.kobj,
> > > > +                             &ctrl->ctrl_device.kobj, "device");
> > > > +     if (ret)
> > > > +             goto remove_link;
> > > > +
> > > > +     return tzdev;
> > > > +
> > > > +remove_link:
> > > > +     sysfs_remove_link(&ctrl->ctrl_device.kobj, name);
> > > > +device_unregister:
> > > > +     thermal_zone_device_unregister(tzdev);
> > > > +
> > > > +     return ERR_PTR(ret);
> > > > +}
> > > > +
> > > > +/**
> > > > + * nvme_thermal_zones_register() - register nvme thermal zone devices
> > > > + * @ctrl: controller instance
> > > > + *
> > > > + * This function creates up to nine thermal zone devices for all implemented
> > > > + * temperature sensors including the composite temperature.
> > > > + * Each thermal zone device provides a single trip point temperature that is
> > > > + * associated with an over temperature threshold.
> > > > + */
> > > > +static int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > > > +{
> > > > +     struct nvme_smart_log *log;
> > > > +     int ret;
> > > > +     int i;
> > > > +
> > > > +     log = kzalloc(sizeof(*log), GFP_KERNEL);
> > > > +     if (!log)
> > > > +             return 0; /* non-fatal error */
> > >
> > > I am not sure about this API design here. I would leave the error
> > > handling and judging if this is fatal or not to the caller.
> > > I mean, if I ask to register a nvme thermal zone and I get
> > > a 0 as response, I would assume the thermal zone exists from
> > > now on, right?
> >
> > This routine is designed to return error code only when we're unable to
> > communicate with the device at all (i.e. nvme_submit_sync_cmd returns a
> > negative value).
> >
> > We don't want to abandon device initialization just due to thermal zone
> > failures.  Because thermal zone device isn't mandatory to manage the
> > controllers, and the device like qemu doesn't provide smart log (according
> > to Keith).
>
> That is fair.. it is just really weird to continue your business when
> the kernel cannot even allocate memory for you..

Right.  The system is not unlikely to continue working properly when under
page size allocation with GFP_KERNEL is failed, unless fault injection for
allocation is enabled.
