From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 27 Jun 2019 00:52:22 +0900
Subject: [PATCH v4 2/3] nvme: add thermal zone devices
In-Reply-To: <1561474998.19713.13.camel@intel.com>
References: <1560439238-4054-1-git-send-email-akinobu.mita@gmail.com>
 <1560439238-4054-3-git-send-email-akinobu.mita@gmail.com>
 <1561474998.19713.13.camel@intel.com>
Message-ID: <CAC5umyjhU7Xv=UyhfO5ikDwpGBTXCdaggfLt9UM7ZygUL1O1DQ@mail.gmail.com>

2019?6?26?(?) 0:03 Zhang Rui <rui.zhang at intel.com>:
>
> On ?, 2019-06-14@00:20 +0900, Akinobu Mita wrote:
> > The NVMe controller reports up to nine temperature values in the
> > SMART /
> > Health log page (the composite temperature and temperature sensor 1
> > through
> > temperature sensor 8).
> >
> > This provides these temperatures via thermal zone devices.
> >
> > Once the controller is identified, the thermal zone devices are
> > created for
> > all implemented temperature sensors including the composite
> > temperature.
> >
> > /sys/class/thermal/thermal_zone[0-*]:
> >     |---type: 'nvme<instance>-temp<sensor>'
> >     |---temp: Temperature
> >     |---trip_point_0_temp: Over temperature threshold
> >
> > The thermal_zone[0-*] contains a 'device' symlink to the
> > corresponding nvme
> > device.
> >
> > On the other hand, the following symlinks to the thermal zone devices
> > are
> > created in the nvme device sysfs directory.
> >
> > - temp0: Composite temperature
> > - temp1: Temperature sensor 1
> > ...
> > - temp8: Temperature sensor 8
> >
> > In addition to the standard thermal zone device, this also adds
> > support for
> > registering the DT thermal zone device.
> >
> I don't see standard thermal zone device and DT thermal zone device are
> registered at the same time very often, especially if they represent
> the same sensor.

Good point.

It is pointless to register both standard and DT thermal zone devices for
the same sensor.  We should register either one. (i.e. firstly try to
register DT thermal zone.  If no thermal zones found for the sensor in
device tree, then try to register standard one)
