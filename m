From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 14 Aug 2019 00:40:04 +0900
Subject: [PATCH v3 4/6] block: introduce LED block device activity trigger
In-Reply-To: <20190813103313.GC26337@amd>
References: <1565459703-30513-1-git-send-email-akinobu.mita@gmail.com>
 <1565459703-30513-5-git-send-email-akinobu.mita@gmail.com>
 <20190813103313.GC26337@amd>
Message-ID: <CAC5umyhpVdMwrm_U7RGq=q4F+mrgGJC01rLvjs4HbF5_C-kXQw@mail.gmail.com>

2019?8?13?(?) 19:33 Pavel Machek <pavel at ucw.cz>:
>
> On Sun 2019-08-11 02:55:01, Akinobu Mita wrote:
> > This allows LEDs to be controlled by block device activity.
> >
> > We already have ledtrig-disk (LED disk activity trigger), but the lower
> > level disk drivers need to utilize ledtrig_disk_activity() to make the
> > LED blink.
> >
> > The LED block device trigger doesn't require the lower level drivers to
> > have any instrumentation. The activity is collected by polling the disk
> > stats.
> >
> > Example:
> >
> > echo block-nvme0n1 > /sys/class/leds/diy/trigger
>
> Some machines have lots of block devices... Should we perhaps have
> "echo block > trigger; echo nvme0n1 > device"?

I originally considered doing so, just like ledtrig-netdev. However, it
turned out that we needed an additional mechanism to mediate between
the led trigger registration and the block device unregistration.
