From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 25 Oct 2016 16:47:42 -0700
Subject: [PATCH v3 5/7] nvme-fabrics: Add host support for FC transport
In-Reply-To: <580d0ffd.cq5y7S+lNBHxNs60%james.smart@broadcom.com>
References: <580d0ffd.cq5y7S+lNBHxNs60%james.smart@broadcom.com>
Message-ID: <1477439262.3009.77.camel@linux.intel.com>

On Sun, 2016-10-23@12:31 -0700, James Smart wrote:
> Add nvme-fabrics host support for FC transport
> 

snip...

> +static int
> +nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue
> *queue,
> +	struct nvme_fc_fcp_op *op, u32 data_len,
> +	enum nvmefc_fcp_datadir	io_dir)
> +{
> +	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
> +	struct nvme_command *sqe = &cmdiu->sqe;
> +	u32 csn;
> +	int ret;
> +
> +	if (!nvme_fc_ctrl_get(ctrl))
> +		return BLK_MQ_RQ_QUEUE_ERROR;
> +
> +	/* format the FC-NVME CMD IU and fcp_req */
> +	cmdiu->connection_id = cpu_to_be64(queue->connection_id);
> +	csn = atomic_inc_return(&queue->csn);
> +	cmdiu->csn = cpu_to_be32(csn);
> +	cmdiu->data_len = cpu_to_be32(data_len);
> +	switch (io_dir) {
> +	case NVMEFC_FCP_WRITE:
> +		cmdiu->flags = FCNVME_CMD_FLAGS_WRITE;
> +		break;
> +	case NVMEFC_FCP_READ:
> +		cmdiu->flags = FCNVME_CMD_FLAGS_READ;
> +		break;
> +	case NVMEFC_FCP_NODATA:
> +		cmdiu->flags = 0;
> +		break;
> +	}
> +	op->fcp_req.payload_length = data_len;
> +	op->fcp_req.io_dir = io_dir;
> +	op->fcp_req.transferred_length = 0;
> +	op->fcp_req.rcv_rsplen = 0;
> +	op->fcp_req.status = 0;
> +	op->fcp_req.sqid = cpu_to_le16(queue->qnum);
> +
> +	/*
> +	?* validate per fabric rules, set fields mandated by fabric
> spec
> +	?* as well as those by FC-NVME spec.
> +	?*/
> +	WARN_ON_ONCE(sqe->common.metadata);
> +	WARN_ON_ONCE(sqe->common.dptr.prp1);
> +	WARN_ON_ONCE(sqe->common.dptr.prp2);
> +	sqe->common.flags |= NVME_CMD_SGL_METABUF;
> +
> +	/*
> +	?* format SQE DPTR field per FC-NVME rules
> +	?*????type=data block descr; subtype=offset;
> +	?*????offset is currently 0.
> +	?*/
> +	sqe->rw.dptr.sgl.type = NVME_SGL_FMT_OFFSET;
> +	sqe->rw.dptr.sgl.length = cpu_to_le32(data_len);
> +	sqe->rw.dptr.sgl.addr = 0;
> +
> +	/* odd that we set the command_id - should come from nvme-
> fabrics */
> +	WARN_ON_ONCE(sqe->common.command_id != cpu_to_le16(op-
> >rqno));
> +
> +	if (op->rq) {				/* skipped on
> aens */
> +		ret = nvme_fc_map_data(ctrl, op->rq, op);
> +		if (ret < 0) {
> +			dev_err(queue->ctrl->ctrl.device,
> +			?????"Failed to map data (%d)\n", ret);
> +			nvme_cleanup_cmd(op->rq);
> +			nvme_fc_ctrl_put(ctrl);
> +			return (ret == -ENOMEM || ret == -EAGAIN) ?
> +				BLK_MQ_RQ_QUEUE_BUSY :
> BLK_MQ_RQ_QUEUE_ERROR;
> +		}
> +	}
> +
> +	dma_sync_single_for_device(ctrl->lport->dev, op-
> >fcp_req.cmddma,
> +				??sizeof(op->cmd_iu),
> DMA_TO_DEVICE);
> +
> +	atomic_set(&op->state, FCPOP_STATE_ACTIVE);
> +
> +	if (op->rq)
> +		blk_mq_start_request(op->rq);
> +
> +	ret = ctrl->lport->ops->fcp_io(&ctrl->lport->localport,
> +					&ctrl->rport->remoteport,
> +					queue->lldd_handle, &op-
> >fcp_req);
> +
> +	if (ret) {
> +		dev_err(ctrl->dev,
> +			"Send nvme command failed - lldd returned
> %d.\n", ret);
> +		if (op->rq) {			/* normal
> request */
> +			nvme_fc_unmap_data(ctrl, op->rq, op);
> +			nvme_cleanup_cmd(op->rq);
> +		}
> +		/* else - aen. no cleanup needed */
> +
> +		nvme_fc_ctrl_put(ctrl);
> +
> +		if (ret != -EBUSY)
> +			return BLK_MQ_RQ_QUEUE_ERROR;
> +
> +		blk_mq_stop_hw_queues(op->rq->q);

It looks like 'if(op->rq)' is checked for NULL before this 'if (ret)'
block, but it's theoretically possible 'if(ret)' is true and things
completely blow up here by a op->rq de-reference? ?


> +		blk_mq_delay_queue(queue->hctx, NVMEFC_QUEUE_DELAY);
> +		return BLK_MQ_RQ_QUEUE_BUSY;
> +	}
> +
> +	return BLK_MQ_RQ_QUEUE_OK;
> +}

snip...

>?
> +static int
> +__nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op
> *op)
> +{
> +	int state;
> +
> +	state = atomic_xchg(&op->state, FCPOP_STATE_ABORTED);
> +	if (state != FCPOP_STATE_ACTIVE) {
> +		atomic_set(&op->state, state);
> +		return 1; /* fail */

nitpick: Why would this function return a positive value for an error
condition? ?Maybe use "-EACCES" instead?

> +	}
> +
> +	ctrl->lport->ops->fcp_abort(&ctrl->lport->localport,
> +					&ctrl->rport->remoteport,
> +					op->queue->lldd_handle,
> +					&op->fcp_req);
> +
> +	return 0;
> +}
> +
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
> +	/* TODO: force a controller reset */
> +
> +	return BLK_EH_HANDLED;

