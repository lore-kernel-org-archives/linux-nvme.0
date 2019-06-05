From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 6 Jun 2019 00:42:33 +0900
Subject: [PATCH v3 2/3] nvme: add thermal zone devices
In-Reply-To: <20190604073140.GH15680@lst.de>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-3-git-send-email-akinobu.mita@gmail.com>
 <20190601090238.GD6453@lst.de>
 <CAC5umyiBmD6-3BNLfG7sNOe9jde8Ct16a9N_Ao3T_1_G1K_DDA@mail.gmail.com>
 <20190604073140.GH15680@lst.de>
Message-ID: <CAC5umyiN9TTi5rrYjsk-Gh-6aYLJRYjemm-U5F_BpF_+XMaJ_g@mail.gmail.com>

2019?6?4?(?) 16:32 Christoph Hellwig <hch at lst.de>:
>
> On Sun, Jun 02, 2019@10:19:08PM +0900, Akinobu Mita wrote:
> > As long as the user space thermal governor is used, there is nothing more
> > than that from a functional perspective.  And I suppose that this is used
> > with user_space governor (i.e. there is still some work to be able to bind
> > actual thermal cooling device).
> >
> > The main purpose of this is to turn on a fan when overheated without
> > polling the device that could prevent the lower power state transitions.
> > But as you noted, we could do that with the existing AEN notifications
> > through uevent.
> >
> > So frankly speaking, the benefit of this is providing generic thermal sysfs
> > interface and the tools like tmon (linux/tools/thermal/tmon) can show the
> > nvme temperatures.
>
> I'm just a little worried about bloating the nvme driver with features
> that look kinda nifty but don't buy us much.  I'd rather keep at least
> the core and PCIe drivers as minimal.  Now the thermal device support
> is pretty small and except for the smart uevents I can't find anything
> actually bad, but I'm not exactly excited either.

I'll add thermal.c file in order to minimize the core driver changes and a
module parameter to disable the thermal zone support.

Device tree thermal zone will also be supported. It enables to use thermal
governor other than user_space governor.
