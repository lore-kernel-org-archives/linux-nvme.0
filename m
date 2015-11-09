From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 9 Nov 2015 14:48:31 -0700
Subject: [PATCH 07/12] nvme: special case AEN requests
In-Reply-To: <20151109214038.GE5386@localhost.localdomain>
References: <1446885906-20967-1-git-send-email-hch@lst.de>
 <1446885906-20967-8-git-send-email-hch@lst.de>
 <20151109214038.GE5386@localhost.localdomain>
Message-ID: <564114AF.4010201@kernel.dk>

On 11/09/2015 02:43 PM, Keith Busch wrote:
> On Sat, Nov 07, 2015@09:45:01AM +0100, Christoph Hellwig wrote:
>> +		if (unlikely(nvmeq->qid == 0 &&
>> +				cqe.command_id < NVME_NR_AEN_COMMANDS)) {
>> +			nvme_finish_aen_cmd(nvmeq->dev, &cqe);
>> +			continue;
>
> As long as we're guaranteed the "reserved" tags are the lowest possible
> tag values, this'll work. But that seems more coincidence than by design.

That fact is just implementation detail, I don't think we should make 
assumptions about the range of reserved vs normal tags. That's just 
asking for trouble if this changes at some point.

-- 
Jens Axboe
