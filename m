From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Nov 2014 15:39:00 +0000 (UTC)
Subject: System hang issue during hibernation resume due to del_gendisk
In-Reply-To: <000901cfff54$cb924410$62b6cc30$@samsung.com>
References: <000901cfff54$cb924410$62b6cc30$@samsung.com>
Message-ID: <alpine.LNX.2.00.1411131518050.4225@localhost.lm.intel.com>

On Thu, 13 Nov 2014, Sunad Bhandary wrote:
>> I knew calling del_gendisk from resume wouldn't work, which is why it's
>> done in a work queue, and removed in another thread if the device is gone.
>> That's still not okay?
>
> If we resume the system from hibernation with the kernel commandline
> parameter pciehp.pciehp_force = 1, then the nvme_remove function is called
> instead of nvme_resume.
> In this case del_gendisk is called on the same thread which leads to
> potential problems

Oh, so 'resume' is not getting called. I have to admit, I did not know
pciehp could handle removing a device before resume was completed.

I don't think the problem is calling del_gendisk from this context. We
just need to make sure the driver is not internally holding commands it
is not going to complete before calling del_gendisk. Did you happen to
test with this patch included?

http://git.infradead.org/users/willy/linux-nvme.git/commit/74bae7e0dd70f3eee05d577d3d25fbcd54af4228

del_gendisk can totally deadlock without it if your filesystem has dirty
data. If you did have that commit, then I'm baffled.
