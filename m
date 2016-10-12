From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 12 Oct 2016 02:24:11 -0700
Subject: [PATCH 5/7 v2] nvme-fabrics: Add host FC transport support
In-Reply-To: <57f82b12.se5DjK6l/GWAoAxA%james.smart@broadcom.com>
References: <57f82b12.se5DjK6l/GWAoAxA%james.smart@broadcom.com>
Message-ID: <20161012092411.GF12972@infradead.org>

> +	  To configure a NVMe over Fabrics controller use the nvme-cli tool
> +	  from https://github.com/linux-nvme/nvme-cli.

Talking about nvme-cli, can you post the FC support patches for that
as well?

> +#define NVME_FC_NR_AEN_COMMANDS	1
> +#define NVME_FC_AQ_BLKMQ_DEPTH	\
> +	(NVMF_AQ_DEPTH - NVME_FC_NR_AEN_COMMANDS)
> +#define AEN_CMDID_BASE		(NVME_FC_AQ_BLKMQ_DEPTH + 1)
> +#define IS_AEN_COMMAND(command_id) \
> +	((command_id) >= AEN_CMDID_BASE)

This should be an inline.  But given that it's only used once I'd
actually prefer to just kill the helper and opencode it like in the
other NVMe drivers.

> +enum nvme_fcctrl_state {
> +        FCCTRL_INIT             = 0,
> +	FCCTRL_ACTIVE           = 1,
> +	FCCTRL_DELETING         = 2,
> +	FCCTRL_DELETED          = 3,
> +};

Please integrate the FC controller state with the generic controller
state in core.c


> +static LIST_HEAD(nvme_fc_lport_list);
> +static u32 nvme_fc_local_port_cnt;
> +static u32 nvme_fc_ctrl_cnt;

Any reason not to use the ida allocator for the port number?
a 32-bit integer can actually overflow fairly easily, so having
a proper allocator and reusing ids instead of wrapping around would
seem a lot safer.

> +{
> +	struct nvme_fc_lport *lport = localport_to_lport(portptr);
> +	unsigned long flags;
> +	u32 lnum;
> +
> +	if (!portptr)
> +		return -EINVAL;
> +
> +	lnum = portptr->port_num;
> +
> +	spin_lock_irqsave(&nvme_fc_lock, flags);

Just curious: where and why do you call into the NVMe code
from IRQ conect?

> +	/*
> +	 * If successful and ERSP, use the returned CQE
> +	 *
> +	 * Otherwise, there isn't a CQE or it may not have valid content.
> +	 * FC-NVME will need to fudge one up. We also need to fudge up
> +	 * CQE's for LLDD/transport errors.
> +	 */

So the big question here is why?  So far the model we use in the core
NVMe code is that as long as the lower layer returns a negative Linux
errno the CQE isn't valid, and only if we return a valid NVMe status
we need a CQE.  I suspect if you followed that convention you could
avoid a lot of these synthetic CQE games.

> +			/* passed validation, use the cqe */
> +			/* TODO: fix sqhd - deal with out of order */
> +			queue->sqhd = le16_to_cpu(cqe->sq_head);
> +			queue->seqno = be32_to_cpu(op->rsp_iu.rsn);
> +			goto validation_done;

We don't really care about the sq_head at all in Linux, so I don't
think we need to bother with maintaining the SQ head.

> +static int
> +__nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
> +{
> +	int state;
> +
> +	state = atomic_xchg(&op->state, FCPOP_STATE_ABORTED);
> +	if (state != FCPOP_STATE_ACTIVE) {
> +		atomic_set(&op->state, state);
> +		return 1; /* fail */
> +	}
> +
> +	ctrl->lport->ops->fcp_abort(&ctrl->lport->localport,
> +					&ctrl->rport->remoteport,
> +					op->queue->lldd_handle,
> +					&op->fcp_req);
> +
> +	return 0;

Not complaining about the code, but we really need to figure out how
to fit transport aborts into the NVMe architecture.  We can take this
offline or to the NVMe working group, though.

> +enum blk_eh_timer_return
> +nvme_fc_timeout(struct request *rq, bool reserved)
> +{
> +	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
> +	struct nvme_fc_ctrl *ctrl = op->ctrl;
> +	int ret;
> +
> +	if (reserved)
> +		return BLK_EH_RESET_TIMER;
> +
> +	ret = __nvme_fc_abort_op(ctrl, op);
> +	if (ret)
> +		/* io wasn't active to abort consider it done */
> +		return BLK_EH_HANDLED;
> +
> +	/* fail with DNR on cmd timeout */
> +	rq->errors = NVME_SC_ABORT_REQ | NVME_SC_DNR;
> +
> +	wait_for_completion(&op->abort_done);

The blk timeout handle isn't really supposed to be blocking.  The
idea is to perform the EH action and then complete things in the
completion handler of the abort command.

> +	/* find the host and remote ports to connect together */
> +	spin_lock_irqsave(&nvme_fc_lock, flags);
> +	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
> +		if ((lport->localport.node_name != laddr.nn) ||
> +		    (lport->localport.port_name != laddr.pn))

Nitpick: no need for the inner braces.

> +			if ((rport->remoteport.node_name != raddr.nn) ||
> +			    (rport->remoteport.port_name != raddr.pn))

Same here.

> +				continue;
> +
> +			nvme_fc_rport_get(rport);

nvme_fc_rport_get is a kref_get_unless_zero, so you need to check
the return value.

> +static void __exit nvme_fc_exit_module(void)
> +{
> +	/* sanity check - all lports should be removed */
> +	if (!list_empty(&nvme_fc_lport_list))
> +		pr_warn("%s: localport list not empty\n", __func__);

Nitpick: use WARN_ON?
