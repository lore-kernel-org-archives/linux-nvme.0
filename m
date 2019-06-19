From: hare@suse.de (Hannes Reinecke)
Date: Wed, 19 Jun 2019 20:45:42 +0200
Subject: [PATCH 2/2] nvme: flush scan_work when resetting controller
In-Reply-To: <fe550375-fc5d-ff19-c303-6671b8713df6@grimberg.me>
References: <20190618101025.78840-1-hare@suse.de>
 <20190618101025.78840-3-hare@suse.de>
 <36c093c6-9fea-aa2f-affe-70957e0c5b1b@grimberg.me>
 <681a1c11-7d11-6e28-bc64-b14bef22c144@suse.com>
 <fe550375-fc5d-ff19-c303-6671b8713df6@grimberg.me>
Message-ID: <d64a5902-139e-4119-ec75-3394e0b129f9@suse.de>

On 6/19/19 6:56 PM, Sagi Grimberg wrote:
> 
>>>> When resetting the controller there is no point whatsoever to
>>>> have a scan run in parallel;
>>>
>>> There is also no point of trying to prevent it.
>>>
>> Oh, I don't mind having a scan running in parallel once reset is
>> underway; that will be properly short-circuited anyway.
>> What I object to is having scanning and resetting _starting_ at the same
>> time, as then we incur all sorts of race conditions.
> 
> But your patch does not inherently protect against it, these state
> conditions sprinkled can easily race the reset.
> 
The reasoning is:
- (a) I/O is started from the scan thread
- (b) reset triggers
- (b) reset abort I/O
- (a) I/O returns with an error
- (a) checks the state and skips remaining I/O

> Note that I do agree with patch #1, but I don't understand how patch
> #2 is fixing the problem other than narrowing the window at best.
> 
Only if the state is not propagated to the scan thread.
My reasoning is that the thread will have a context switch (as it's 
doing I/O), and hence the state change will be propagated.

>>
>> Like this one :-)
>>
>>>> we cannot access the controller and
>>>> we cannot tell which devices are present and which not.
>>>> Additionally we'll run a scan after reset anyway.
>>>> So flush existing scans before reconnecting, ensuring to
>>>> short-circuit the scan workqueue function if the controller state
>>>> isn't live to avoid lockups.
>>>
>>> What is this fixing? can we get a detailed description?
>>>
>>> These ctrl->state conditions sprayed around that are not barriered
>>> by anything do not prevent any scan to run in parallel with resets.
>>>
>> The 'ctrl->state' conditions are required to avoid I/O to be stalled
>> during reset.
> 
> Not sure what you mean by stall, are you referring to the case that
> it takes a long time to reconnect?
> 
The stall is here (to stick with the above example):
- (a) scan thread issues I/O
- (b) reset triggers
- (b) reset aborts all I/O
- (a) I/O returns with an error
- (a) scan thread issues next I/O
- (b) flushes scan thread
- (a) I/O is held by the core as the controller is in reset
- (b) flush hangs

> The solution is to make sure we drain the inflight I/O, not half-way
> trying to prevent them from happening.
> 
See above. Ths problem is that we're draining I/O only once, but the 
scan thread is issuing _several_ I/O, of which only _one_ will be aborted.

>> Problem here is that I/O will be held during reset, and
>> resubmitted once reset is finished.
>>
>> The transport drivers work around this problem to terminate any I/O
>> prior to resetting the controller,
> 
> Its not a work around.
> 
See above. Not a workaound, but not sufficient to let the scan thread 
making progress, either.

>> but this will only cover I/O which
>> had been pending _before_ reset was called.
>> Any I/O being started after that will still be held, and we would
>> live-lock trying to flush the scan thread.
> 
> But resets do not flush the scan thread (before you restored it).
> 
Yes. But the scan thread will tear down namespaces when running in 
parallel with resets, and then we're running into a race condition.

>> So essentially we guard any I/O with the state check, and short circuit
>> it if we find ourselves in reset.
> 
> As I mentioned, patch #1 is fine. Please explain what patch #2 is
> exactly fixing.
> 
Yes, I'm trying to :-)

