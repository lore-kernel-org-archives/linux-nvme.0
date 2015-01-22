From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 22 Jan 2015 15:46:23 -0700
Subject: [patch] NVMe: return an error code if blk_mq_alloc_tag_set() fails
In-Reply-To: <alpine.LNX.2.00.1501221626080.15481@localhost.lm.intel.com>
References: <20150119144327.GE19086@mwanda> <54C07F45.4070406@kernel.dk>
 <alpine.LNX.2.00.1501221626080.15481@localhost.lm.intel.com>
Message-ID: <54C17DBF.40901@kernel.dk>

On 01/22/2015 09:48 AM, Keith Busch wrote:
> On Wed, 21 Jan 2015, Jens Axboe wrote:
>> On 01/19/2015 07:43 AM, Dan Carpenter wrote:
>>> In the current code, if blk_mq_alloc_tag_set() fails then it returns
>>> zero (success) instead of preserving the error code.  The caller is not
>>> expecting that and the kernel could be left in an inconsistent state.
>>>
>>> Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>
>>
>> Looks good to me, Keith, could you ack/review it? Leaving it below...
> 
> Should we bail on the device if tagset allocation fails? If so, the patch
> is good, but I thought it was a concious descision to not return error
> here so the controller can be managed. Capabilities would be limited
> and a failure here probably means there's a bigger problem, so I'm okay
> either way.

That's a good point, you could still send admin IO through the ioctls
even if this fails. Looking at the rest of the function, the error
handling is a bit strange. If we fail the nvme_identify(), we'll just
march on. If the next works, we're good, we return success. But if the
failed one happens to be the last one, we return error.

So we need to clean it up a bit regardless. Question is, what errors
constitute general failure, and which ones we want to allow. If the
rationale is wanting to still access the device and do admin IO, then
none of them should be hard failures. But they should be reported. I can
imagine cases where the device is mostly screwed and you just want to
get the driver loaded successfully to reset/format/fw-update (actually I
don't need to imagine, I've been in those situations!).


-- 
Jens Axboe
