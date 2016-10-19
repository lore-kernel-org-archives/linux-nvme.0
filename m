From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 20 Oct 2016 07:47:46 +0800
Subject: [PATCH v3 04/11] blk-mq: Introduce blk_mq_quiesce_queue()
In-Reply-To: <0718ec72-d525-2e75-a123-3bf9ea129319@sandisk.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
 <e42a952c-f245-eb39-d0a1-0336035573f9@sandisk.com>
 <0718ec72-d525-2e75-a123-3bf9ea129319@sandisk.com>
Message-ID: <CACVXFVM1tRXPDkJZbrtxkgZ=Uy9iCAh3OvmHf5BC23RbJkbMKg@mail.gmail.com>

On Thu, Oct 20, 2016 at 5:04 AM, Bart Van Assche
<bart.vanassche@sandisk.com> wrote:
> On 10/18/2016 02:50 PM, Bart Van Assche wrote:
>>
>> blk_mq_quiesce_queue() waits until ongoing .queue_rq() invocations
>> have finished. This function does *not* wait until all outstanding
>> requests have finished (this means invocation of request.end_io()).
>
>
> (replying to my own e-mail)
>
> The zero-day kernel test infrastructure reported to me that this patch
> causes a build failure with CONFIG_SRCU=n. Should I add "select SRCU" to
> block/Kconfig (excludes TINY_RCU) or should I rather modify this patch such

Select SRCU is fine, and you can see it is done in lots of
places(btrfs, net, quota, kvm, power,...)

> that a mutex or rwsem is used instead of SRCU?

Both should be much worse than SRCU, even not as good as atomic_t.

Thanks,
Ming

>
> Thanks,
>
> Bart.
>



-- 
Ming Lei
