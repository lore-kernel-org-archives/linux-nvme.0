From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed, 24 Jul 2019 13:12:03 -0600
Subject: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
In-Reply-To: <dd287560-2cb3-28ab-c22d-fe9f3682c609@grimberg.me>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
 <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
 <6deea9e7-ff3c-e115-b2f2-8914df0b6da7@deltatee.com>
 <dd287560-2cb3-28ab-c22d-fe9f3682c609@grimberg.me>
Message-ID: <021b5195-9a09-4cc2-064f-940ada9cf764@deltatee.com>

Hey,

Sorry for the delay.

I tested your patch and it does work. Do you want me to send your change
as a full patch? Can I add your signed-off-by?

On 2019-07-18 6:50 p.m., Sagi Grimberg wrote:
>> I didn't think the scan_lock was that contested or that
>> nvme_change_ctrl_state() was really called that often...
> 
> it shouldn't be, but I think it makes the flow more convoluted
> as we serialize by flushing the scan_work right after...

I would argue that the check for state in nvme_scan_work() without a
lock is racy and confusing. There's nothing to prevent the state from
changing immediately after the check.

> The design principal is met as we do get the I/O failing,
> but its just that with mpath we simply queue the I/O again
> because the head->list happens to not be empty.
> Perhaps taking care of that check is cleaner.

Yes, I feel your patch is a good solution on it's own merits.
> Thanks. Do you have a firm reproducer for it?

Yes. If you connect to and then immediately disconnect from a target (at
least with nvme-loop) you will reliably trigger this bug -- or one of
the others I've sent patches for.

>>>> +??? mutex_lock(&ctrl->scan_lock);
>>>> +
>>>> ?????? if (ctrl->state != NVME_CTRL_LIVE)
>>>> ?????????? return;
>>>
>>> unlock
>>
>> If we unlock here and relock below, we'd have to recheck the ctrl->state
>> to avoid any races. If you don't want to call nvme_identify_ctrl with
>> the lock held, then it would probably be better to move the state check
>> below it.
> 
> Meant before the return statement.

Ah, right, my mistake.

Logan
