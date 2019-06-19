From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 19 Jun 2019 13:04:25 -0700
Subject: [PATCH 2/2] nvme: flush scan_work when resetting controller
In-Reply-To: <d64a5902-139e-4119-ec75-3394e0b129f9@suse.de>
References: <20190618101025.78840-1-hare@suse.de>
 <20190618101025.78840-3-hare@suse.de>
 <36c093c6-9fea-aa2f-affe-70957e0c5b1b@grimberg.me>
 <681a1c11-7d11-6e28-bc64-b14bef22c144@suse.com>
 <fe550375-fc5d-ff19-c303-6671b8713df6@grimberg.me>
 <d64a5902-139e-4119-ec75-3394e0b129f9@suse.de>
Message-ID: <d84bf42f-c9fe-6af4-58cc-14195ddff931@grimberg.me>


>>>>> When resetting the controller there is no point whatsoever to
>>>>> have a scan run in parallel;
>>>>
>>>> There is also no point of trying to prevent it.
>>>>
>>> Oh, I don't mind having a scan running in parallel once reset is
>>> underway; that will be properly short-circuited anyway.
>>> What I object to is having scanning and resetting _starting_ at the same
>>> time, as then we incur all sorts of race conditions.
>>
>> But your patch does not inherently protect against it, these state
>> conditions sprinkled can easily race the reset.
>>
> The reasoning is:
> - (a) I/O is started from the scan thread
> - (b) reset triggers
> - (b) reset abort I/O
> - (a) I/O returns with an error
> - (a) checks the state and skips remaining I/O
> 
>> Note that I do agree with patch #1, but I don't understand how patch
>> #2 is fixing the problem other than narrowing the window at best.
>>
> Only if the state is not propagated to the scan thread.
> My reasoning is that the thread will have a context switch (as it's 
> doing I/O), and hence the state change will be propagated.

Still not guaranteed.


>> Not sure what you mean by stall, are you referring to the case that
>> it takes a long time to reconnect?
>>
> The stall is here (to stick with the above example):
> - (a) scan thread issues I/O
> - (b) reset triggers
> - (b) reset aborts all I/O
> - (a) I/O returns with an error
> - (a) scan thread issues next I/O
> - (b) flushes scan thread

But resets do not flush the scan thread (before your patch). That
is what I'm failing to understand. the scan work is only flushed
in nvme_remove_namespaces().

> - (a) I/O is held by the core as the controller is in reset
> - (b) flush hangs
> 
>> The solution is to make sure we drain the inflight I/O, not half-way
>> trying to prevent them from happening.
>>
> See above. Ths problem is that we're draining I/O only once, but the 
> scan thread is issuing _several_ I/O, of which only _one_ will be aborted.

But with your patch #1 it will bail if it failed and the state was 
propagated.

>>> Problem here is that I/O will be held during reset, and
>>> resubmitted once reset is finished.
>>>
>>> The transport drivers work around this problem to terminate any I/O
>>> prior to resetting the controller,
>>
>> Its not a work around.
>>
> See above. Not a workaound, but not sufficient to let the scan thread 
> making progress, either.
> 
>>> but this will only cover I/O which
>>> had been pending _before_ reset was called.
>>> Any I/O being started after that will still be held, and we would
>>> live-lock trying to flush the scan thread.
>>
>> But resets do not flush the scan thread (before you restored it).
>>
> Yes. But the scan thread will tear down namespaces when running in 
> parallel with resets, and then we're running into a race condition.

But where is the "hang" you are referring to which flushes the scan
thread?

>> But again, I want to understand after patch #1 is applied, what are the
>> symptoms and why patch #2 is solving them.

Can we take a step back here? I think we are mixing two different issues
here. in your trace you refer to a use-after-free panic when this
patch is trying to solve a "hang" condition.

Can we understand what is the phenomenon after patch #1 is applied?

>>> static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>>> {
>>> ????struct nvme_ns *ns;
>>>
>>> ????ns = nvme_find_get_ns(ctrl, nsid);
>>> ????if (ns) {
>>> ??????? if (ns->disk && revalidate_disk(ns->disk))
>>> ??????????? nvme_ns_remove(ns);
>>> ??????? nvme_put_ns(ns);
>>> ????} else
>>> ??????? nvme_alloc_ns(ctrl, nsid);
>>> }
>>>
>>
>> Which is what patch #1 is for right?
>>
> That's what I thought initially, too, but it turned out to be not 
> sufficient.

Not sufficient because it hangs? or panics?

>> We can have an incremental patch that moves the ns removal from
>> ctrl->namespaces also before.
>>
> Again, I'm not sure if that's sufficient.

[...]

> Ultimately, it's the imbalance in nvme_ns_remove() which is causing this 
> crash.
> nvme_ns_remove() will call blk_cleanup_queue() _before_ removing the 
> namespace from the list.

This is what I suggest as an incremental change to the patch I
referenced. blk_cleanup_queue() is called after the ns is removed
from the list.

> which means that any call to nvme_stop_queues() or nvme_start_queues() 
> happening between blk_cleanup_queue() and list_del() will be hitting 
> this issue.

This is the use-after-free again right?

> And without an explicit flush of the scan thread we cannot avoid this.
> Leaving us with the choice of either rebalance nvme_ns_remove() (which 
> is what the patchset from Ming Lei tried to do) or we flush the scan 
> thread, which is what I have been doing.

You may be right, I just need a little help getting there as so far I'm
not convinced that there is no other way. I'm also not 100% clear
on what is the phenomenon after patch #1 is applied, is it a crash or
a hang?
