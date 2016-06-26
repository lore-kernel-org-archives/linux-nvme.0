From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 26 Jun 2016 18:57:14 +0300
Subject: [PATCH] nvmet-rdma: Invoke fatal error on error completion
In-Reply-To: <20160624071101.GC4252@infradead.org>
References: <1466701290-10356-1-git-send-email-sagi@grimberg.me>
 <20160624071101.GC4252@infradead.org>
Message-ID: <576FFB5A.7070709@grimberg.me>


>> +static void nvmet_rdma_error_comp(struct nvmet_rdma_queue *queue)
>> +{
>> +	if (queue->nvme_sq.ctrl)
>> +		nvmet_ctrl_fatal_error(queue->nvme_sq.ctrl);
>> +	else
>> +		/*
>> +		 * we didn't setup the controller yet in case
>> +		 * of admin connect error, just disconnect and
>> +		 * cleanup the queue
>> +		 */
>> +		nvmet_rdma_queue_disconnect(queue);
>> +}
>
> With such a long comment I'd prefer to have curly braces just to make
> the else visually more obvious

Sure.

>> +
>> +	if (unlikely(wc->status != IB_WC_SUCCESS &&
>> +		wc->status != IB_WC_WR_FLUSH_ERR)) {
>
> Indenting the second line of a condition by a single tab is always wrong,
> either indent it with two tabs, or so that it aligns with first line.
> The second is probably nicer here:
>
> 	if (unlikely(wc->status != IB_WC_SUCCESS &&
> 		     wc->status != IB_WC_WR_FLUSH_ERR)) {

OK, I'll do that.

> Given how many !success not !flush_err conditionals we have in various
> drivers I wonder if we should have a helper in the RDMA core, though.

They don't always come together. But I can take a look at it. Given that
it might bring some slight logic shifts, let's do it incrementally.
