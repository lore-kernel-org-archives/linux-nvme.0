From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 4 Oct 2016 11:32:50 +0200
Subject: [PATCH 5/7] nvme-fabrics: Add host FC transport support
In-Reply-To: <57f34bb5.BbLRH5/EeGOE2eLY%james.smart@broadcom.com>
References: <57f34bb5.BbLRH5/EeGOE2eLY%james.smart@broadcom.com>
Message-ID: <20161004093250.cbwab7xm55ka37qz@linux-x5ow.site>

Hi James, 

Some minor nits below in case you'll have to re-send

On Mon, Oct 03, 2016@11:27:01PM -0700, James Smart wrote:
> 
> Add nvme-fabrics host FC transport support
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
> The changes made since the prior patch:
> - Remove todo on Association LS: pull values from opts struct
> - Slight restructure of nvme_fc_create_io_queues() and
>   nvme_fc_init_io_queues() for their return values
> - Checked and corrected BLK_MQ_xx return values in nvme_fc_start_fcp_op()
> - Remove the todo's around dma_map_page(). No need to use dma_map_page()
> - Reworked teardown paths with ref counting
> - Teardown now invokes callbackes on completion of unregister functions
> - set sqid in fcp request structs
> - Add blk poll support.
> - Remove map_queue from templates
> - Removal of fabric name for nport qualifier. Not necessary in T11.
> - LS's moved to controller linked list rather than remoteport
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---

[...]

> +/**
> + * nvme_fc_unregister_localport - transport entry point called by an
> + *                              LLDD to deregister/remove a previously
> + *                              registered a NVME host FC port.
> + * @localport: pointer to the (registered) local port that is to be
> + *             deregistered.
> + *
> + * Returns:
> + * a completion status. Must be 0 upon success; a negative errno
> + * (ex: -ENXIO) upon failure.
> + */
> +int
> +nvme_fc_unregister_localport(struct nvme_fc_local_port *portptr)
> +{
> +	struct nvme_fc_lport *lport =
> +			container_of(portptr, struct nvme_fc_lport, localport);

This below could really benifit from a port_to_lport() and port_to_rport().

Same in:
* nvme_fc_register_remoteport()
* nvme_fc_free_rport()
* nvme_fc_unregister_remoteport()

> +	unsigned long flags;
> +	u32 lnum;
> +
> +	if (!portptr)
> +		return -EINVAL;
> +
> +	lnum = portptr->port_num;
> +
> +	spin_lock_irqsave(&nvme_fc_lock, flags);
> +
> +	if (portptr->port_state != FC_OBJSTATE_ONLINE) {
> +		spin_unlock_irqrestore(&nvme_fc_lock, flags);
> +		return -EINVAL;
> +	}
> +	portptr->port_state = FC_OBJSTATE_DELETED;
> +
> +	spin_unlock_irqrestore(&nvme_fc_lock, flags);
> +
> +	nvme_fc_lport_put(lport);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvme_fc_unregister_localport);

[...]

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
> +
> +	/* TODO: force a controller reset */
> +
> +	init_completion(&op->abort_done);

Shouldn't a reinit_completion() be sufficient here?
> +
> +	return BLK_EH_HANDLED;
> +}
> +
> +static int
> +nvme_fc_map_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
> +		struct nvme_fc_fcp_op *op)
> +{
> +	struct nvmefc_fcp_req *freq = &op->fcp_req;
> +	u32 map_len = nvme_map_len(rq);
> +	int ret;
> +
> +	freq->sg_cnt = 0;
> +
> +	if (!map_len)
> +		return 0;
> +
> +	freq->sg_table.sgl = freq->first_sgl;
> +	ret = sg_alloc_table_chained(&freq->sg_table, rq->nr_phys_segments,
> +			freq->sg_table.sgl);
> +	if (ret)
> +		return -ENOMEM;
> +
> +	op->nents = blk_rq_map_sg(rq->q, rq, freq->sg_table.sgl);
> +	WARN_ON(op->nents > rq->nr_phys_segments);
> +	freq->sg_cnt = dma_map_sg(ctrl->lport->dev, freq->sg_table.sgl,
> +				op->nents, ((rq_data_dir(rq) == WRITE) ?
> +					DMA_TO_DEVICE : DMA_FROM_DEVICE));

Care to add a 

enum dma_data_direction dir;
dir = (rq_data_dir(rq) == WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;

so we're not getting too many linebreaks? (Just have this one as an example).

> +	if (unlikely(freq->sg_cnt <= 0)) {
> +		sg_free_table_chained(&freq->sg_table, true);
> +		freq->sg_cnt = 0;
> +		return -EFAULT;
> +	}
> +
> +	/*
> +	 * TODO: blk_integrity_rq(rq)  for DIX
> +	 */

Just out of interest, do you plan to get DIX done in this cycle?

> +	return 0;
> +}

[...]

> +
> +/*
> + * Called to terminate an association.
> + * Maybe called with association fully in place or partially in place.
> + */
> +static void
> +nvme_fc_shutdown_ctrl(struct nvme_fc_ctrl *ctrl)
> +{
> +	nvme_stop_keep_alive(&ctrl->ctrl);

The keepalive should have already been stopped in __nvme_fc_remove_ctrl(),
shouldn't it?

> +
> +	if (ctrl->queue_count > 1) {
> +		nvme_stop_queues(&ctrl->ctrl);
> +		blk_mq_tagset_busy_iter(&ctrl->tag_set,
> +					nvme_fc_kill_request, &ctrl->ctrl);
> +	}
> +
> +	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
> +		nvme_shutdown_ctrl(&ctrl->ctrl);
> +
> +	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
> +	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
> +				nvme_fc_kill_request, &ctrl->ctrl);
> +}
> +
> +
> +static void
> +__nvme_fc_remove_ctrl(struct nvme_fc_ctrl *ctrl)
> +{
> +	nvme_stop_keep_alive(&ctrl->ctrl);
> +	nvme_uninit_ctrl(&ctrl->ctrl);
> +	nvme_fc_shutdown_ctrl(ctrl);
> +	nvme_put_ctrl(&ctrl->ctrl);
> +}

[...]

> +static struct nvme_ctrl *
> +nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
> +{
> +	struct nvme_fc_lport *lport;
> +	struct nvme_fc_rport *rport;
> +	struct nvmet_fc_traddr laddr = { 0L, 0L };
> +	struct nvmet_fc_traddr raddr = { 0L, 0L };
> +	unsigned long flags;
> +	int ret;
> +
> +	ret = nvme_fc_parse_address(&raddr, opts->traddr);
> +	if ((ret) || !raddr.nn || !raddr.pn)
            ^ I don't think the parenthesis around ret are needed here
> +		return ERR_PTR(-EINVAL);
> +
> +	ret = nvme_fc_parse_address(&laddr, opts->host_traddr);
> +	if ((ret) || !laddr.nn || !laddr.pn)
Same as above


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
