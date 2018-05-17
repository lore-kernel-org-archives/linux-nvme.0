From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 May 2018 00:16:03 -0700
Subject: nvme: batch completions and do them outside of the queue lock
In-Reply-To: <909fe3ae-fe5a-fce6-20ea-a7f440799a06@kernel.dk>
References: <528cf765-16ae-5499-8843-9a62b4fd8326@kernel.dk>
 <20180516212757.GD20223@localhost.localdomain>
 <20180516223538.GE20223@localhost.localdomain>
 <5e2e6da5-70ca-5b32-d02a-04baf2df1e9a@kernel.dk>
 <da3e364d-fd99-b2e0-4710-03c2b90ea1b2@kernel.dk>
 <06c7d9f3-f936-cead-6f6a-9ebae47c31c4@kernel.dk>
 <909fe3ae-fe5a-fce6-20ea-a7f440799a06@kernel.dk>
Message-ID: <20180517071603.GB30079@infradead.org>

>  static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
> -		struct nvme_completion *cqe)
> +				   volatile struct nvme_completion *cqe)

Skip the bogus reindentation here :)

>  {
>  	struct request *req;
>  
> @@ -950,21 +949,17 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
>  	if (unlikely(nvmeq->qid == 0 &&
>  			cqe->command_id >= NVME_AQ_BLK_MQ_DEPTH)) {
>  		nvme_complete_async_event(&nvmeq->dev->ctrl,
> -				cqe->status, &cqe->result);
> +				cqe->status, (union nvme_result *) &cqe->result);

Please find a way to avoid that cast.  Either always make it volatile
or pass by value if modern complilers have stopped generating shit code
for passing unions by value.

> -static inline bool nvme_read_cqe(struct nvme_queue *nvmeq,
> -		struct nvme_completion *cqe)
> +static inline bool nvme_read_cqe(struct nvme_queue *nvmeq)
>  {
>  	if (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
> -		*cqe = nvmeq->cqes[nvmeq->cq_head];
> -

Without actually reading the CQE this function is now grossly misnamed.
What about nvme_consume_cqe or something like that instead?

> +static inline void nvme_process_cq(struct nvme_queue *nvmeq, u16 *start,
> +				   u16 *end)
>  {
> +	*start = nvmeq->cq_head;
> +	while (nvme_read_cqe(nvmeq))
> +		;
> +	*end = nvmeq->cq_head;
> +
> +	if (*start != *end)
> +		nvme_ring_cq_doorbell(nvmeq);
> +}

Or in fact just kill off nvme_read_cqe, as that appears to be the only
callers with your patch (just reading the patch so I might be wrong).

The this could become:

	*start = nvmeq->cq_head;
	while (nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase)) {
		if (++nvmeq->cq_head == nvmeq->q_depth) {
			nvmeq->cq_head = 0;
			nvmeq->cq_phase = !nvmeq->cq_phase;
		}
	}
	*end = nvmeq->cq_head;

	if (*start != *end)
		nvme_ring_cq_doorbell(nvmeq);
}

which starts to make a lot more sense.

> +static bool nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end,
> +			       unsigned int tag)
> +{
> +	bool found = false;
> +
> +	if (start == end)
> +		return false;
> +
> +	while (start != end) {
> +		volatile struct nvme_completion *cqe = &nvmeq->cqes[start];
> +
> +		if (!found && tag == cqe->command_id)
> +			found = true;
> +		nvme_handle_cqe(nvmeq, cqe);
> +		if (++start == nvmeq->q_depth)
> +			start = 0;
>  	}
>  
> +	return found;

I don't think we need the if (start == end) check, the while loop already
handles that.  I also wonder if we should move the tag matching into
nvme_handle_cqe.  It already looks at cqe->command_id, so that would keep
the access together, and would remove the need to even look at the CQE at
all in this function.  And nvme_complete_cqes would be so trivial now that
we can still keep the poll optimization.

Irq/delete queue path, including handling the irqreturn_t value:

static irqreturn_t nvme_complete_cqes(struct nvme_queue *nvmeq,
		u16 start, u16 end)
{
	irqreturn_t ret = IRQ_NONE;

	while (start != end) {
		nvme_handle_cqe(nvmeq, cqe, -1);
		if (++start == nvmeq->q_depth)
			start = 0;
		ret = IRQ_HANDLED;
 	}

	return ret;
}

poll path:

static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
{
	struct nvme_completion cqe;
	u16 start, end;

 	if (!nvme_cqe_valid(nvmeq, nvmeq->cq_head, nvmeq->cq_phase))
 		return 0;

 	spin_lock_irq(&nvmeq->q_lock);
	nvme_process_cq(nvmeq, &start, &end);
	spin_unlock(&nvmeq->q_lock);

	while (start != end) {
		if (nvme_handle_cqe(nvmeq, cqe, tag))
			return 1;
		if (++start == nvmeq->q_depth)
			start = 0;
 	}

	return 0;
}

that would also keep the early exit behavior for poll once we found
the tag.

> @@ -2006,8 +2016,9 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
>  		 */
>  		spin_lock_irqsave_nested(&nvmeq->q_lock, flags,
>  					SINGLE_DEPTH_NESTING);
> -		nvme_process_cq(nvmeq);
> +		nvme_process_cq(nvmeq, &start, &end);
>  		spin_unlock_irqrestore(&nvmeq->q_lock, flags);
> +		nvme_complete_cqes(nvmeq, start, end, -1U);

If we could somehow move this into a workqueue we could even move the
locking into nvme_process_cq, but that's something left for another time.
