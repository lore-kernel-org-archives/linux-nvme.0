From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 24 Jan 2016 12:48:34 +0200
Subject: [PATCH v1] nvme: Log the ctrl device name instead of the
 undelying pci device name
In-Reply-To: <1453126453-17976-1-git-send-email-sagig@mellanox.com>
References: <1453126453-17976-1-git-send-email-sagig@mellanox.com>
Message-ID: <56A4AC02.1050702@dev.mellanox.co.il>

Keith, care to have a look?

> Having the ctrl name "nvmeX" seems much more friendly than
> the underlying device name. Also, with other nvme transports
> such as the soon to come nvme-loop we don't have an underlying
> device so it doesn't makes sense to make up one.
>
> In order to help matching an instance name to a pci function,
> we add a info print in nvme_probe.
>
> Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
> ---
> Changes from v0:
> - Converted log messages in pci.c too
> - Added a instance - pci function match print in nvme_probe
>
>   drivers/nvme/host/core.c | 24 ++++++++++++------------
>   drivers/nvme/host/pci.c  | 37 +++++++++++++++++++++----------------
>   2 files changed, 33 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e31a256127f7..88bfc11db27e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -557,8 +557,8 @@ static int nvme_revalidate_disk(struct gendisk *disk)
>   	unsigned short bs;
>
>   	if (nvme_identify_ns(ns->ctrl, ns->ns_id, &id)) {
> -		dev_warn(ns->ctrl->dev, "%s: Identify failure nvme%dn%d\n",
> -				__func__, ns->ctrl->instance, ns->ns_id);
> +		dev_warn(disk_to_dev(ns->disk), "%s: Identify failure\n",
> +				__func__);
>   		return -ENODEV;
>   	}
>   	if (id->ncap == 0) {
> @@ -568,7 +568,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
>
>   	if (nvme_nvm_ns_supported(ns, id) && ns->type != NVME_NS_LIGHTNVM) {
>   		if (nvme_nvm_register(ns->queue, disk->disk_name)) {
> -			dev_warn(ns->ctrl->dev,
> +			dev_warn(disk_to_dev(ns->disk),
>   				"%s: LightNVM init failure\n", __func__);
>   			kfree(id);
>   			return -ENODEV;
> @@ -741,7 +741,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
>   		if (fatal_signal_pending(current))
>   			return -EINTR;
>   		if (time_after(jiffies, timeout)) {
> -			dev_err(ctrl->dev,
> +			dev_err(ctrl->device,
>   				"Device not ready; aborting %s\n", enabled ?
>   						"initialisation" : "reset");
>   			return -ENODEV;
> @@ -781,7 +781,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
>   	int ret;
>
>   	if (page_shift < dev_page_min) {
> -		dev_err(ctrl->dev,
> +		dev_err(ctrl->device,
>   			"Minimum device page size %u too large for host (%u)\n",
>   			1 << dev_page_min, 1 << page_shift);
>   		return -ENODEV;
> @@ -822,7 +822,7 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
>   		if (fatal_signal_pending(current))
>   			return -EINTR;
>   		if (time_after(jiffies, timeout)) {
> -			dev_err(ctrl->dev,
> +			dev_err(ctrl->device,
>   				"Device shutdown incomplete; abort shutdown\n");
>   			return -ENODEV;
>   		}
> @@ -844,13 +844,13 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>
>   	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
>   	if (ret) {
> -		dev_err(ctrl->dev, "Reading VS failed (%d)\n", ret);
> +		dev_err(ctrl->device, "Reading VS failed (%d)\n", ret);
>   		return ret;
>   	}
>
>   	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &cap);
>   	if (ret) {
> -		dev_err(ctrl->dev, "Reading CAP failed (%d)\n", ret);
> +		dev_err(ctrl->device, "Reading CAP failed (%d)\n", ret);
>   		return ret;
>   	}
>   	page_shift = NVME_CAP_MPSMIN(cap) + 12;
> @@ -860,7 +860,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
>
>   	ret = nvme_identify_ctrl(ctrl, &id);
>   	if (ret) {
> -		dev_err(ctrl->dev, "Identify Controller failed (%d)\n", ret);
> +		dev_err(ctrl->device, "Identify Controller failed (%d)\n", ret);
>   		return -EIO;
>   	}
>
> @@ -937,13 +937,13 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp)
>
>   	ns = list_first_entry(&ctrl->namespaces, struct nvme_ns, list);
>   	if (ns != list_last_entry(&ctrl->namespaces, struct nvme_ns, list)) {
> -		dev_warn(ctrl->dev,
> +		dev_warn(ctrl->device,
>   			"NVME_IOCTL_IO_CMD not supported when multiple namespaces present!\n");
>   		ret = -EINVAL;
>   		goto out_unlock;
>   	}
>
> -	dev_warn(ctrl->dev,
> +	dev_warn(ctrl->device,
>   		"using deprecated NVME_IOCTL_IO_CMD ioctl on the char device!\n");
>   	kref_get(&ns->kref);
>   	mutex_unlock(&ctrl->namespaces_mutex);
> @@ -969,7 +969,7 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>   	case NVME_IOCTL_IO_CMD:
>   		return nvme_dev_user_cmd(ctrl, argp);
>   	case NVME_IOCTL_RESET:
> -		dev_warn(ctrl->dev, "resetting controller\n");
> +		dev_warn(ctrl->device, "resetting controller\n");
>   		return ctrl->ops->reset_ctrl(ctrl);
>   	case NVME_IOCTL_SUBSYS_RESET:
>   		return nvme_reset_subsystem(ctrl);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 7872dd884c6b..3a243f8b71ac 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -299,10 +299,10 @@ static void nvme_complete_async_event(struct nvme_dev *dev,
>
>   	switch (result & 0xff07) {
>   	case NVME_AER_NOTICE_NS_CHANGED:
> -		dev_info(dev->dev, "rescanning\n");
> +		dev_info(dev->ctrl.device, "rescanning\n");
>   		queue_work(nvme_workq, &dev->scan_work);
>   	default:
> -		dev_warn(dev->dev, "async event result %08x\n", result);
> +		dev_warn(dev->ctrl.device, "async event result %08x\n", result);
>   	}
>   }
>
> @@ -708,7 +708,7 @@ static void nvme_complete_rq(struct request *req)
>   	}
>
>   	if (unlikely(iod->aborted)) {
> -		dev_warn(dev->dev,
> +		dev_warn(dev->ctrl.device,
>   			"completing aborted command with status: %04x\n",
>   			req->errors);
>   	}
> @@ -740,7 +740,7 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
>   			*tag = -1;
>
>   		if (unlikely(cqe.command_id >= nvmeq->q_depth)) {
> -			dev_warn(nvmeq->q_dmadev,
> +			dev_warn(nvmeq->dev->ctrl.device,
>   				"invalid id %d completed on queue %d\n",
>   				cqe.command_id, le16_to_cpu(cqe.sq_id));
>   			continue;
> @@ -908,7 +908,8 @@ static void abort_endio(struct request *req, int error)
>   	u32 result = (u32)(uintptr_t)req->special;
>   	u16 status = req->errors;
>
> -	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status, result);
> +	dev_warn(nvmeq->dev->ctrl.device,
> +		"Abort status:%x result:%x", status, result);
>   	atomic_inc(&nvmeq->dev->ctrl.abort_limit);
>
>   	blk_mq_free_request(req);
> @@ -929,7 +930,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>   	 * shutdown, so we return BLK_EH_HANDLED.
>   	 */
>   	if (test_bit(NVME_CTRL_RESETTING, &dev->flags)) {
> -		dev_warn(dev->dev,
> +		dev_warn(dev->ctrl.device,
>   			 "I/O %d QID %d timeout, disable controller\n",
>   			 req->tag, nvmeq->qid);
>   		nvme_dev_disable(dev, false);
> @@ -943,7 +944,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>    	 * returned to the driver, or if this is the admin queue.
>   	 */
>   	if (!nvmeq->qid || iod->aborted) {
> -		dev_warn(dev->dev,
> +		dev_warn(dev->ctrl.device,
>   			 "I/O %d QID %d timeout, reset controller\n",
>   			 req->tag, nvmeq->qid);
>   		nvme_dev_disable(dev, false);
> @@ -969,8 +970,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>   	cmd.abort.cid = req->tag;
>   	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
>
> -	dev_warn(nvmeq->q_dmadev, "I/O %d QID %d timeout, aborting\n",
> -				 req->tag, nvmeq->qid);
> +	dev_warn(nvmeq->dev->ctrl.device,
> +		"I/O %d QID %d timeout, aborting\n",
> +		 req->tag, nvmeq->qid);
>
>   	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
>   			BLK_MQ_REQ_NOWAIT);
> @@ -999,7 +1001,7 @@ static void nvme_cancel_io(struct request *req, void *data, bool reserved)
>   	if (!blk_mq_request_started(req))
>   		return;
>
> -	dev_warn(dev->dev, "Cancelling I/O %d\n", req->tag);
> +	dev_warn(dev->ctrl.device, "Cancelling I/O %d\n", req->tag);
>
>   	status = NVME_SC_ABORT_REQ;
>   	if (blk_queue_dying(req->q))
> @@ -1346,7 +1348,7 @@ static int nvme_kthread(void *data)
>   			if ((dev->subsystem && (csts & NVME_CSTS_NSSRO)) ||
>   							csts & NVME_CSTS_CFS) {
>   				if (queue_work(nvme_workq, &dev->reset_work)) {
> -					dev_warn(dev->dev,
> +					dev_warn(dev->ctrl.device,
>   						"Failed status: %x, reset controller\n",
>   						readl(dev->bar + NVME_REG_CSTS));
>   				}
> @@ -1473,7 +1475,8 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>   	 * access to the admin queue, as that might be only way to fix them up.
>   	 */
>   	if (result > 0) {
> -		dev_err(dev->dev, "Could not set queue count (%d)\n", result);
> +		dev_err(dev->ctrl.device,
> +			"Could not set queue count (%d)\n", result);
>   		nr_io_queues = 0;
>   		result = 0;
>   	}
> @@ -1918,7 +1921,7 @@ static void nvme_reset_work(struct work_struct *work)
>   	 * any working I/O queue.
>   	 */
>   	if (dev->online_queues < 2) {
> -		dev_warn(dev->dev, "IO queues not created\n");
> +		dev_warn(dev->ctrl.device, "IO queues not created\n");
>   		nvme_remove_namespaces(&dev->ctrl);
>   	} else {
>   		nvme_start_queues(&dev->ctrl);
> @@ -1955,7 +1958,7 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
>
>   static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
>   {
> -	dev_warn(dev->dev, "Removing after probe failure\n");
> +	dev_warn(dev->ctrl.device, "Removing after probe failure\n");
>   	kref_get(&dev->ctrl.kref);
>   	if (!schedule_work(&dev->remove_work))
>   		nvme_put_ctrl(&dev->ctrl);
> @@ -2052,6 +2055,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (result)
>   		goto release_pools;
>
> +	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
> +
>   	queue_work(nvme_workq, &dev->reset_work);
>   	return 0;
>
> @@ -2135,7 +2140,7 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>   	 * shutdown the controller to quiesce. The controller will be restarted
>   	 * after the slot reset through driver's slot_reset callback.
>   	 */
> -	dev_warn(&pdev->dev, "error detected: state:%d\n", state);
> +	dev_warn(dev->ctrl.device, "error detected: state:%d\n", state);
>   	switch (state) {
>   	case pci_channel_io_normal:
>   		return PCI_ERS_RESULT_CAN_RECOVER;
> @@ -2152,7 +2157,7 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
>   {
>   	struct nvme_dev *dev = pci_get_drvdata(pdev);
>
> -	dev_info(&pdev->dev, "restart after slot reset\n");
> +	dev_info(dev->ctrl.device, "restart after slot reset\n");
>   	pci_restore_state(pdev);
>   	queue_work(nvme_workq, &dev->reset_work);
>   	return PCI_ERS_RESULT_RECOVERED;
>
