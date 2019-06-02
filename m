From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sun, 2 Jun 2019 22:19:08 +0900
Subject: [PATCH v3 2/3] nvme: add thermal zone devices
In-Reply-To: <20190601090238.GD6453@lst.de>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
 <20190601090238.GD6453@lst.de>
Message-ID: <CAC5umyiBmD6-3BNLfG7sNOe9jde8Ct16a9N_Ao3T_1_G1K_DDA@mail.gmail.com>

2019?6?1?(?) 18:03 Christoph Hellwig <hch at lst.de>:
>
> On Mon, May 27, 2019@01:29:02AM +0900, Akinobu Mita wrote:
> > The NVMe controller reports up to nine temperature values in the SMART /
> > Health log page (the composite temperature and temperature sensor 1 through
> > temperature sensor 8).
> >
> > This provides these temperatures via thermal zone devices.
>
> Can you explain a bit more why we'd do this?  I shows up some sysfs
> files, but we could easily do that with nvme-cli, too.  Is there some
> greater benefit of this integration?

As long as the user space thermal governor is used, there is nothing more
than that from a functional perspective.  And I suppose that this is used
with user_space governor (i.e. there is still some work to be able to bind
actual thermal cooling device).

The main purpose of this is to turn on a fan when overheated without
polling the device that could prevent the lower power state transitions.
But as you noted, we could do that with the existing AEN notifications
through uevent.

So frankly speaking, the benefit of this is providing generic thermal sysfs
interface and the tools like tmon (linux/tools/thermal/tmon) can show the
nvme temperatures.
