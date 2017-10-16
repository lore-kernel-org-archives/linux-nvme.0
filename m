From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 16 Oct 2017 16:44:28 +0200
Subject: [PATCH] nvmet: protect sqhd update by a lock
In-Reply-To: <963d2bd1-1193-7961-eafe-862ddf6f7a91@gmail.com>
References: <20171013203800.24125-1-jsmart2021@gmail.com>
 <20171016072145.wyrp2fyw2cx2grpf@linux-x5ow.site>
 <963d2bd1-1193-7961-eafe-862ddf6f7a91@gmail.com>
Message-ID: <20171016144428.ejwo5yr5p7iduftn@linux-x5ow.site>

On Mon, Oct 16, 2017@07:37:48AM -0700, James Smart wrote:
> Agree, is a little awkward. But works fine. The re-read will contain at
> least the value that it was updated to under the lock. If it's actually the
> value of a simultaneous update that is one further, that's actually fine too
> - as sqhd isn't 1:1 with a cqe. Yes a cqe must contain the sqhd, but sqhd
> can increment independently from a particuluar cqe. Key is that sqhd itself
> must increment sanely so that whenever stamped in a cqe it's valid.
> 
> I have no problem recutting with the lock around the assignment if desired.

This to me sounds like a lock wasn't the right choice but a memory barrier
would be needed. But OTOH I'm by no means a locking expert. What I _think_ is
going on is, spin_lock_irqsave() is called, all the preempt_disable() and
local_irq_save() (which are expensive) do their work and thus stretch timing
enough that the desired effect is in place.

But this is all guesswork.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
