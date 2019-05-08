From: minwoo.im@samsung.com (Minwoo Im)
Date: Wed, 08 May 2019 09:25:34 +0900
Subject: [PATCH v2 6/7] nvme-pci: add device coredump support
In-Reply-To: <20190507170733.GA6783@localhost.localdomain>
References: <20190507170733.GA6783@localhost.localdomain>
 <1557248314-4238-1-git-send-email-akinobu.mita@gmail.com>
 <1557248314-4238-7-git-send-email-akinobu.mita@gmail.com>
 <CGME20190507171318epcas5p129bb73b39447d62a7d266ed461687488@epcms2p3>
Message-ID: <20190508002534epcms2p3acacda8460fcfb7f2b978411b74bbbd5@epcms2p3>

> This is a bit of a mine field. The shutdown_lock is held when reclaiming
> requests that didn't see a response. If you're holding it here and your
> telemetry log page times out, we're going to deadlock. And since the
> controller is probably in a buggered state when you try to retrieve one,
> I would guess an unrecoverable timeout is the most likely outcome.

Akinobu,

I actually agree with Keith's one.  In my experience, there was always internal
error inside device when timeout occurs in nvme driver which means the
following command might not be completed due to lack of response from
device.
