From: james.smart@broadcom.com (James Smart)
Date: Mon, 16 Oct 2017 07:57:31 -0700
Subject: [PATCH] nvmet: protect sqhd update by a lock
In-Reply-To: <20171016144428.ejwo5yr5p7iduftn@linux-x5ow.site>
References: <20171013203800.24125-1-jsmart2021@gmail.com>
 <20171016072145.wyrp2fyw2cx2grpf@linux-x5ow.site>
 <963d2bd1-1193-7961-eafe-862ddf6f7a91@gmail.com>
 <20171016144428.ejwo5yr5p7iduftn@linux-x5ow.site>
Message-ID: <db261e81-cd01-c5a3-5e60-a81d6dfc50fe@broadcom.com>

The real issue, where memory barrier isn't enough, is between the value 
of the sqhd increment followed by the modulo. Many of a time I've seen 
interruption in between these points.

As far as assignment of the cqe - as long a sqhd is getting updated 
properly, such that the cqe will return either the value just set? or a 
newer one, even if another cqe returns the same newer value, it's fine 
per the sqhd definition in nvme.

As it's no big deal - I'll repost with the lock moved

-- james


On 10/16/2017 7:44 AM, Johannes Thumshirn wrote:
> On Mon, Oct 16, 2017@07:37:48AM -0700, James Smart wrote:
>> Agree, is a little awkward. But works fine. The re-read will contain at
>> least the value that it was updated to under the lock. If it's actually the
>> value of a simultaneous update that is one further, that's actually fine too
>> - as sqhd isn't 1:1 with a cqe. Yes a cqe must contain the sqhd, but sqhd
>> can increment independently from a particuluar cqe. Key is that sqhd itself
>> must increment sanely so that whenever stamped in a cqe it's valid.
>>
>> I have no problem recutting with the lock around the assignment if desired.
> This to me sounds like a lock wasn't the right choice but a memory barrier
> would be needed. But OTOH I'm by no means a locking expert. What I _think_ is
> going on is, spin_lock_irqsave() is called, all the preempt_disable() and
> local_irq_save() (which are expensive) do their work and thus stretch timing
> enough that the desired effect is in place.
>
> But this is all guesswork.
>
> Byte,
> 	Johannes
>
