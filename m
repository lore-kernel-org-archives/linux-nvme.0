From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 23 Jan 2018 15:14:52 +0200
Subject: [PATCH 3/5] nvme/pci: End stopped queue requests directly
In-Reply-To: <20180122215630.13697-3-keith.busch@intel.com>
References: <20180122215630.13697-1-keith.busch@intel.com>
 <20180122215630.13697-3-keith.busch@intel.com>
Message-ID: <dcdebb05-2e3d-2b47-a6db-ab298747cfeb@grimberg.me>


> +static void nvme_end_stopped_queue_request(struct request *req, void *data,
> +				   bool reserved)

nvme_pci_end_stopped_queue_request

> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct nvme_queue *nvmeq = iod->nvmeq;
> +
> +	if (nvmeq->cq_vector != -1)
> +		return;
> +	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
> +			    "Ending I/O %d QID:%d", req->tag, nvmeq->qid);
> +	blk_mq_end_request(req, BLK_STS_IOERR);
> +}
> +
>   static void nvme_reset_work(struct work_struct *work)
>   {
>   	struct nvme_dev *dev =
> @@ -2344,6 +2357,8 @@ static void nvme_reset_work(struct work_struct *work)
>   		nvme_remove_namespaces(&dev->ctrl);
>   		new_state = NVME_CTRL_ADMIN_ONLY;
>   	} else {
> +		nvme_set_iter(&dev->ctrl, dev->ctrl.tagset,
> +			      nvme_end_stopped_queue_request);

It would have been good if we could reuse that in other transports
where we maintain state flags (NVME_*_Q_LIVE).