>> There is no need to protect the state check, as we will be aborting I/O
>> when a state change to 'RESETTING' happens, and the update should be
>> visible to all threads after that.
> 
> I think this assumption is incorrect. Nothing guarantees when/who will
> have visibility to the state change.
> 
Which actually might be true, but we haven't seen the original issue 
anymore after these patches. So at the very least the race window 
becomes really small :-)

>> If you want I can separate this into two patches, one with flushing the
>> scan function and one with the state check guards, and detail out the
>> reasoning here.
> 
> No need to split, if its needed, it needs to be in a single patch.
> But again, I want to understand after patch #1 is applied, what are the
> symptoms and why patch #2 is solving them.
> 
>>> Also, do note that resets will unquiesce the admin queue right away
>>> and not when the reset completes (rdma, tcp, fc). The only exception
>>> is pci that will unquiesce as soon as the reset fails.
>>>
>>> So can you please clarify the problem?
>>>
>> Sure. During failover testing NetApp had been seeing several crashes 
>> like:
>>
[ .. ]
>> when scanning is active during reset all namespaces are found to be
>> unresponsive, and will be consequently removed:
>>
>> static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>> {
>> ????struct nvme_ns *ns;
>>
>> ????ns = nvme_find_get_ns(ctrl, nsid);
>> ????if (ns) {
>> ??????? if (ns->disk && revalidate_disk(ns->disk))
>> ??????????? nvme_ns_remove(ns);
>> ??????? nvme_put_ns(ns);
>> ????} else
>> ??????? nvme_alloc_ns(ctrl, nsid);
>> }
>>
> 
> Which is what patch #1 is for right?
> 
That's what I thought initially, too, but it turned out to be not 
sufficient.

>> However, as the controller is resetting it will call
>> nvme_stop_queues() at the start of the reset, and nvme_start_queues()
>> once reset is complete.
>>
>> Both iterate the namespace list like
>>
>> void nvme_stop_queues(struct nvme_ctrl *ctrl)
>> {
>> ????struct nvme_ns *ns;
>>
>> ????down_read(&ctrl->namespaces_rwsem);
>> ????list_for_each_entry(ns, &ctrl->namespaces, list)
>> ??????? blk_mq_quiesce_queue(ns->queue);
>> ????up_read(&ctrl->namespaces_rwsem);
>> }
>>
>> but this will only synchronize with the very last step of 
>> nvme_ns_remove().
>> At that time blk_cleanup_queue() already had been called, and
>> consequently we crash in 'blk_mq_quiesce_queue()' (or
>> 'blk_mq_unquiesce_queue()', depending on the timing).
> 
> I sent a patch that moves the rcu sync.
> Please see:
> [PATCH] nvme: fix possible io failures when removing multipathed ns
> 
> We can have an incremental patch that moves the ns removal from
> ctrl->namespaces also before.
> 
Again, I'm not sure if that's sufficient.
>>
>> This imbalance in nvme_ns_remove() is one issue which Ming Lei tried to
>> fix up with his patchset 'blk-mq: fix races related with freezing queue'.
>> However, he dropped the final patch
>> "nvme: hold request queue's refcount in ns's whole lifetime"
>> on request from hch, as he felt that blk_cleanup_queue() was unsafe in
>> general, and should need to include the final put for the request queue
>> itself.
>> Sadly, this was precisely the patch for fixing this issue :-(
>>
>> So instead of waiting for the big rewrite to happen I tried to approach
>> things from the other end, namely stopping the race to happen in the
>> first place.
>>
>> And with these two patches the crashes are gone, so I thought to share
>> it here if there were interest.
> 
> There is interest in fixing the crash, no doubt. But I just want to
> understand if this is the correct fix.

Ultimately, it's the imbalance in nvme_ns_remove() which is causing this 
crash.
nvme_ns_remove() will call blk_cleanup_queue() _before_ removing the 
namespace from the list.
which means that any call to nvme_stop_queues() or nvme_start_queues() 
happening between blk_cleanup_queue() and list_del() will be hitting 
this issue.
And without an explicit flush of the scan thread we cannot avoid this.
Leaving us with the choice of either rebalance nvme_ns_remove() (which 
is what the patchset from Ming Lei tried to do) or we flush the scan 
thread, which is what I have been doing.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
