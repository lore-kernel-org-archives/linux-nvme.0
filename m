From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 21 Jun 2018 09:26:26 -0600
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <20180621152407.GA29947@infradead.org>
References: <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
 <20180620204310.GA24840@localhost.localdomain>
 <34e64832-c345-3a70-401f-1915b5bb4af1@kernel.dk>
 <20180620223035.GA25196@localhost.localdomain>
 <7b6f885f-f605-1bfd-7a7e-2fce8cbde6c2@kernel.dk>
 <20180621071056.GB21304@infradead.org>
 <dc92becd-403d-9c15-e5bb-5e0c3b5d8a8c@kernel.dk>
 <20180621150139.GA22804@infradead.org>
 <cb33de73-6b03-d4a8-ca73-dc094f83f742@kernel.dk>
 <d9fcda4e-9ed2-5001-ef38-61f7c0247cfa@kernel.dk>
 <20180621152407.GA29947@infradead.org>
Message-ID: <25ada552-d5a5-8f4c-a73d-3b23bd4beec1@kernel.dk>

On 6/21/18 9:24 AM, Christoph Hellwig wrote:
> I guess we can live with it for now with a big comment
> 
>>  	ctrl->cntlid = le16_to_cpup(&id->cntlid);
>>  	if (id->mdts)
>>  		max_hw_sectors = 1 << (id->mdts + page_shift - 9);
>> -	else
>> +	else if (ctrl->ops->flags & NVME_F_FABRICS)
>>  		max_hw_sectors = UINT_MAX;
>> +	else
>> +		max_hw_sectors = NVME_MAX_KB_SZ << 1;
> 
> Can this I think is better done by setting ctrl->max_hw_sectors
> in the PCIe driver (similar to what the other drivers already do)
> and then rely on the min_not_zero below to factor in MDTS.

Yeah, I can put it there, and we can get rid of the check here.
Maybe do the same for segments, adding a ctrl->max_segments.
If non-zero, use that in init_ctrl().

>> +/*
>> + * These can be higher, but we need to ensure that any command doesn't
>> + * require an sg allocation that needs more than a page of data.
>> + */
>> +#define NVME_MAX_KB_SZ	4096
> 
> I think this should move the pci.c

With the above change it can.

>> +#define NVME_MAX_SEGS	127
> 
> And this could use a good explanation.  Especially as I think
> that we shouldn't apply the limit for fabrics.  So instead we
> might just add a new ctrl->max_segments field, which PCI sets,
> and which then is min() with the otherwise calculated value.

I'll add that.

-- 
Jens Axboe
