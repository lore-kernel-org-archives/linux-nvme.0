From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 19 Nov 2018 08:20:22 -0700
Subject: [PATCH 4/7] blk-mq: when polling for IO, look for any completion
In-Reply-To: <20181119080233.GD9622@infradead.org>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-5-axboe@kernel.dk> <20181119080233.GD9622@infradead.org>
Message-ID: <ea9ac6ae-32ab-0fa9-5208-4f4689bf84f2@kernel.dk>

On 11/19/18 1:02 AM, Christoph Hellwig wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 52b1c97cd7c6..3ca00d712158 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -3266,9 +3266,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
>>  	 *  0:	use half of prev avg
>>  	 * >0:	use this specific value
>>  	 */
>> -	if (q->poll_nsec == -1)
>> -		return false;
>> -	else if (q->poll_nsec > 0)
>> +	if (q->poll_nsec > 0)
>>  		nsecs = q->poll_nsec;
>>  	else
>>  		nsecs = blk_mq_poll_nsecs(q, hctx, rq);
> 
> The above comment now doesn't match the code here as the -1 case
> is handled elsewhere.

Good point, I'll fix the comment.

>> +static int __blk_mq_poll(struct blk_mq_hw_ctx *hctx)
>>  {
>>  	struct request_queue *q = hctx->queue;
>>  	long state;
> 
> Can you merge __blk_mq_poll into blk_mq_poll now that blk_mq_poll
> is pretty trivial?
> 
>>  static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
>>  {
>> -	__nvme_rdma_recv_done(cq, wc, -1);
>> +	__nvme_rdma_recv_done(cq, wc);
>>  }
> 
> __nvme_rdma_recv_done and nvme_rdma_recv_done can be merged now.

I'll fold them.

>>  static int nvme_rdma_conn_established(struct nvme_rdma_queue *queue)
>> @@ -1758,10 +1752,12 @@ static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx, unsigned int tag)
>>  		struct ib_cqe *cqe = wc.wr_cqe;
>>  
>>  		if (cqe) {
>> -			if (cqe->done == nvme_rdma_recv_done)
>> -				found |= __nvme_rdma_recv_done(cq, &wc, tag);
>> -			else
>> +			if (cqe->done == nvme_rdma_recv_done) {
>> +				__nvme_rdma_recv_done(cq, &wc);
>> +				found++;
>> +			} else {
>>  				cqe->done(cq, &wc);
>> +			}
> 
> And we should probably look into separate poll queues for RDMA as well
> while we're at it.

I'll leave that as an exercise for someone else :-)

-- 
Jens Axboe
