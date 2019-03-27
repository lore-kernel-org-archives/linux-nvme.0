From: james.smart@broadcom.com (James Smart)
Date: Wed, 27 Mar 2019 11:50:00 -0700
Subject: [PATCH 2/3] nvme: shorten race window in nvme_ns_remove()
In-Reply-To: <7c724e84-519e-e0f9-f82d-31a89ec37680@suse.com>
References: <20190327080929.27918-1-hare@suse.de>
 <20190327080929.27918-3-hare@suse.de>
 <20190327142044.GB8448@localhost.localdomain>
 <7c724e84-519e-e0f9-f82d-31a89ec37680@suse.com>
Message-ID: <9500d83c-c5da-d87c-c5ef-d67e2c9f8898@broadcom.com>

On 3/27/2019 8:12 AM, Hannes Reinecke wrote:
> On 3/27/19 3:20 PM, Keith Busch wrote:
>> On Wed, Mar 27, 2019@01:09:28AM -0700, Hannes Reinecke wrote:
>>> @@ -3316,6 +3316,10 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>>> ????? if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
>>> ????????? return;
>>> ? +??? down_write(&ns->ctrl->namespaces_rwsem);
>>> +??? list_del_init(&ns->list);
>>> +??? up_write(&ns->ctrl->namespaces_rwsem);
>>> +
>>> ????? nvme_fault_inject_fini(ns);
>>> ????? if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
>>> ????????? del_gendisk(ns->disk);
>>
>> I think I understand the problem you've described, but I'm a little
>> concerned with the early removal. This will call blk_cleanup_queue
>> after the namespace is removed from our lists, and that does a blocking
>> queue_freeze. If commands happen to be dispatched to that namespace,
>> and the controller for some reason stops responding, we may not be able
>> to recover during reset when the namespace queue is removed from the
>> controller list. That's at least problematic if we have to go with the
>> per-queue tag iterators that Jianchao proposed.
>>
> Hmm. I sort of see where you coming from.
> But I was slightly worried about all the other callers where we iterate
> the namespace list; one would need to to a _really_ careful audit 
> which are safe to traverse even with namespace removal running; some 
> have to, others must not, and some simply don't care.
> Hence this approach to make things easier.

I like and agree with Hannes's later points.

But, Keiths statements make me nervous. With Hannes's patches, I could 
easily see the case where the ns->queue was quiesced when ns_remove is 
called, which I think causes issues with blk_freeze_queue. We would need 
to have ns_remove, after unlinking, to release the queue. is this right ?

-- james
