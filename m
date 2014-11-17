From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 17 Nov 2014 12:55:22 -0700
Subject: [PATCH] NVMe: Defer namespace add_disk() until after char device
 creation
In-Reply-To: <alpine.LNX.2.00.1411171511010.4225@localhost.lm.intel.com>
References: <54596CBE.5070501@micron.com> <5466DA27.6000707@kernel.dk>
 <alpine.LNX.2.00.1411171511010.4225@localhost.lm.intel.com>
Message-ID: <546A52AA.3040601@kernel.dk>

On 11/17/2014 08:19 AM, Keith Busch wrote:
> On Fri, 14 Nov 2014, Jens Axboe wrote:
>> On 2014-11-04 17:18, Sam Bradshaw wrote:
>>> In the current probe flow, each namespace gets an add_disk() then the
>>> char device for the controller is registered.  For misbehaving devices
>>> or namespace(s) that are not yet ready when add_disk() is called (eg.
>>> namespace accesses that return NVME_SC_NS_NOT_READY and are requeued),
>>> it can take time to disposition all the accesses.
>>>
>>> This change moves add_disk() after the char device is created to give
>>> manageability stacks an interface to query as IO flushes out.
>>>
>>> (I also considered deferring the nvme_ns_add() to an async context but
>>> that requires some sort of mutex between probe and remove to handle the
>>> surprise remove during add_disk condition and was messier than this
>>> patch)
>>
>> I'd love to see this get added. You need the control char dev to fixup
>> such bad situations, and it may never get created if we get stuck on
>> trying to setup and probe the block parts.
>
> Would it be much trouble to make "add_disk" non-blocking? If it's not
> too bad, then all storage drivers might benefit from that and we don't
> have to do things like this in a driver. I haven't really looked into it,
> so asking out of curiosity and not a serious suggestion yet.

It would certainly be possible, and could potentially speedup device 
probing and creation if lots of devices are present. It's also one of 
those things where the devil is in the details, on ensuring we don't 
introduce removal races and userspace issues. See the mess on the SCSI 
async scanning, for instance...

For now, I'd prefer if we just created the char device first, it's the 
sensible thing to do imho. Making add_disk async is definitely doable, 
and I would not mind doing it, it's just a lot more work.

-- 
Jens Axboe
