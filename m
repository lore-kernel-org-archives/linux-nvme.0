From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 18 Jul 2019 17:50:11 -0700
Subject: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
In-Reply-To: <6deea9e7-ff3c-e115-b2f2-8914df0b6da7@deltatee.com>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
 <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
 <6deea9e7-ff3c-e115-b2f2-8914df0b6da7@deltatee.com>
Message-ID: <dd287560-2cb3-28ab-c22d-fe9f3682c609@grimberg.me>


>>> With multipath enabled, nvme_scan_work() can read from the
>>> device (through nvme_mpath_add_disk()). However, with fabrics,
>>> once ctrl->state is set to NVME_CTRL_DELETING, the reads will hang
>>> (see nvmf_check_ready()).
>>>
>>> After setting the state to deleting, nvme_remove_namespaces() will
>>> hang waiting for scan_work to flush and these tasks will hang.
>>>
>>> To fix this, ensure we take scan_lock before changing the ctrl-state.
>>> Also, ensure the state is checked while the lock is held
>>> in nvme_scan_lock_work().
>>
>> That's a big hammer...
> 
> I didn't think the scan_lock was that contested or that
> nvme_change_ctrl_state() was really called that often...

it shouldn't be, but I think it makes the flow more convoluted
as we serialize by flushing the scan_work right after...

The design principal is met as we do get the I/O failing,
but its just that with mpath we simply queue the I/O again
because the head->list happens to not be empty.
Perhaps taking care of that check is cleaner.

>> But this is I/O that we cannot have queued until we have a path..
>>
>> I would rather have nvme_remove_namespaces() requeue all I/Os for
>> namespaces that serve as the current_path and have the make_request
>> routine to fail I/O if all controllers are deleting as well.
>>
>> Would something like [1] (untested) make sense instead?
> 
> I'll have to give this a try next week and I'll let you know then. It
> kind of makes sense to me but a number of things I tried to fix this
> that I thought made sense did not work.

Thanks. Do you have a firm reproducer for it?

>>> +??? mutex_lock(&ctrl->scan_lock);
>>> +
>>>  ????? if (ctrl->state != NVME_CTRL_LIVE)
>>>  ????????? return;
>>
>> unlock
> 
> If we unlock here and relock below, we'd have to recheck the ctrl->state
> to avoid any races. If you don't want to call nvme_identify_ctrl with
> the lock held, then it would probably be better to move the state check
> below it.

Meant before the return statement.

> 
>>>  ? @@ -3547,7 +3554,6 @@ static void nvme_scan_work(struct work_struct
>>> *work)
>>>  ????? if (nvme_identify_ctrl(ctrl, &id))
>>>  ????????? return;
>>
>> unlock

Same here.
