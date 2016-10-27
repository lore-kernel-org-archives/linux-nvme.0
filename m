From: james.smart@broadcom.com (James Smart)
Date: Thu, 27 Oct 2016 15:28:14 -0700
Subject: [PATCH v3 5/7] nvme-fabrics: Add host support for FC transport
In-Reply-To: <20161025164706.GE2446@infradead.org>
References: <580d0ffd.cq5y7S+lNBHxNs60%james.smart@broadcom.com>
 <20161025164706.GE2446@infradead.org>
Message-ID: <977d4f55-2332-a368-7f1e-3a229f58e98a@broadcom.com>



On 10/25/2016 9:47 AM, Christoph Hellwig wrote:
>
> I've just send out two patches that get rid of the concept of a CQE
> in the core.  I think all this code would benefit a lot from being
> rebase on top of that.
Ok. Done.  Didn't change things that much. Mainly eliminated some 
memsets/memcpy's. But is better.

>
>> +static void
>> +nvme_fc_kill_request(struct request *req, void *data, bool reserved)
>> +{
>> +	struct nvme_ctrl *nctrl = data;
>> +	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
>> +	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
>> +	int status;
>> +
>> +	if (!blk_mq_request_started(req))
>> +		return;
>> +
>> +	status = __nvme_fc_abort_op(ctrl, op);
>> +	if (status) {
>> +		/* io wasn't active to abort consider it done */
>> +		/* assume completion path already completing in parallel */
>> +		return;
>> +	}
>> +}
> This looks odd - the point of the blk_mq_tagset_busy_iter loops
> is return the in-core request to the caller.  The controller shutdown
> following this would take care of invalidating anything on the wire.
>
> I have to admit that I'm still a bit confused how the FC abort
> fits into the whole NVMe architecture model.

Well, I used blk_mq_tagset_busy_iter a bit differently than I saw it 
used on rdma.

With RDMA, I saw it using the routine to call the core 
nvme_cancel_request, which indeed passed the request back up to the blk 
layer.  It then scheduled the reconnect_ctrl_work routine, which would 
terminate the queues, tearing down the qp's. I assume the teardown of 
the qp's also terminated all the memory regions that may have been 
mapped for ios sent over the qps. I also assume the tgt side, upon the 
qp termination, also tears down and resolves any io state relative to 
the qp, io-related mrs for the qp, etc.   Note: I'm actually surprised. 
I would have assumed it's not good practice to return things to the blk 
layer while there may be things coming off the wire that hit memory 
registrations and perhaps muck with memory. I assume either teardown is 
too quick or they aren't destructive accesses (memory related to the 
request's sgl stays around long enough that the cancelations finish 
before the request releases it, etc).

In FC, the queue is a logical thing, unlike rdma where it maps to the 
qp. At transport connect, the target gives the initiator a handle for 
the queue that the initiator is to pair on any io it sends to the 
target.   When an SQE is sent on a SQ, FC effectively considers the SQE, 
or perhaps better said, the command within the SQE, an "io", and assigns 
a FC exchange to it. The SQE, and the queue handle, get sent in the 
initial CMD IU on the exchange. Everything relative to the io happens 
under the exchange context. The CQE is the last thing for the io, and 
the transport closes the exchange upon the commands-CQE being delivered.

So - if I'm tearing down queues/resetting controllers, not only do I 
send a DISCONNECT LS to kill the validity of the handle, but I also need 
to do something to cancel all those FC exchange contexts that 
corresponded to ios that were outstanding on the queue.

Given those exchange contexts are tied to LLDD contexts that also have 
dma resources mapped to them - it isn't correct for me to just return 
the requests back to the request queue. I want to cancel them in the 
LLDD, stopping any potential dma accessess and giving the resources back 
to the LLDD, then pass the request back to the blk layer.   So, I 
replaced the blk_mq_tagset_busy_iter() with a local routine that kicks 
off the callbacks into the LLDD to cancel the jobs.  From there, the 
LLDD will "finish" the jobs in a normal manner, getting them back to the 
blk layer.

As for aborts relative to individual io timeouts, the "normal thing" we 
did with scsi and other drive protocols, it really doesn't fit and the 
nvme escalation policy of failing the queue or resetting the controller 
should kick in (like on rdma). The FC transport could kill the one I/O, 
but as the SQE and CQEs are part of the io - there's queue-related 
things it messes with when it does so that aren't good. Granted linux 
ignores some of those making it tempting, but I don't want to go there.  
If anything were to be done - it should be something generic: have a 
core layer time out function that then generates an ABORT admin command 
to kill it. And if that fails or timesout, then it resorts to a 
transport controller reset routine.

hope that helps

-- james
