From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 12 May 2016 09:12:08 +0200
Subject: [PATH v2] NVMe: init nvme queue before enabling irq
In-Reply-To: <20160511191632.GC31047@localhost.localdomain>
References: <1453286915-18814-1-git-send-email-mail_weber_wang@163.com>
 <e41c65a6b6637ef16f7f11ac147a9466@suse.de>
 <20160511191632.GC31047@localhost.localdomain>
Message-ID: <20160512071207.GC25134@c203.arch.suse.de>

On Wed, May 11, 2016@03:16:33PM -0400, Keith Busch wrote:
> On Wed, May 11, 2016@11:25:16AM +0200, Johannes Thumshirn wrote:
> > What ever happened to this patch?
> > I can easily reproduce the bug using
> > while [ true ]; do rmmod nvme nvme_core; modprobe nvme; done
> 
> This patch was supposed to fix using a doorbell between resets when the
> driver had BAR0 unmapped. We don't ever unmap the bar anymore, so this
> patch shouldn't be necessary: the doorbell is already set during queue
> allocation before requset_irq.
> 
> The test doesn't seem like this patch would help either. It sounds
> more like you're hitting somethine else if you don't have this fix:
> 
>   https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git/commit/?h=for-linus&id=9bf2b972afeaffd173fe2ce211ebc555ea7e8a87
> 
> If you do have that fix already, I'd like to see the panic stack trace
> (assuming that's what happened).

Yup, having that commit.

I'm going to reproduce (with current Linus' master) w/o the patch applied
later today.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
