From: axboe@fb.com (Jens Axboe)
Date: Mon, 5 Jan 2015 13:20:47 -0700
Subject: [PATCH 0/4] nvme-blkmq fixes
In-Reply-To: <alpine.LNX.2.00.1501051932340.4026@localhost.lm.intel.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
 <5495B2BF.8070602@fb.com> <5495CDFE.3060404@fb.com>
 <alpine.LNX.2.00.1412221543240.4026@localhost.lm.intel.com>
 <54984B10.6060907@fb.com>
 <alpine.LNX.2.00.1412221807560.4026@localhost.lm.intel.com>
 <549860A9.7060106@fb.com> <54987A43.9000807@fb.com>
 <alpine.LNX.2.00.1412222053120.4026@localhost.lm.intel.com>
 <alpine.LNX.2.00.1412222303100.4026@localhost.lm.intel.com>
 <5499AB17.6060805@fb.com> <5499AC69.2010706@fb.com>
 <alpine.LNX.2.00.1412232024530.4026@localhost.lm.intel.com>
 <alpine.LNX.2.00.1412232120410.4026@localhost.lm.intel.com>
 <5499DD9B.4020508@fb.com>
 <alpine.LNX.2.00.1412310215470.4026@localhost.lm.intel.com>
 <54A4268A.6030504@fb.com>
 <alpine.LNX.2.00.1501051451440.4026@localhost.lm.intel.com>
 <54AAE672.7020503@fb.com>
 <alpine.LNX.2.00.1501051932340.4026@localhost.lm.intel.com>
Message-ID: <54AAF21F.3080907@fb.com>

On 01/05/2015 01:19 PM, Keith Busch wrote:
> On Mon, 5 Jan 2015, Jens Axboe wrote:
>> On 01/05/2015 08:17 AM, Keith Busch wrote:
>>> On Wed, 31 Dec 2014, Jens Axboe wrote:
>>> We need the driver to temporarily block tasks allocating new requests
>>> but
>>> let existing requests requeue. Freeze looked good, but unfreeze expects
>>> the usage count to have been 0, which it's not guaranteed with when we
>>> let failed requests requeue.
>>
>> OK, I think that is a concern we can fix. And yes, that was the intended
>> use case for it originally.
>>
> 
> Okay cool, that would help a lot.
> 
>>> We also need the driver to temporarily prevent the block layer from
>>> submitting requests to the driver's hw queues. 'blk_mq_stop_hw_queues'
>>> looked right, but anyone can restart them at the wrong time by kicking
>>> the requeue list.
>>
>> The driver is the only one that should kick the requeue action into
>> gear, which would start those queues up again. So that should be under
>> your control already.
> 
> Right, we can stop the driver from kicking if it knows a device reset
> is occuring, but there can't be any requeue work prior to stopping all
> h/w queues to prevent a race condition. We could have the driver's reset
> handler call 'cancel_work_sync(q->requeue_work)' to address that. There's
> no existing driver using q->reset_work, but it looks safe to treat
> as public.

Assuming you meant q->requeue_work here. I'd just add that to an
exported function for that functionality, don't muck with it directly in
case we want to change it later for some reason.

-- 
Jens Axboe
