From: edubezval@gmail.com (Eduardo Valentin)
Date: Wed, 5 Jun 2019 21:05:07 -0700
Subject: [PATCH v3 2/3] nvme: add thermal zone devices
In-Reply-To: <CAC5umyj9V0sTD-ZsK6Q684wPdMpJGs434vDtZDm6a8gwoz3D7Q@mail.gmail.com>
References: <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
 <20190603023617.GA8567@localhost.localdomain>
 <CAC5umyj9V0sTD-ZsK6Q684wPdMpJGs434vDtZDm6a8gwoz3D7Q@mail.gmail.com>
Message-ID: <20190606040506.GA1913@localhost.localdomain>

On Tue, Jun 04, 2019@12:20:19AM +0900, Akinobu Mita wrote:
> 2019?6?3?(?) 11:36 Eduardo Valentin <edubezval at gmail.com>:
> >
> > Hey Mita,
> >
> > On Mon, May 27, 2019@01:29:02AM +0900, Akinobu Mita wrote:
> > > The NVMe controller reports up to nine temperature values in the SMART /
> > > Health log page (the composite temperature and temperature sensor 1 through
> > > temperature sensor 8).
> > >
> > > This provides these temperatures via thermal zone devices.
> > >
> > > Once the controller is identified, the thermal zone devices are created for
> > > all implemented temperature sensors including the composite temperature.
> > >
> > > /sys/class/thermal/thermal_zone[0-*]:
> > >     |---type: 'nvme<instance>-temp<sensor>'
> > >     |---temp: Temperature
> > >     |---trip_point_0_temp: Over temperature threshold
> > >
> > > The thermal_zone[0-*] contains a 'device' symlink to the corresponding nvme
> > > device.
> > >
> > > On the other hand, the following symlinks to the thermal zone devices are
> > > created in the nvme device sysfs directory.
> > >
> > > - temp0: Composite temperature
> > > - temp1: Temperature sensor 1
> > > ...
> > > - temp8: Temperature sensor 8
> > >
> >
> > These questions on V2 are still unanswered:
> > a. Can we get a more descriptive string into tz->type?
> 
> As I said in the other thread, the NVMe spec only says a controller
> reports the composite temperature and temperature sensor 1 through 8.
> What temperature sensor N means is vendor specific.

I see..

> 
> > b. Can these APIs support DT probing too?
> 
> OK. I can try, but I don't have arm or arm64 boards with PCIe for
> testing with of-thermal.  So it'll be untested.
> 

OK.  Lets see what comes.

> > > +static struct thermal_zone_params nvme_tz_params = {
> > > +     .governor_name = "user_space",
> >
> > Also,
> >
> > Was there any particular reason why defaulting to user_space here?
> 
> I only tested with the user_space governor.  There is no cooling device
> to bind with this.
> 

hmmm.. I see. But was there any particular reason to pick the thermal
subsystem here if you do not have any cooling? Or is there any specific
cooling that can be written in future?

If no cooling is expected, why not a simple hwmon?

> > > +     .no_hwmon = true,
> > > +};
> > > +
> > > +static struct thermal_zone_device *
> > > +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, unsigned int sensor)
> > > +{
> > > +     struct thermal_zone_device *tzdev;
> > > +     char name[THERMAL_NAME_LENGTH];
> > > +     int ret;
> > > +
> > > +     snprintf(name, sizeof(name), "nvme%d_temp%u", ctrl->instance, sensor);
> > > +
> > > +     tzdev = thermal_zone_device_register(name, 1, 1, ctrl, &nvme_tz_ops,
> > > +                                          &nvme_tz_params, 0, 0);
> > > +     if (IS_ERR(tzdev)) {
> > > +             dev_err(ctrl->device,
> > > +                     "Failed to register thermal zone device: %ld\n",
> > > +                     PTR_ERR(tzdev));
> > > +             return tzdev;
> > > +     }
> > > +
> > > +     snprintf(name, sizeof(name), "temp%d", sensor);
> > > +     ret = sysfs_create_link(&ctrl->ctrl_device.kobj, &tzdev->device.kobj,
> > > +                             name);
> > > +     if (ret)
> > > +             goto device_unregister;
> > > +
> > > +     ret = sysfs_create_link(&tzdev->device.kobj,
> > > +                             &ctrl->ctrl_device.kobj, "device");
> > > +     if (ret)
> > > +             goto remove_link;
> > > +
> > > +     return tzdev;
> > > +
> > > +remove_link:
> > > +     sysfs_remove_link(&ctrl->ctrl_device.kobj, name);
> > > +device_unregister:
> > > +     thermal_zone_device_unregister(tzdev);
> > > +
> > > +     return ERR_PTR(ret);
> > > +}
> > > +
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
> > I am not sure about this API design here. I would leave the error
> > handling and judging if this is fatal or not to the caller.
> > I mean, if I ask to register a nvme thermal zone and I get
> > a 0 as response, I would assume the thermal zone exists from
> > now on, right?
> 
> This routine is designed to return error code only when we're unable to
> communicate with the device at all (i.e. nvme_submit_sync_cmd returns a
> negative value).
> 
> We don't want to abandon device initialization just due to thermal zone
> failures.  Because thermal zone device isn't mandatory to manage the
> controllers, and the device like qemu doesn't provide smart log (according
> to Keith).

That is fair.. it is just really weird to continue your business when
the kernel cannot even allocate memory for you..

> 
> > > +
> > > +     ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > > +                        log, sizeof(*log), 0);
> > > +     if (ret) {
> > > +             dev_err(ctrl->device, "Failed to get SMART log: %d\n", ret);
> > > +             /* If the device provided a response, then it's non-fatal */
> > > +             if (ret > 0)
> > > +                     ret = 0;
> > > +             goto free_log;
> >
> > Once again, hiding errors is never a strategy that scales..
> >
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
> >
> > Here again, I would not hide errors, the API should propagate errors
> > if something goes wrong.
> >
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
> > > +
> > > +             if (!tzdev)
> > > +                     continue;
> > > +
> > > +             sysfs_remove_link(&tzdev->device.kobj, "device");
> > > +
> > > +             snprintf(name, sizeof(name), "temp%d", i);
> > > +             sysfs_remove_link(&ctrl->ctrl_device.kobj, name);
> > > +
> > > +             thermal_zone_device_unregister(tzdev);
> > > +
> > > +             ctrl->tzdev[i] = NULL;
> > > +     }
> > > +}
> > > +
> > > +#else
> > > +
> > > +static inline int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +static inline void nvme_thermal_zones_unregister(struct nvme_ctrl *ctrl)
> > > +{
> > > +}
> > > +
> > > +#endif /* CONFIG_THERMAL */
> > > +
> > >  struct nvme_core_quirk_entry {
> > >       /*
> > >        * NVMe model and firmware strings are padded with spaces.  For
> > > @@ -2754,6 +3037,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
> > >       if (ret < 0)
> > >               return ret;
> > >
> > > +     ret = nvme_thermal_zones_register(ctrl);
> > > +     if (ret < 0)
> > > +             return ret;
> >
> >
> > I would definitely keep this code the way it is here in
> > nvme_init_identify(), but if I read this right, your
> > nvme_thermal_zones_register() will never return < 0, and therefore this
> > condition is never met.
> 
> The nvme_get_log() can return a negative value.  Only in this case,
> nvme_thermal_zones_register() returns error and abandon the device
> initialization.
