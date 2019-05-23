From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu, 23 May 2019 23:21:28 +0900
Subject: [PATCH v2 4/4] nvme-pci: support thermal zone
In-Reply-To: <20190522174648.GA26477@infradead.org>
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-5-git-send-email-akinobu.mita@gmail.com>
 <20190522174648.GA26477@infradead.org>
Message-ID: <CAC5umyhsnk_g5N+k_dMiBenPopGCLHg35+X2Jg+sEPBf2ZLKHA@mail.gmail.com>

2019?5?23?(?) 2:46 Christoph Hellwig <hch at infradead.org>:
>
> Is there any good reason why we need to call this from the PCIe driver
> instead of handling it all in the core?

OK. I'll move the thermal zones registration and unregistration into the
core module.

Call nvme_thermal_zones_register() in nvme_init_identify(), and call
nvme_thermal_zones_unregister() in nvme_stop_ctrl().

> Sure non-PCIe devices are usually external, but so are some PCIe
> devices, so if we really care about that we need some sort of flag
> anyway.

I'm going to not use the flag in next version.
If there is a demand, we'll have 'use_tz' or 'no_tz' flag in nvme_ctrl.
