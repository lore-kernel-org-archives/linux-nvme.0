From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 27 Jun 2017 17:42:38 -0600
Subject: [PATCH for-4.12] nvme/pci: Fix stuck nvme reset
In-Reply-To: <20170627234019.GA13688@lst.de>
References: <1498607018-1277-1-git-send-email-keith.busch@intel.com>
 <20170627234019.GA13688@lst.de>
Message-ID: <00a82a9c-d8e3-ca4d-b921-23b550e65720@kernel.dk>

On 06/27/2017 05:40 PM, Christoph Hellwig wrote:
> On Tue, Jun 27, 2017@07:43:38PM -0400, Keith Busch wrote:
>> The controller state is set to resetting prior to disabling the
>> controller, so this patch accounts for that state when deciding if it
>> needs to freeze the queues. Without this, an 'nvme reset /dev/nvme0'
>> blocks forever because the queues were never frozen.
> 
> Ouch.
> 
>> -		if (dev->ctrl.state == NVME_CTRL_LIVE)
>> +		if (dev->ctrl.state == NVME_CTRL_LIVE ||
>> +				dev->ctrl.state == NVME_CTRL_RESETTING)
> 
> Can you align this a little nicer:
> 
> 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> 		    dev->ctrl.state == NVME_CTRL_RESETTING)
> 
> Otherwise this looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> 
> Maybe Jens should pick this up directly for the block tree?  No
> point in a nvme pull request just for this.

Looks good to me too. As it so happens, I just hit this today, but didn't
have time to look into why. I'll add it for this series.

-- 
Jens Axboe