Another nitpick- that 'if(ret)' statement isn't adding any value, the
function returns BLK_EH_HANDLED regardless if the conditional is taken.

snip...

>?
>?
> +
> +static struct nvme_ctrl *
> +__nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options
> *opts,
> +	struct nvme_fc_lport *lport, struct nvme_fc_rport *rport)
> +{
> +	struct nvme_fc_ctrl *ctrl;
> +	unsigned long flags;
> +	int ret, idx;
> +	bool changed;
> +
> +	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
> +	if (!ctrl) {
> +		ret = -ENOMEM;
> +		goto out_fail;
> +	}
> +
> +	idx = ida_simple_get(&nvme_fc_ctrl_cnt, 0, 0, GFP_KERNEL);
> +	if (idx < 0) {
> +		ret = -ENOSPC;
> +		goto out_free_ctrl;
> +	}
> +
> +	ctrl->ctrl.opts = opts;
> +	INIT_LIST_HEAD(&ctrl->ctrl_list);
> +	INIT_LIST_HEAD(&ctrl->ls_req_list);
> +	ctrl->lport = lport;
> +	ctrl->rport = rport;
> +	ctrl->dev = lport->dev;
> +	ctrl->state = FCCTRL_INIT;
> +	ctrl->cnum = idx;
> +
> +	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_fc_ctrl_ops,
> 0);
> +	if (ret)
> +		goto out_free_ida;
> +
> +	get_device(ctrl->dev);
> +	kref_init(&ctrl->ref);
> +
> +	INIT_WORK(&ctrl->delete_work, nvme_fc_del_ctrl_work);
> +	spin_lock_init(&ctrl->lock);
> +
> +	/* io queue count */
> +	ctrl->queue_count = min_t(unsigned int,
> +				opts->nr_io_queues,
> +				lport->ops->max_hw_queues);
> +	opts->nr_io_queues = ctrl->queue_count;	/* so opts
> has valid value */
> +	ctrl->queue_count++;	/* +1 for admin queue */
> +
> +	ctrl->ctrl.sqsize = opts->queue_size - 1;
> +	ctrl->ctrl.kato = opts->kato;
> +
> +	ret = -ENOMEM;
> +	ctrl->queues = kcalloc(ctrl->queue_count, sizeof(struct
> nvme_fc_queue),
> +				GFP_KERNEL);
> +	if (!ctrl->queues)
> +		goto out_uninit_ctrl;
> +
> +	ret = nvme_fc_configure_admin_queue(ctrl);
> +	if (ret)
> +		goto out_uninit_ctrl;
> +
> +	/* sanity checks */
> +
> +	/* FC-NVME supports 64-byte SQE only */
> +	if (ctrl->ctrl.ioccsz != 4) {
> +		dev_err(ctrl->ctrl.device, "ioccsz %d is not
> supported!\n",
> +				ctrl->ctrl.ioccsz);
> +		goto out_remove_admin_queue;
> +	}
> +	/* FC-NVME supports 16-byte CQE only */
> +	if (ctrl->ctrl.iorcsz != 1) {
> +		dev_err(ctrl->ctrl.device, "iorcsz %d is not
> supported!\n",
> +				ctrl->ctrl.iorcsz);
> +		goto out_remove_admin_queue;
> +	}
> +	/* FC-NVME does not have other data in the capsule */
> +	if (ctrl->ctrl.icdoff) {
> +		dev_err(ctrl->ctrl.device, "icdoff %d is not
> supported!\n",
> +				ctrl->ctrl.icdoff);
> +		goto out_remove_admin_queue;
> +	}
> +
> +	/* FC-NVME supports normal SGL Data Block Descriptors */
> +
> +	if (opts->queue_size > ctrl->ctrl.maxcmd) {
> +		/* warn if maxcmd is lower than queue_size */
> +		dev_warn(ctrl->ctrl.device,
> +			"queue_size %zu > ctrl maxcmd %u, reducing "
> +			"to queue_size\n",
> +			opts->queue_size, ctrl->ctrl.maxcmd);
> +		opts->queue_size = ctrl->ctrl.maxcmd;
> +	}
> +
> +	ret = nvme_fc_init_aen_ops(ctrl);
> +	if (ret)
> +		goto out_exit_aen_ops;
> +
> +	if (ctrl->queue_count > 1) {
> +		ret = nvme_fc_create_io_queues(ctrl);
> +		if (ret)
> +			goto out_exit_aen_ops;
> +	}
> +
> +	spin_lock_irqsave(&ctrl->lock, flags);
> +	ctrl->state = FCCTRL_ACTIVE;
> +	spin_unlock_irqrestore(&ctrl->lock, flags);
> +
> +	changed = nvme_change_ctrl_state(&ctrl->ctrl,
> NVME_CTRL_LIVE);
> +	WARN_ON_ONCE(!changed);
> +
> +	dev_info(ctrl->ctrl.device,
> +		"NVME-FC{%d}: new ctrl: NQN \"%s\" (%p)\n",
> +		ctrl->cnum, ctrl->ctrl.opts->subsysnqn, &ctrl);
> +
> +	kref_get(&ctrl->ctrl.kref);
> +
> +	spin_lock_irqsave(&rport->lock, flags);
> +	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
> +	spin_unlock_irqrestore(&rport->lock, flags);
> +
> +	if (opts->nr_io_queues) {
> +		nvme_queue_scan(&ctrl->ctrl);
> +		nvme_queue_async_events(&ctrl->ctrl);
> +	}
> +
> +	return &ctrl->ctrl;
> +
> +out_exit_aen_ops:
> +	nvme_fc_exit_aen_ops(ctrl);
> +out_remove_admin_queue:
> +	nvme_stop_keep_alive(&ctrl->ctrl);
> +	nvme_fc_destroy_admin_queue(ctrl);
> +out_uninit_ctrl:
> +	nvme_uninit_ctrl(&ctrl->ctrl);
> +	nvme_put_ctrl(&ctrl->ctrl);
> +	if (ret > 0)
> +		ret = -EIO;
> +	/* exit via here will follow ctlr ref point callbacks to
> free */
> +	return ERR_PTR(ret);

Memory leak?? kfree(ctrl); i.e. the "struct_nvme_fc_ctrl *ctrl;" is not
called before the return in this case I think?



Minor, so otherwise looks ok (minus Christoph's comments).

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
