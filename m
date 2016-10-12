From: james.smart@broadcom.com (James Smart)
Date: Wed, 12 Oct 2016 12:54:02 -0700
Subject: [PATCH 5/7 v2] nvme-fabrics: Add host FC transport support
In-Reply-To: <20161012092411.GF12972@infradead.org>
References: <57f82b12.se5DjK6l/GWAoAxA%james.smart@broadcom.com>
 <20161012092411.GF12972@infradead.org>
Message-ID: <432f5e3f-46bc-9309-3df8-a8dea043152c@broadcom.com>



On 10/12/2016 2:24 AM, Christoph Hellwig wrote:
>> +	  To configure a NVMe over Fabrics controller use the nvme-cli tool
>> +	  from https://github.com/linux-nvme/nvme-cli.
> Talking about nvme-cli, can you post the FC support patches for that
> as well?

Yes - getting to it. I also need to ensure that we have the udev hooks 
to force auto-connections.

>
>> +#define NVME_FC_NR_AEN_COMMANDS	1
>> +#define NVME_FC_AQ_BLKMQ_DEPTH	\
>> +	(NVMF_AQ_DEPTH - NVME_FC_NR_AEN_COMMANDS)
>> +#define AEN_CMDID_BASE		(NVME_FC_AQ_BLKMQ_DEPTH + 1)
>> +#define IS_AEN_COMMAND(command_id) \
>> +	((command_id) >= AEN_CMDID_BASE)
> This should be an inline.  But given that it's only used once I'd
> actually prefer to just kill the helper and opencode it like in the
> other NVMe drivers.

ok

>
>> +enum nvme_fcctrl_state {
>> +        FCCTRL_INIT             = 0,
>> +	FCCTRL_ACTIVE           = 1,
>> +	FCCTRL_DELETING         = 2,
>> +	FCCTRL_DELETED          = 3,
>> +};
> Please integrate the FC controller state with the generic controller
> state in core.c

I'm not sure about this. I believe there are things about the fc nvme 
ctlr struct, which has to wait on interactions from the FC LLDD before 
it cleans things up - that are not part of the nvme ctrl state.  Thus 
the distinction between DELETING (e.g. stopping, waiting for nvme to 
call us back after it's last put) vs DELETED (we've received NVME's 
callback, so can now act on our own ref counts).

I will look at it again.

I've noticed RDMA and loop cut a lot of corners on teardown of commands, 
etc - as they are mostly memory references with very quick hw context 
teardown that isn't necessarily the case with FC where we have real hw 
contexts in the LLDD and perhaps line traffic. I would assume most of 
the references in the LLDD come back to the blk request thus nvme ctrl, 
so your assumption that they are close in state to each other should be 
true, but I need to review the paths again.

>
>
>> +static LIST_HEAD(nvme_fc_lport_list);
>> +static u32 nvme_fc_local_port_cnt;
>> +static u32 nvme_fc_ctrl_cnt;
> Any reason not to use the ida allocator for the port number?
> a 32-bit integer can actually overflow fairly easily, so having
> a proper allocator and reusing ids instead of wrapping around would
> seem a lot safer.

No reason - just that it didn't seem necessary.  I'll look at ida.

