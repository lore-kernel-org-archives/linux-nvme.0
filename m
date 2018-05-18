From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 18 May 2018 14:48:59 -0600
Subject: [PATCH 2/7] nvme-pci: simplify nvme_cqe_valid
In-Reply-To: <20180518204947.GC27795@localhost.localdomain>
References: <1526655155-4006-1-git-send-email-axboe@kernel.dk>
 <1526655155-4006-3-git-send-email-axboe@kernel.dk>
 <20180518204947.GC27795@localhost.localdomain>
Message-ID: <e7a11f2c-99be-a8b7-2729-64afdf2bd42f@kernel.dk>

On 5/18/18 2:49 PM, Keith Busch wrote:
> On Fri, May 18, 2018@08:52:30AM -0600, Jens Axboe wrote:
>> +static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
>>  {
>> -	return (le16_to_cpu(nvmeq->cqes[head].status) & 1) == phase;
>> +	return (le16_to_cpu(nvmeq->cqes[nvmeq->cq_head].status) & 1) ==
>> +			nvmeq->cq_phase;
>>  }
> 
> What happened to the byte-swap micro-optimization?

sparse complained (see older thread), so I folded that optimization
away with an incremental from Christoph. Honestly, we should probably
have called that a nano optimization anyway, and one that does
nothing on little endian anyway (nothing else matters, so... :))

-- 
Jens Axboe
