From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 9 May 2019 01:02:21 +0900
Subject: [PATCH v2 6/7] nvme-pci: add device coredump support
In-Reply-To: <20190508002534epcms2p3acacda8460fcfb7f2b978411b74bbbd5@epcms2p3>
References: <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
 <CGME20190507171318epcas5p129bb73b39447d62a7d266ed461687488@epcms2p3>
 <20190507170733.GA6783@localhost.localdomain>
 <20190508002534epcms2p3acacda8460fcfb7f2b978411b74bbbd5@epcms2p3>
Message-ID: <CAC5umyjsC_ECC4c_fS5QhVY1JgfSLx6ecEPVua=0j=K+JaiFpQ@mail.gmail.com>

2019?5?8?(?) 9:25 Minwoo Im <minwoo.im at samsung.com>:
>
> > This is a bit of a mine field. The shutdown_lock is held when reclaiming
> > requests that didn't see a response. If you're holding it here and your
> > telemetry log page times out, we're going to deadlock. And since the
> > controller is probably in a buggered state when you try to retrieve one,
> > I would guess an unrecoverable timeout is the most likely outcome.
>
> Akinobu,
>
> I actually agree with Keith's one.  In my experience, there was always internal
> error inside device when timeout occurs in nvme driver which means the
> following command might not be completed due to lack of response from
> device.

The nvme_coredump() is .coredump() callback of device_driver which is
called when anything is written to the /sys/devices/.../coredump.
Providing this callback is optional, but simply removing this manual
device coredump method is a bit inconvenient.

So instead of directly retrieving the snapshot with the shutdown_lock held
in this callback, I'll change this to just scheduling the reset work, and
the actual device coredump will be triggered by the same procedure that is
implemented in the patch 7/7.  Therefore telemetry log is retrieved only
when the controller is successfully recovered from the crash.
