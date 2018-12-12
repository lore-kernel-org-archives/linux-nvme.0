From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 12 Dec 2018 10:23:12 -0800
Subject: [PATCH RFC 0/4] restore polling to nvme-rdma
In-Reply-To: <20181212140518.GA4527@lst.de>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181212070756.GC28461@lst.de>
 <937fc9db-1248-fcad-1b59-627c4b44ef16@grimberg.me>
 <20181212080945.GA29679@lst.de>
 <5f34c9df-b0be-102a-eabe-7b4613b0c9c0@grimberg.me>
 <20181212140518.GA4527@lst.de>
Message-ID: <1abe2fa0-e05a-e8a7-47e6-6e37b4d8011e@grimberg.me>


>>> Well, it should just be a little blk_poll loop, right?
>>
>> Not so much about the poll loop, but the fact that we will need
>> to check if we need to poll for this special case every time in
>> .queue_rq and its somewhat annoying...
> 
> I don't think we need to add any special check in queue_rq.  Any
> polled command should be marked as HIPRI from the submitting code,
> and that includes the queue creation.

Hmm, good idea, perhaps adding something like to following:
--
/**
  * blk_execute_rq_polled - execute a request and poll for its completion
  * @q:          queue to insert the request in
  * @bd_disk:    matching gendisk
  * @rq:         request to insert
  * @at_head:    insert request at head or tail of queue
  *
  * Description:
  *    Insert a fully prepared request at the back of the I/O scheduler
  *    queue for execution and poll for completion.
  */
void blk_execute_rq_polled(struct request_queue *q, struct gendisk *bd_disk,
                    struct request *rq, int at_head)
{
         DECLARE_COMPLETION_ONSTACK(wait);
         unsigned long hang_check;

	rq->cmd_flags |= REQ_HIPRI;
         rq->end_io_data = &wait;
         blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end_sync_rq);

         while (!completion_done(&wait))
		blk_poll(q, 0, true);
}
EXPORT_SYMBOL(blk_execute_rq_polled);
--

and __nvme_submit_sync_cmd() can receive a poll argument as well to call
blk_execute_req_polled()?
