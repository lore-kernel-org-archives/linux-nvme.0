From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 3 Jun 2017 10:25:11 +0300
Subject: [PATCH] nvme_fc: fix confused queue size handling
In-Reply-To: <20170602074810.GC11424@infradead.org>
References: <20170602055351.2750-1-jsmart2021@gmail.com>
 <20170602074810.GC11424@infradead.org>
Message-ID: <c8c5362d-33c2-c117-b082-338e47b7ec86@grimberg.me>


>> -	ctrl->ctrl.sqsize =
>> -		min_t(int, NVME_CAP_MQES(ctrl->cap) + 1, ctrl->ctrl.sqsize);
>> +	if (NVME_CAP_MQES(ctrl->cap) < ctrl->ctrl.sqsize) {
>> +		ctrl->ctrl.sqsize = NVME_CAP_MQES(ctrl->cap);
>> +		opts->queue_size = ctrl->ctrl.sqsize + 1;
>> +	}
> 
> I already asked Sagi when he fixed the previous issues in this
> area, but I guess I need to get more serious about it:
> Please move this to common code instead of having it in the transport
> drivers.

This code was fixed in:
c6c64a942c87 ("nvme-fc: Fix sqsize wrong assignment based on ctrl MQES 
capability") which exists upstream. the weird part is that I can't tell
where this got broken again... I can only assume that somewhere in
the scsi/block multi-way fc merges this got overwritten.
