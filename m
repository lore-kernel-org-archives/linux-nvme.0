From: keith.busch@intel.com (Keith Busch)
Date: Tue, 26 May 2015 15:16:47 +0000 (UTC)
Subject: [PATCH] NVMe: Fix obtaining command result
In-Reply-To: <20150523130150.GA18701@lst.de>
References: <1432319311-2895-1-git-send-email-keith.busch@intel.com>
 <20150523130150.GA18701@lst.de>
Message-ID: <alpine.LNX.2.00.1505261512120.15930@localhost.lm.intel.com>

On Sat, 23 May 2015, Christoph Hellwig wrote:
> On Fri, May 22, 2015@12:28:31PM -0600, Keith Busch wrote:
>> Replaces req->sense_len usage, which is not owned by the LLD, to
>> req->special to contain the command result for driver created commands,
>> and sets the result unconditionally on completion.
>
> Thanks Keith,
>
> sorry for the mess, after porting this from my series to use replace
> the BLOCK_PC specific fields to mainline I only tested this on Qemu
> which only has a single queue.  I'll make sure to always do final
> testing on real hardware as well.

No problem, it's a good enhancement overall and caught early enough,
so no a big deal. Break and fix cycles are better than doing nothing. :)

BTW, the qemu nvme block device *should* be multi-queue capable if you
allocate multiple CPUs (-smp <cpus>) to your guest. It works in my tree
at least, so I hope it works in qemu mainline. Maybe I'll have time this
week to look at that.
