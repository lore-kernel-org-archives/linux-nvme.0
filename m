From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Mar 2019 14:55:23 +0100
Subject: [PATCH 4/8] nvme/pci: Remove last_cq_seen
In-Reply-To: <77c90843-54c4-2dd6-c4f1-b0ca1ca1c914@grimberg.me>
References: <20190308174313.5134-1-keith.busch@intel.com>
 <20190308174313.5134-4-keith.busch@intel.com> <20190311182825.GD11448@lst.de>
 <77c90843-54c4-2dd6-c4f1-b0ca1ca1c914@grimberg.me>
Message-ID: <20190327135523.GD25849@lst.de>

On Mon, Mar 11, 2019@04:40:03PM -0700, Sagi Grimberg wrote:
>> This looks good, but we can also kill the ret variable now, and
>> simplify the tail a bit to:
>>
>> 	if (start == end)
>> 		return IRQ_NONE;
>> 	nvme_complete_cqes(nvmeq, start, end);
>> 	return IRQ_HANDLED;
>
> Why not just look at what nvme_process_cq is returning?

Yes, that might be even simpler.
