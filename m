From: damien.lemoal@wdc.com (Damien Le Moal)
Date: Tue, 25 Apr 2017 13:43:20 +0900
Subject: [PATCH] nvme/scsi: Consider LBA format in IO splitting calculation
In-Reply-To: <9a84df91-509d-1c1f-8653-849e42a50b6a@kernel.dk>
References: <20170425000243.2019-1-jonathan.derrick@intel.com>
 <20170425040025.GA23572@kernel.dk>
 <267a4710-3a71-c08c-8e03-19bd2e73d056@wdc.com>
 <9a84df91-509d-1c1f-8653-849e42a50b6a@kernel.dk>
Message-ID: <5159e2b1-d9cf-b76b-7000-d0b7c3c0d975@wdc.com>

Jens,

On 4/25/17 13:32, Jens Axboe wrote:
>> I just realized that this macro is defined in linux/device-mapper.h,
>> which does not seem like to best place to have it. Why not blkdev.h ?
>> Any particular reason ? This leads to some strange include dependencies,
>> like many nfs/blocklayout/ files including device-mapper.h just to get
>> that definition.
> 
> I'm fine with moving it and using it everywhere. Right now we don't in
> the block core at all, 9 is always hard coded. While that change would
> be fine, it should be done independently of this patch, which is a real
> bug fix.

Thank you for the clarification. I will try to send something later.

Best regards.

-- 
Damien Le Moal,
Western Digital
