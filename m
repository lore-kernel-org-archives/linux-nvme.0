From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 22 Oct 2018 17:22:15 -0700
Subject: [PATCH] nvme: make sure ns head inherits underlying device limits
In-Reply-To: <20181022085752.GD18755@lst.de>
References: <20181019222450.25397-1-sagi@grimberg.me>
 <20181022085752.GD18755@lst.de>
Message-ID: <70bcef36-48da-cae7-4e23-ac9b01814a74@grimberg.me>


>> Whenever we update ns_head info, we need to make sure it is still
>> compatible with all underlying backing devices. Start with unlimited
>> stacking limits, and every info update iterate over siblings and
>> adjust queue limits.
> 
> Why?  Neither the block layer, nor the nvme multipath code should
> even look at this values.

Without this patch at least max_segments and max_hw_sectors of the head 
device node are degenerated to defaults that have nothing to do with the
underlying device limits.

This can result in unnecessary bio splitting for the head device
node...

Although I did not check, same holds for discard sectors/segments.

Maybe this is an overkill? but thought this would be a better idea than
simply adjusting limits one-by-one depending on what I find...
