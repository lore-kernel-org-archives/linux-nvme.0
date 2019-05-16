From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 17 May 2019 01:48:13 +0900
Subject: [PATCH 1/2] nvme: add thermal zone infrastructure
In-Reply-To: <CAC5umyjxxWzCgyMOS=Q7BBBJY+n6xD1dg49fQ0W5okPh58Z1Kw@mail.gmail.com>
References: <1557933437-4693-1-git-send-email-akinobu.mita@gmail.com>
 <1557933437-4693-2-git-send-email-akinobu.mita@gmail.com>
 <20190516143212.GE24001@minwooim-desktop>
 <CAC5umyjxxWzCgyMOS=Q7BBBJY+n6xD1dg49fQ0W5okPh58Z1Kw@mail.gmail.com>
Message-ID: <20190516164811.GF24001@minwooim-desktop>

On 19-05-17 01:17:31, Akinobu Mita wrote:
> 2019?5?16?(?) 23:32 Minwoo Im <minwoo.im.dev at gmail.com>:
> >
> > > +     if (sensor < 0 || sensor > 8)
> > > +             return -EINVAL;
> >
> > Does we really need to check the negative case here ?  Am I missing
> > something in this context ?  If we really want to check it in this
> > level, can we check the invalid case in the following function?
> 
> The negative case should never happen, so it can be just removed.

Cool.

> 
> > > +static struct thermal_zone_device *
> > > +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, int sensor)
> > > +{
> > > +     struct thermal_zone_device *tzdev;
> > > +     char type[THERMAL_NAME_LENGTH];
> > > +     int ret;
> > > +
> > > +     snprintf(type, sizeof(type), "nvme_temp%d", sensor);
> >
> > Before preparing "nvme_temp%d", maybe we can make it sure here. :)
> > What do you say?
> 
> The nvme_thermal_zone_register() is only called from
> nvme_thermal_zones_register() which is defined just below, and it's very
> clear that the value of 'sensor' is from 0 to ARRAY_SIZE(ctrl->tzdev) - 1.

If so, we don't need to check the negative case above there.

> 
> > > +int nvme_thermal_zones_register(struct nvme_ctrl *ctrl)
> > > +{
> > > +     struct nvme_smart_log *log;
> > > +     int ret;
> > > +     int i;
> > > +
> > > +     log = kzalloc(sizeof(*log), GFP_KERNEL);
> > > +     if (!log)
> > > +             return -ENOMEM;
> > > +
> > > +     ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > > +                        log, sizeof(*log), 0);
> > > +     if (ret) {
> > > +             ret = ret > 0 ? -EINVAL : ret;
> > > +             goto free_log;
> > > +     }
> > > +
> > > +     for (i = 0; i < ARRAY_SIZE(ctrl->tzdev); i++) {
> > > +             struct thermal_zone_device *tzdev;
> > > +
> > > +             if (i && !le16_to_cpu(log->temp_sensor[i - 1]))
> > > +                     continue;
> > > +             if (ctrl->tzdev[i])
> > > +                     continue;
> > > +
> > > +             tzdev = nvme_thermal_zone_register(ctrl, i);
> > > +             if (!IS_ERR(tzdev))
> > > +                     ctrl->tzdev[i] = tzdev;
> >
> > Quenstion here. Are we okay not to print some warnings here in case
> > of error returned?
> 
> I'm going to print warning in case of thermal_zone_device_register() error.
> For sysfs_create_link() error, the warning is printed by the function
> itself.

Sounds great.

Thanks,
