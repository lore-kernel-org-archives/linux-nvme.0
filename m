From: xuehua@gmail.com (Xuehua Chen)
Date: Fri, 16 May 2014 16:34:57 -0700
Subject: A small concern on driver loading and unloading
Message-ID: <CAOu78O3CJPyyzZECbbHYZtfLR8Qc99y=byMj6qg2KOp7xLj4gg@mail.gmail.com>

Noticed something strange about the driver unloading and loading and
would like to ask a question here.

when driver is unloaded, nvme_shutdown_ctrl is called by nvme_remove.

cc = (readl(&dev->bar->cc) & ~NVME_CC_SHN_MASK) | NVME_CC_SHN_NORMAL;
       writel(cc, &dev->bar->cc);

This set NVME_CC_SHN_NORMAL in CC.

Then during driver loading,  nvme_disable_ctrl is called, which does this.

u32 cc = readl(&dev->bar->cc);

if (cc & NVME_CC_ENABLE)
        writel(cc & ~NVME_CC_ENABLE, &dev->bar->cc);


Checked the NVME spec 1.a  and didn't find it mention anywhere that
controller will reset Shutdown Notification field after shutdown
complete(please correct if this is incorrect). So the bits stay there.

When loading the driver, the NVME_CC_SHN_NORMAL is written when
disabling controller. This can be confusing. Why disabling the
controller and do a shutdown at the same time.

Maybe changing
writel(cc & ~NVME_CC_ENABLE, &dev->bar->cc);
to
writel(cc & ~NVME_CC_ENABLE & ~NVME_CC_SHN_MASK , &dev->bar->cc);
is safer.

Also it seems that
writel(0 , &dev->bar->cc);
can be simpler and the effects are the same. Disabling controller
reset controller registers including CC to default values. All fields
of the CC will be gone any way.

Thanks,
