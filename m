From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Fri, 24 May 2019 22:57:36 +0900
Subject: [PATCH v2 2/4] nvme: add thermal zone infrastructure
In-Reply-To: <20190524023520.GC1936@localhost.localdomain>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
 <20190524023520.GC1936@localhost.localdomain>
Message-ID: <CAC5umyhCHJrzSSEy3NF38BhRQ9FSjVr8YfjChN-_3pVR5QwXsA@mail.gmail.com>

2019?5?24?(?) 11:35 Eduardo Valentin <edubezval at gmail.com>:
>
> Hello Mita,
>
> On Wed, May 22, 2019@01:04:07AM +0900, Akinobu Mita wrote:
> > The NVMe controller reports up to nine temperature values in the SMART /
> > Health log page (the composite temperature and temperature sensor 1 through
> > temperature sensor 8).
>
> Is this a fixed number or we should be more flexible on the amount of
> sensors?

Max number is fixed.  In NVMe spec revision 1.3, a controller reports up
to nine temperature values in the SMART / Health information log.

It may change to more than nine in the future, but we can fix then.

> > The temperature threshold feature (Feature Identifier 04h) configures the
> > asynchronous event request command to complete when the temperature is
> > crossed its corresponding temperature threshold.
> >
> > This adds infrastructure to provide these temperatures and thresholds via
> > thermal zone devices.
> >
> > The nvme_thermal_zones_register() creates up to nine thermal zone devices
> > for all implemented temperature sensors including the composite
> > temperature.
>
> great!
>
> >
> > /sys/class/thermal/thermal_zone[0-*]:
> >     |---temp: Temperature
> >     |---trip_point_0_temp: Over temperature threshold
> >
> > The thermal_zone[0-*] contains a symlink to the corresponding nvme device.
> > On the other hand, the following symlinks to the thermal zone devices are
> > created in the nvme device sysfs directory.
> >
> > - nvme_temp0: Composite temperature
> > - nvme_temp1: Temperature sensor 1
> > ...
> > - nvme_temp8: Temperature sensor 8
> >
> > The nvme_thermal_zones_unregister() removes the registered thermal zone
> > devices and symlinks.
> >
> > Cc: Zhang Rui <rui.zhang at intel.com>
> > Cc: Eduardo Valentin <edubezval at gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano at linaro.org>
> > Cc: Keith Busch <keith.busch at intel.com>
> > Cc: Jens Axboe <axboe at fb.com>
> > Cc: Christoph Hellwig <hch at lst.de>
> > Cc: Sagi Grimberg <sagi at grimberg.me>
> > Cc: Minwoo Im <minwoo.im.dev at gmail.com>
> > Cc: Kenneth Heitke <kenneth.heitke at intel.com>
> > Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni at wdc.com>
> > Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> > ---
> > * v2
> > - s/correspoinding/corresponding/ typo in commit log
> > - Borrowed nvme_get_features() from Keith's patch
> > - Temperature threshold notification is splitted into another patch
> > - Change the data type of 'sensor' to unsigned
> > - Add BUILD_BUG_ON for the array size of tzdev member in nvme_ctrl
> > - Add WARN_ON_ONCE for paranoid checks
> > - Fix off-by-one error in nvme_get_temp
> > - Validate 'sensor' where the value is actually used
> > - Define and utilize two enums related to the temperature threshold feature
> > - Remove hysteresis value for this trip point and don't utilize the under
> >   temperature threshold
> > - Print error message for thermal_zone_device_register() failure
> > - Add function comments for nvme_thermal_zones_{,un}register
> > - Suppress non-fatal errors from nvme_thermal_zones_register()
> > - Add comment about implemented temperature sensors
> > - Instead of creating a new 'thermal_work', append async smart event's
> >   action to the existing async_event_work
> > - Add comment for tzdev member in nvme_ctrl
> >
> >  drivers/nvme/host/core.c | 265 +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/nvme/host/nvme.h |  27 +++++
> >  include/linux/nvme.h     |   5 +
> >  3 files changed, 297 insertions(+)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index c04df80..0ec303c 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2179,6 +2179,271 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
> >       }
> >  }
> >
> > +#ifdef CONFIG_THERMAL
> > +
> > +static int nvme_get_temp(struct nvme_ctrl *ctrl, unsigned int sensor, int *temp)
> > +{
> > +     struct nvme_smart_log *log;
> > +     int ret;
> > +
> > +     BUILD_BUG_ON(ARRAY_SIZE(log->temp_sensor) + 1 !=
> > +                  ARRAY_SIZE(ctrl->tzdev));
>
> When would this be triggered?

This just ensures that the temperature fields for the SMART log page
structure and nvme_ctrl are not changed accidentally.

> > +
> > +     if (WARN_ON_ONCE(sensor > ARRAY_SIZE(log->temp_sensor)))
> > +             return -EINVAL;
> > +
> > +     log = kzalloc(sizeof(*log), GFP_KERNEL);
>
> Do we really need to allocate memory every time we want to read
> temperature? Is this struct too large to fit stack?

I think 512 bytes is too large in the kernel stack

> > +     if (!log)
> > +             return -ENOMEM;
> > +
> > +     ret = nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
> > +                        log, sizeof(*log), 0);
> > +     if (ret) {
> > +             ret = ret > 0 ? -EINVAL : ret;
> > +             goto free_log;
> > +     }
> > +
> > +     if (sensor)
> > +             *temp = le16_to_cpu(log->temp_sensor[sensor - 1]);
> > +     else
> > +             *temp = get_unaligned_le16(log->temperature);
> > +
> > +     if (!*temp)
> > +             ret = -EINVAL;
> > +
> > +free_log:
> > +     kfree(log);
> > +
> > +     return ret;
> > +}
> > +
> > +static unsigned int nvme_tz_type_to_sensor(const char *type)
> > +{
> > +     unsigned int sensor;
> > +
> > +     if (sscanf(type, "nvme_temp%u", &sensor) != 1)
> > +             return UINT_MAX;
> > +
> > +     return sensor;
> > +}
> > +
> > +#define KELVIN_TO_MILLICELSIUS(t) DECI_KELVIN_TO_MILLICELSIUS((t) * 10)
> > +#define MILLICELSIUS_TO_KELVIN(t) ((MILLICELSIUS_TO_DECI_KELVIN(t) + 5) / 10)
> > +
> > +static int nvme_tz_get_temp(struct thermal_zone_device *tzdev,
> > +                         int *temp)
> > +{
> > +     unsigned int sensor = nvme_tz_type_to_sensor(tzdev->type);
> > +     struct nvme_ctrl *ctrl = tzdev->devdata;
> > +     int ret;
> > +
> > +     ret = nvme_get_temp(ctrl, sensor, temp);
> > +     if (!ret)
> > +             *temp = KELVIN_TO_MILLICELSIUS(*temp);
> > +
> > +     return ret;
> > +}
> > +
> > +static int nvme_tz_get_trip_type(struct thermal_zone_device *tzdev,
> > +                              int trip, enum thermal_trip_type *type)
> > +{
> > +     *type = THERMAL_TRIP_ACTIVE;
> > +
> > +     return 0;
> > +}
> > +
> > +static int nvme_get_over_temp_thresh(struct nvme_ctrl *ctrl,
> > +                                  unsigned int sensor, int *temp)
> > +{
> > +     unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
> > +     int status;
> > +     int ret;
> > +
> > +     if (WARN_ON_ONCE(sensor >= ARRAY_SIZE(ctrl->tzdev)))
> > +             return -EINVAL;
> > +
> > +     ret = nvme_get_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
> > +                             &status);
> > +     if (!ret)
> > +             *temp = status & NVME_TEMP_THRESH_MASK;
> > +
> > +     return ret > 0 ? -EINVAL : ret;
> > +}
> > +
> > +static int nvme_set_over_temp_thresh(struct nvme_ctrl *ctrl,
> > +                                  unsigned int sensor, int temp)
> > +{
> > +     unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
> > +     int status;
> > +     int ret;
> > +
> > +     if (WARN_ON_ONCE(sensor >= ARRAY_SIZE(ctrl->tzdev)))
> > +             return -EINVAL;
> > +
> > +     if (temp > NVME_TEMP_THRESH_MASK)
> > +             return -EINVAL;
> > +
> > +     threshold |= temp & NVME_TEMP_THRESH_MASK;
> > +
> > +     ret = nvme_set_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
> > +                             &status);
> > +
> > +     return ret > 0 ? -EINVAL : ret;
> > +}
> > +
> > +static int nvme_tz_get_trip_temp(struct thermal_zone_device *tzdev,
> > +                              int trip, int *temp)
> > +{
> > +     unsigned int sensor = nvme_tz_type_to_sensor(tzdev->type);
> > +     struct nvme_ctrl *ctrl = tzdev->devdata;
> > +     int ret;
> > +
> > +     ret = nvme_get_over_temp_thresh(ctrl, sensor, temp);
> > +     if (!ret)
> > +             *temp = KELVIN_TO_MILLICELSIUS(*temp);
> > +
> > +     return ret;
> > +}
> > +
> > +static int nvme_tz_set_trip_temp(struct thermal_zone_device *tzdev,
> > +                              int trip, int temp)
> > +{
> > +     unsigned int sensor = nvme_tz_type_to_sensor(tzdev->type);
> > +     struct nvme_ctrl *ctrl = tzdev->devdata;
> > +
> > +     temp = MILLICELSIUS_TO_KELVIN(temp);
> > +
> > +     return nvme_set_over_temp_thresh(ctrl, sensor, temp);
> > +}
> > +
> > +static struct thermal_zone_device_ops nvme_tz_ops = {
> > +     .get_temp = nvme_tz_get_temp,
> > +     .get_trip_type = nvme_tz_get_trip_type,
> > +     .get_trip_temp = nvme_tz_get_trip_temp,
> > +     .set_trip_temp = nvme_tz_set_trip_temp,
> > +};
> > +
> > +static struct thermal_zone_params nvme_tz_params = {
> > +     .governor_name = "user_space",
> > +     .no_hwmon = true,
> > +};
> > +
> > +static struct thermal_zone_device *
> > +nvme_thermal_zone_register(struct nvme_ctrl *ctrl, unsigned int sensor)
> > +{
> > +     struct thermal_zone_device *tzdev;
> > +     char type[THERMAL_NAME_LENGTH];
> > +     int ret;
> > +
> > +     snprintf(type, sizeof(type), "nvme_temp%d", sensor);
> > +
>
> Do we have something more meaningful or descriptive here? A more
> interesting type would be a string that could remind of the sensor
> location. Unless nvme_temp0 is enough to understand where this
> temperature is coming from, I would ask to get something more
> descriptive.

The SMART log page defines composite temperature and temperature sensor 1
through temperature sensor 8.  So I think nvme_temp1 to nvme_temp8 are
descriptive.  And I personally prefer 'nvme_temp0' rather than
'nvme_composite_temp'.

BTW, if we have more than two controllers, we'll have same type names
in the system.  So I'm going to append instance number after 'nvme'.
(e.g. nvme0_temp0).

> > +     tzdev = thermal_zone_device_register(type, 1, 1, ctrl, &nvme_tz_ops,
> > +                                          &nvme_tz_params, 0, 0);
>
> Have you considered if there is a use case for using of-thermal here?

Is it possible to specify the device node properties for the pci devices?
If so, of-thermal zone devices are very useful.

I think normal thermal zone devices and of-thermal zone devices can
co-exist. (i.e. add 'tzdev_of[9]' in nvme_ctrl and the operations are
almost same with the normal one)
