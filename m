From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Jan 2015 23:11:24 +0000 (UTC)
Subject: [patch] NVMe: return an error code if blk_mq_alloc_tag_set() fails
In-Reply-To: <54C17DBF.40901@kernel.dk>
References: <20150119144327.GE19086@mwanda> <54C07F45.4070406@kernel.dk>
 <alpine.LNX.2.00.1501221626080.15481@localhost.lm.intel.com>
 <54C17DBF.40901@kernel.dk>
Message-ID: <alpine.LNX.2.00.1501222252300.15481@localhost.lm.intel.com>

On Thu, 22 Jan 2015, Jens Axboe wrote:
> On 01/22/2015 09:48 AM, Keith Busch wrote:
>> Should we bail on the device if tagset allocation fails? If so, the patch
>> is good, but I thought it was a concious descision to not return error
>> here so the controller can be managed. Capabilities would be limited
>> and a failure here probably means there's a bigger problem, so I'm okay
>> either way.
>
> That's a good point, you could still send admin IO through the ioctls
> even if this fails. Looking at the rest of the function, the error
> handling is a bit strange. If we fail the nvme_identify(), we'll just
> march on. If the next works, we're good, we return success. But if the
> failed one happens to be the last one, we return error.

It's a little simpler than that. The return value is unconditionally
cleared to 0 at the end so we always return success if the first
nvme_identify() was successful. I wouldn't trust a controller that
couldn't identify itself, but the remaining commands are for namespace
identification which can legitimately return errors.
