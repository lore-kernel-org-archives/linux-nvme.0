From: keith.busch@intel.com (Keith Busch)
Date: Sun, 18 May 2014 12:08:19 -0600 (MDT)
Subject: A small concern on driver loading and unloading
In-Reply-To: <CAOu78O3CJPyyzZECbbHYZtfLR8Qc99y=byMj6qg2KOp7xLj4gg@mail.gmail.com>
References: <CAOu78O3CJPyyzZECbbHYZtfLR8Qc99y=byMj6qg2KOp7xLj4gg@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1405181200590.5666@AMR>

On Fri, 16 May 2014, Xuehua Chen wrote:
> Noticed something strange about the driver unloading and loading and
> would like to ask a question here.
>
> when driver is unloaded, nvme_shutdown_ctrl is called by nvme_remove.
>
> cc = (readl(&dev->bar->cc) & ~NVME_CC_SHN_MASK) | NVME_CC_SHN_NORMAL;
>       writel(cc, &dev->bar->cc);
>
> This set NVME_CC_SHN_NORMAL in CC.
>
> Then during driver loading,  nvme_disable_ctrl is called, which does this.
>
> u32 cc = readl(&dev->bar->cc);
>
> if (cc & NVME_CC_ENABLE)
>        writel(cc & ~NVME_CC_ENABLE, &dev->bar->cc);
>
>
> Checked the NVME spec 1.a  and didn't find it mention anywhere that
> controller will reset Shutdown Notification field after shutdown
> complete(please correct if this is incorrect). So the bits stay there.

That should be okay: we are about to clear the shutdown bits right after
controller reset completes and the CSTS.RDY bit is cleared.

> When loading the driver, the NVME_CC_SHN_NORMAL is written when
> disabling controller. This can be confusing. Why disabling the
> controller and do a shutdown at the same time.

We write whatever the previous CC values were but without CC.EN, so it
should not trigger another shutdown on the device.

> Maybe changing
> writel(cc & ~NVME_CC_ENABLE, &dev->bar->cc);
> to
> writel(cc & ~NVME_CC_ENABLE & ~NVME_CC_SHN_MASK , &dev->bar->cc);
> is safer.
>
> Also it seems that
> writel(0 , &dev->bar->cc);

I'm not sure we want to do either of those. The comment in the driver
above "nvme_disable_ctrl" indicates that changing the shutdown bits
might cause undesired behavior when the controller is "enabled" and in
a ready state.

> can be simpler and the effects are the same. Disabling controller
> reset controller registers including CC to default values. All fields
> of the CC will be gone any way.