>
>> +{
>> +	struct nvme_fc_lport *lport = localport_to_lport(portptr);
>> +	unsigned long flags;
>> +	u32 lnum;
>> +
>> +	if (!portptr)
>> +		return -EINVAL;
>> +
>> +	lnum = portptr->port_num;
>> +
>> +	spin_lock_irqsave(&nvme_fc_lock, flags);
> Just curious: where and why do you call into the NVMe code
> from IRQ conect?

Well, its not specified in the api. It's up to the context of the LLD 
when it calls the nvmefc_fcp_req->done routine, which is 
nvme_fc_fcpio_done() routine, which you're looking at here. The routine 
does make the blk_mq_complete_request() call without changing context.  
So whether it's true IRQ or not - depends on the driver and whether it 
calls from the real IRQ or from a DPC-like thread.  Any recommendations ?


>
>> +	/*
>> +	 * If successful and ERSP, use the returned CQE
>> +	 *
>> +	 * Otherwise, there isn't a CQE or it may not have valid content.
>> +	 * FC-NVME will need to fudge one up. We also need to fudge up
>> +	 * CQE's for LLDD/transport errors.
>> +	 */
> So the big question here is why?  So far the model we use in the core
> NVMe code is that as long as the lower layer returns a negative Linux
> errno the CQE isn't valid, and only if we return a valid NVMe status
> we need a CQE.  I suspect if you followed that convention you could
> avoid a lot of these synthetic CQE games.

FC-NVME uses existing hw definitions for FCP RSP's which allow a short 
all zeros's response frame to be passed on the wire for good completions 
(lots of specific rules in order to do so).  As such we don't have CQE 
content, so the transport has to create it (SQ ID, SQHD, Command Id, and 
status=0).  So we can't avoid this fudging. NVME fabrics group was well 
aware of this.

As for negative responses from LLDD/transport errors - true, although 
the fudging is minimal. At best there's 1 synthetic CQE game to be avoided.


>
>> +			/* passed validation, use the cqe */
>> +			/* TODO: fix sqhd - deal with out of order */
>> +			queue->sqhd = le16_to_cpu(cqe->sq_head);
>> +			queue->seqno = be32_to_cpu(op->rsp_iu.rsn);
>> +			goto validation_done;
> We don't really care about the sq_head at all in Linux, so I don't
> think we need to bother with maintaining the SQ head.

I know. It doesn't care as it always sizes the SQs to the maximum number 
of outstanding commands possible (io request q tags count). So it 
doesn't care about sqhd pacing vs posting cmds to any queue. But I had 
heard that there was potentially a desire to change that. I would hate 
to have the nvme layer change and not know the transport had to as well.

FC-NVME also has a requirement to deliver ERSP's in order so that SQHD 
goes base in "order". So it's goodness as that linux doesn't care as I 
can ignore this requirement. But, I will at least want a comment in the 
code to state why that functionality isn't present.


>
>> +static int
>> +__nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
>> +{
>> +	int state;
>> +
>> +	state = atomic_xchg(&op->state, FCPOP_STATE_ABORTED);
>> +	if (state != FCPOP_STATE_ACTIVE) {
>> +		atomic_set(&op->state, state);
>> +		return 1; /* fail */
>> +	}
>> +
>> +	ctrl->lport->ops->fcp_abort(&ctrl->lport->localport,
>> +					&ctrl->rport->remoteport,
>> +					op->queue->lldd_handle,
>> +					&op->fcp_req);
>> +
>> +	return 0;
> Not complaining about the code, but we really need to figure out how
> to fit transport aborts into the NVMe architecture.  We can take this
> offline or to the NVMe working group, though.

Agree.  Its a tricky subject as simply changing completion status isn't 
great as the target side may not be aware of that change.


>
>> +enum blk_eh_timer_return
>> +nvme_fc_timeout(struct request *rq, bool reserved)
>> +{
>> +	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
>> +	struct nvme_fc_ctrl *ctrl = op->ctrl;
>> +	int ret;
>> +
>> +	if (reserved)
>> +		return BLK_EH_RESET_TIMER;
>> +
>> +	ret = __nvme_fc_abort_op(ctrl, op);
>> +	if (ret)
>> +		/* io wasn't active to abort consider it done */
>> +		return BLK_EH_HANDLED;
>> +
>> +	/* fail with DNR on cmd timeout */
>> +	rq->errors = NVME_SC_ABORT_REQ | NVME_SC_DNR;
>> +
>> +	wait_for_completion(&op->abort_done);
> The blk timeout handle isn't really supposed to be blocking.  The
> idea is to perform the EH action and then complete things in the
> completion handler of the abort command.

Ok - will address.


>
>> +	/* find the host and remote ports to connect together */
>> +	spin_lock_irqsave(&nvme_fc_lock, flags);
>> +	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
>> +		if ((lport->localport.node_name != laddr.nn) ||
>> +		    (lport->localport.port_name != laddr.pn))
> Nitpick: no need for the inner braces.
>
>> +			if ((rport->remoteport.node_name != raddr.nn) ||
>> +			    (rport->remoteport.port_name != raddr.pn))
> Same here.
>
>> +				continue;
>> +
>> +			nvme_fc_rport_get(rport);
> nvme_fc_rport_get is a kref_get_unless_zero, so you need to check
> the return value.

ok


>
>> +static void __exit nvme_fc_exit_module(void)
>> +{
>> +	/* sanity check - all lports should be removed */
>> +	if (!list_empty(&nvme_fc_lport_list))
>> +		pr_warn("%s: localport list not empty\n", __func__);
> Nitpick: use WARN_ON?

sure.

-- james
