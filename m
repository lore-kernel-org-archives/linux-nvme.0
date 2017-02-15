From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 15 Feb 2017 12:42:02 +0200
Subject: [PATCH 4/4] nvme: support ranged discard requests
In-Reply-To: <20170207193439.GA26834@lst.de>
References: <20170207164658.32449-1-hch@lst.de>
 <20170207164658.32449-5-hch@lst.de>
 <20170207183453.GC10133@localhost.localdomain>
 <20170207193439.GA26834@lst.de>
Message-ID: <ee295e42-4f8b-ebf3-f750-a30e4b69f914@grimberg.me>



On 07/02/17 21:34, Christoph Hellwig wrote:
> On Tue, Feb 07, 2017@01:34:54PM -0500, Keith Busch wrote:
>> On Tue, Feb 07, 2017@05:46:58PM +0100, Christoph Hellwig wrote:
>>> @@ -1233,6 +1243,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>>>  	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
>>>  		vwc = true;
>>>  	blk_queue_write_cache(q, vwc, vwc);
>>> +	blk_queue_max_discard_segments(q,
>>> +			PAGE_SIZE / sizeof(struct nvme_dsm_range));
>>
>> We need to use ctrl->page_size rather than PAGE_SIZE.
>
> We need the PAGE_SIZE upper bound because the "special" bvec only
> allows a single page payload.

Shouldn't this be enforced in blk_queue_max_discard_segments() then?
