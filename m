From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 2 Dec 2016 09:55:31 +0100
Subject: [PATCH v6 5/7] nvme-fabrics: Add host support for FC transport
In-Reply-To: <584130ba.pS5C8UHrYs5M3Vzp%jsmart2021@gmail.com>
References: <584130ba.pS5C8UHrYs5M3Vzp%jsmart2021@gmail.com>
Message-ID: <20161202085531.nsqx3y5bbcyyhhae@linux-x5ow.site>

On Fri, Dec 02, 2016@12:28:42AM -0800, James Smart wrote:
> 
> Add nvme-fabrics host support for FC transport
> 
> Implements the FC-NVME T11 definition of how nvme fabric capsules are
> performed on an FC fabric. Utilizes a lower-layer API to FC host adapters
> to send/receive FC-4 LS operations and FCP operations that comprise NVME
> over FC operation.
> 
> The T11 definitions for FC-4 Link Services are implemented which create
> NVMeOF connections.  Implements the hooks with blk-mq to then submit admin
> and io requests to the different connections.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> 
> ---

[...]

> +nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
> +{
> +	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
> +	struct request *rq = op->rq;
> +	struct nvmefc_fcp_req *freq = &op->fcp_req;
> +	struct nvme_fc_ctrl *ctrl = op->ctrl;
> +	struct nvme_fc_queue *queue = op->queue;
> +	struct nvme_completion *cqe = &op->rsp_iu.cqe;
> +	u16 status;
> +
> +	/*
> +	 * WARNING:
> +	 * The current linux implementation of a nvme controller
> +	 * allocates a single tag set for all io queues and sizes
> +	 * the io queues to fully hold all possible tags. Thus, the
> +	 * implementation does not reference or care about the sqhd
> +	 * value as it never needs to use the sqhd/sqtail pointers
> +	 * for submission pacing.
> +	 *
> +	 * This affects the FC-NVME implementation in two ways:
> +	 * 1) As the value doesn't matter, we don't need to waste
> +	 *    cycles extracting it from ERSPs and stamping it in the
> +	 *    cases where the transport fabricates CQEs on successful
> +	 *    completions.
> +	 * 2) The FC-NVME implementation requires that delivery of
> +	 *    ERSP completions are to go back to the nvme layer in order
> +	 *    relative to the rsn, such that the sqhd value will always
> +

^^ there's a stray newline, someone should probably fix this up when applying.
> +	 *    be "in order" for the nvme layer. As the nvme layer in
> +	 *    linux doesn't care about sqhd, there's no need to return
> +	 *    them in order.

[...]

> +static void
> +nvme_fc_terminate_exchange(struct request *req, void *data, bool reserved)
> +{
> +	struct nvme_ctrl *nctrl = data;
> +	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
> +	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
> +int status;

^^ This could need a fixup as well.
> +
> +	if (!blk_mq_request_started(req))
> +		return;

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>


Jens, Keith, Sagi, Christoph, how are the chances to get this in for v4.10?
	
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
