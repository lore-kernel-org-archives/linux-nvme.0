From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 16 May 2018 21:16:42 -0600
Subject: nvme: batch completions and do them outside of the queue lock
In-Reply-To: <20180517020920.GA21959@localhost.localdomain>
References: <528cf765-16ae-5499-8843-9a62b4fd8326@kernel.dk>
 <20180516212757.GD20223@localhost.localdomain>
 <20180516223538.GE20223@localhost.localdomain>
 <5e2e6da5-70ca-5b32-d02a-04baf2df1e9a@kernel.dk>
 <da3e364d-fd99-b2e0-4710-03c2b90ea1b2@kernel.dk>
 <06c7d9f3-f936-cead-6f6a-9ebae47c31c4@kernel.dk>
 <909fe3ae-fe5a-fce6-20ea-a7f440799a06@kernel.dk>
 <20180517020920.GA21959@localhost.localdomain>
Message-ID: <58a9c17a-163a-883a-9b9f-aa81e3091004@kernel.dk>

On 5/16/18 8:09 PM, Keith Busch wrote:
> On Wed, May 16, 2018@05:39:02PM -0600, Jens Axboe wrote:
>>  static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
>>  {
>> -	struct nvme_completion cqe;
>> -	int found = 0, consumed = 0;
>> +	u16 start, end;
>>  
>>  	if (!nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase))
>>  		return 0;
>>  
>>  	spin_lock_irq(&nvmeq->q_lock);
>> -	while (nvme_read_cqe(nvmeq, &cqe)) {
>> -		nvme_handle_cqe(nvmeq, &cqe);
>> -		consumed++;
>> -
>> -		if (tag == cqe.command_id) {
>> -			found = 1;
>> -			break;
>> -		}
>> -       }
>> -
>> -	if (consumed)
>> -		nvme_ring_cq_doorbell(nvmeq);
>> -	spin_unlock_irq(&nvmeq->q_lock);
>> +	nvme_process_cq(nvmeq, &start, &end);
>> +	spin_unlock(&nvmeq->q_lock);
> 
> You'll need to use the spin_unlock_irq() here, otherwise looks good.

Ugh good catch, fixed up. How do you want to proceed?

-- 
Jens Axboe
