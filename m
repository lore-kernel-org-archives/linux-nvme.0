From: axboe@fb.com (Jens Axboe)
Date: Tue, 23 Dec 2014 10:54:49 -0700
Subject: [PATCH 0/4] nvme-blkmq fixes
In-Reply-To: <5499AB17.6060805@fb.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
 <5495B2BF.8070602@fb.com> <5495CDFE.3060404@fb.com>
 <alpine.LNX.2.00.1412221543240.4026@localhost.lm.intel.com>
 <54984B10.6060907@fb.com>
 <alpine.LNX.2.00.1412221807560.4026@localhost.lm.intel.com>
 <549860A9.7060106@fb.com> <54987A43.9000807@fb.com>
 <alpine.LNX.2.00.1412222053120.4026@localhost.lm.intel.com>
 <alpine.LNX.2.00.1412222303100.4026@localhost.lm.intel.com>
 <5499AB17.6060805@fb.com>
Message-ID: <5499AC69.2010706@fb.com>

On 12/23/2014 10:49 AM, Jens Axboe wrote:
> On 12/22/2014 06:34 PM, Keith Busch wrote:
>> On Mon, 22 Dec 2014, Keith Busch wrote:
>>> On Mon, 22 Dec 2014, Jens Axboe wrote:
>>>> Should be enough to just check for ->rq_pool being initialized or not
>>>> - if it is, we could have waiters and we know the waitqueues have
>>>> been setup, etc.
>>>>
>>>> V2 attached.
>>>
>>> Yep, that fixes the bug.
>>>
>>> I'm not sure I follow your suggestion for forcing bt_get() to abandon
>>> allocating a request tag when the queue is dying. If hctx_may_queue()
>>> fails, it returns a generic error and bt_get() reschedules itself.
>>> Should
>>> a different error than -1 be returned if the queue is dying?
>>
>> We're making good incremental improvements, but finding oddities the
>> more I test this. This one's a doozy.
>>
>> Requeued IO's are automatically dispatched, and I don't see an
>> immediately
>> available way stop them. It causes a bug because the queue doorbells are
>> unmapped during reset, so you can't touch them when the queue should be
>> quiesced. I could fix that by having the driver not kick the requeue_list
>> when it knows a reset is in progress, but there's no immediate way
>> to drain the list if the reset fails and the device requires removal,
>> and blk_cleanup_queue() will be stuck.
>>
>> Is there something available to call that I'm missing or do I need to
>> add more removal handling?
>
> So that's actually a case where having the queues auto-started on
> requeue run is harmful, since we should be able to handle this situation
> by stopping queues, requeueing, and then having a helper to eventually
> abort pending requeued work, if we have to. But if you simply requeue
> them and defer kicking the requeue list it might work. At that point
> you'd either kick the requeues (and hence start processing them) if
> things went well on the reset, or we could have some
> blk_mq_abort_requeues() helper that'd kill them with -EIO instead. Would
> that work for you?

Something like this.

-- 
Jens Axboe

-------------- next part --------------
A non-text attachment was scrubbed...
Name: blk-mq-abort-requeue-list.patch
Type: text/x-patch
Size: 1461 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20141223/b92098c3/attachment.bin>
