From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 25 Oct 2016 09:47:06 -0700
Subject: [PATCH v3 5/7] nvme-fabrics: Add host support for FC transport
In-Reply-To: <580d0ffd.cq5y7S+lNBHxNs60%james.smart@broadcom.com>
References: <580d0ffd.cq5y7S+lNBHxNs60%james.smart@broadcom.com>
Message-ID: <20161025164706.GE2446@infradead.org>

> +config NVME_FC
> +	tristate "NVM Express over Fabrics FC host driver"
> +	depends on BLOCK
> +	select NVME_CORE
> +	select NVME_FABRICS
> +	select SG_POOL

needs HAS_DMA, but I already saw the patch for that.

> +	/*
> +	 * WARNING:
> +	 * The current linux implementation of a nvme controller
> +	 * allocates a single tag set for all io queues and sizes
> +	 * the io queues to fully hold all possible tags. Thus, the
> +	 * implementation does not reference or care about the sqhd
> +	 * value as it never needs to use the sqhd/sqtail pointers
> +	 * for submission pacing.

I've just send out two patches that get rid of the concept of a CQE
in the core.  I think all this code would benefit a lot from being
rebase on top of that.

> +		if (unlikely(be16_to_cpu(op->rsp_iu.iu_len) !=
> +				(freq->rcv_rsplen/4)) ||
> +		    unlikely(op->rqno != le16_to_cpu(cqe->command_id))) {

nitpick: missing whitespace around the operand, and not needed braces
around the condition.

Also we usually use a single unlikely for the whole condition.

> +static void
> +nvme_fc_kill_request(struct request *req, void *data, bool reserved)
> +{
> +	struct nvme_ctrl *nctrl = data;
> +	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
> +	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
> +	int status;
> +
> +	if (!blk_mq_request_started(req))
> +		return;
> +
> +	status = __nvme_fc_abort_op(ctrl, op);
> +	if (status) {
> +		/* io wasn't active to abort consider it done */
> +		/* assume completion path already completing in parallel */
> +		return;
> +	}
> +}

This looks odd - the point of the blk_mq_tagset_busy_iter loops
is return the in-core request to the caller.  The controller shutdown
following this would take care of invalidating anything on the wire.

I have to admit that I'm still a bit confused how the FC abort
fits into the whole NVMe architecture model.
