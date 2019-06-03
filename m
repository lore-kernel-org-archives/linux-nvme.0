From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Tue, 4 Jun 2019 00:03:14 +0900
Subject: [PATCH v2 2/4] nvme: add thermal zone infrastructure
In-Reply-To: <20190603021821.GA8354@localhost.localdomain>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-3-git-send-email-akinobu.mita@gmail.com>
 <20190524023520.GC1936@localhost.localdomain>
 <CAC5umyhCHJrzSSEy3NF38BhRQ9FSjVr8YfjChN-_3pVR5QwXsA@mail.gmail.com>
 <20190603021821.GA8354@localhost.localdomain>
Message-ID: <CAC5umygO0mKVJ5R4MhYTz44zVHvjkYSvrtT7=D1Rx2td-koeTQ@mail.gmail.com>

2019?6?3?(?) 11:18 Eduardo Valentin <edubezval at gmail.com>:

> > > Do we have something more meaningful or descriptive here? A more
> > > interesting type would be a string that could remind of the sensor
> > > location. Unless nvme_temp0 is enough to understand where this
> > > temperature is coming from, I would ask to get something more
> > > descriptive.
> >
> > The SMART log page defines composite temperature and temperature sensor 1
> > through temperature sensor 8.  So I think nvme_temp1 to nvme_temp8 are
> > descriptive.  And I personally prefer 'nvme_temp0' rather than
> > 'nvme_composite_temp'.
>
> I was leaning towards something even more descriptive. nvme_temp0 means
> what? Usually we want something more meaningful, Is this a co-processor?
> Is this a disk? what exactly nvme_temp0 really represents?

It's vendor specific. The NVMe spec only says a controller reports the
composite temperature and temperature sensor 1 through 8.
It doesn't define which part of the device (CPUs, DRAM, NAND, or else)
should implement temperature sensors and how the composite temperature is
calculated from implemented sensors.

I have three NVMe devices from different vendors.

The device A provides only composite temperature.

The device B provides composite temperature and temperature sensor 1.
Both temperatures are always same.

The device C provides the composite temperature and temperature sensor 1,
2, and 5.  For example, the smart log reports
Composite temperature : 43 C
Temperature Sensor 1  : 45 C
Temperature Sensor 2  : 41 C
Temperature Sensor 5  : 65 C

> > BTW, if we have more than two controllers, we'll have same type names
> > in the system.  So I'm going to append instance number after 'nvme'.
> > (e.g. nvme0_temp0).
> >
> > > > +     tzdev = thermal_zone_device_register(type, 1, 1, ctrl, &nvme_tz_ops,
> > > > +                                          &nvme_tz_params, 0, 0);
> > >
> > > Have you considered if there is a use case for using of-thermal here?
> >
> > Is it possible to specify the device node properties for the pci devices?
> > If so, of-thermal zone devices are very useful.
> >
>
> Yeah, I guess that would depend on the PCI device node descriptor that
> the sensor is going to be embedded, not of-thermal. But I would expect
> that DT has already a good enough DT descriptors for PCI devices, can
> you check that?

I can find the examples for ath9k and ath10k pcie wireless devices.
(Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt and
qcom,ath10k.txt)

> > I think normal thermal zone devices and of-thermal zone devices can
> > co-exist. (i.e. add 'tzdev_of[9]' in nvme_ctrl and the operations are
> > almost same with the normal one)
>
> Right, that is usually the case for drivers that have a real need to
> support both. Most of the drivers from embedded systems would prefer
> to keep only DT probing. But if you have a use case to support non-DT
> probing, yes, your driver would need to support both ways.

Distro kernels for x86 usually disables CONFIG_OF.  So we need both.
