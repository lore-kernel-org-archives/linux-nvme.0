From: keith.busch@intel.com (Keith Busch)
Date: Thu, 14 Aug 2014 09:33:38 -0600 (MDT)
Subject: [PATCH v11] NVMe: Convert to blk-mq
In-Reply-To: <53ECD125.3080701@fb.com>
References: <1406365643-27020-1-git-send-email-m@bjorling.me>
 <1406365643-27020-2-git-send-email-m@bjorling.me>
 <CAOu_J6mW-2e2Jgm+khodLPah_-RZrD599SmSH+Mszd0AjterrQ@mail.gmail.com>
 <alpine.LRH.2.03.1408131519590.14603@AMR> <53EC7273.5060303@bjorling.me>
 <53ECD125.3080701@fb.com>
Message-ID: <alpine.LRH.2.03.1408140920520.14603@AMR>

On Thu, 14 Aug 2014, Jens Axboe wrote:
> On 08/14/2014 02:25 AM, Matias Bj?rling wrote:
>> The result is set to BLK_MQ_RQ_QUEUE_ERROR, or am I mistaken?
>
> Looks OK to me, looking at the code, 'result' is initialized to
> BLK_MQ_RQ_QUEUE_BUSY though. Which looks correct, we don't want to error
> on a suspended queue.

My mistake missing how the result was initialized.

> nr_tags must be uninitialized or screwed up somehow, otherwise I don't
> see how that kmalloc() could warn on being too large. Keith, are you
> running with slab debugging? Matias, might be worth trying.

I'm not running with slab debugging. If it's any clue at all, blk-mq is
using 16 of the 31 allocated h/w queues (which is okay as we discussed
earlier), and the oops happens when clearing the first unused queue.

I'll have time to mess with this more today, so I can either help find
the problem or apply a patch if one becomes available.
