From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 16 May 2018 17:10:19 -0600
Subject: nvme: batch completions and do them outside of the queue lock
In-Reply-To: <5e2e6da5-70ca-5b32-d02a-04baf2df1e9a@kernel.dk>
References: <528cf765-16ae-5499-8843-9a62b4fd8326@kernel.dk>
 <20180516212757.GD20223@localhost.localdomain>
 <20180516223538.GE20223@localhost.localdomain>
 <5e2e6da5-70ca-5b32-d02a-04baf2df1e9a@kernel.dk>
Message-ID: <da3e364d-fd99-b2e0-4710-03c2b90ea1b2@kernel.dk>

On 5/16/18 4:57 PM, Jens Axboe wrote:
> On 5/16/18 4:35 PM, Keith Busch wrote:
>> On Wed, May 16, 2018@03:27:57PM -0600, Keith Busch wrote:
>>> On Wed, May 16, 2018@02:37:40PM -0600, Jens Axboe wrote:
>>>> This patch splits up the reaping of completion entries, and the
>>>> block side completion. The advantage of this is two-fold:
>>>>
>>>> 1) We can batch completions, this patch pulls them off in units
>>>>    of 8, but that number is fairly arbitrary. I wanted it to be
>>>>    big enough to hold most use cases, but not big enough to be
>>>>    a stack burden.
>>>>
>>>> 2) We complete the block side of things outside of the queue lock.
>>>
>>> Interesting idea. Since you bring this up, I think there may be more
>>> optimizations on top of this concept. I'll stare at this a bit before
>>> applying, or may have a follow-up proposal later.
>>
>> While I'm not seeing a difference, I assume you are. I tried adding on
>> to this proposal by batching *all* completions without using the stack,
>> exploiting the fact we never wrap the queue so it can be accessed
>> lockless after moving the cq_head.
> 
> That looks nifty.
> 
>> +	*start = nvmeq->cq_head;
>> +	while (nvme_read_cqe(nvmeq));
> 
> Probably want to make that
> 
> 	*start = nvmeq->cq_head;
> 	while (nvme_read_cqe(nvmeq))
> 		;
> 
> so it doesn't look like a misplaced ;.
> 
> Apart from that, looks pretty clean to me. Haven't tested it yet.

Below makes it actually compile for me. Ran a quick test, seems slower
than my version in polling, for some reason.


diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index de279ef8c446..ff8d88fd89d7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -929,7 +929,7 @@ static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
 }
 
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
-		struct nvme_completion *cqe)
+				   volatile struct nvme_completion *cqe)
 {
 	struct request *req;
 
@@ -949,7 +949,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 	if (unlikely(nvmeq->qid == 0 &&
 			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH)) {
 		nvme_complete_async_event(&nvmeq->dev->ctrl,
-				cqe->status, &cqe->result);
+				cqe->status, (union nvme_result *) &cqe->result);
 		return;
 	}
 
@@ -1031,10 +1031,10 @@ static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 
 	while (start != end) {
 		nvme_handle_cqe(nvmeq, &nvmeq->cqes[start]);
+		if (tag == nvmeq->cqes[start].command_id)
+			found = 1;
 		if (++start == nvmeq->q_depth)
 			start = 0;
-		if (tag == cqe.command_id)
-			found = 1;
 	}
 	return found;
 }

-- 
Jens Axboe
