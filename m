From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 11 Mar 2019 16:40:03 -0700
Subject: [PATCH 4/8] nvme/pci: Remove last_cq_seen
In-Reply-To: <20190311182825.GD11448@lst.de>
References: <20190308174313.5134-1-keith.busch@intel.com>
 <20190308174313.5134-4-keith.busch@intel.com> <20190311182825.GD11448@lst.de>
Message-ID: <77c90843-54c4-2dd6-c4f1-b0ca1ca1c914@grimberg.me>


>> index 45db4a39795e..62f29ab93f5a 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -193,7 +193,6 @@ struct nvme_queue {
>>   	u16 sq_tail;
>>   	u16 last_sq_tail;
>>   	u16 cq_head;
>> -	u16 last_cq_head;
>>   	u16 qid;
>>   	u8 cq_phase;
>>   	unsigned long flags;
>> @@ -1044,10 +1043,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
>>   	 * the irq handler, even if that was on another CPU.
>>   	 */
>>   	rmb();
>> -	if (nvmeq->cq_head != nvmeq->last_cq_head)
>> -		ret = IRQ_HANDLED;
>>   	nvme_process_cq(nvmeq, &start, &end);
>> -	nvmeq->last_cq_head = nvmeq->cq_head;
>>   	wmb();
>>   
>>   	if (start != end) {
> 
> This looks good, but we can also kill the ret variable now, and
> simplify the tail a bit to:
> 
> 	if (start == end)
> 		return IRQ_NONE;
> 	nvme_complete_cqes(nvmeq, start, end);
> 	return IRQ_HANDLED;

Why not just look at what nvme_process_cq is returning?
