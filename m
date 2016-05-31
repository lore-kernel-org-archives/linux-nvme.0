From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Tue, 31 May 2016 19:10:45 -0300
Subject: [PATCH v3] NVMe: Add controller state for scheduling resets
In-Reply-To: <1464729927-14574-1-git-send-email-keith.busch@intel.com>
References: <1464729927-14574-1-git-send-email-keith.busch@intel.com>
Message-ID: <201605312210.u4VM8pwa023384@mx0a-001b2d01.pphosted.com>

On 05/31/2016 06:25 PM, Keith Busch wrote:
> All resets now must be submitted through the new state. This makes it
> easier to coordinate controller tasks and simplifies the reset logic.

Keith, I'm working on a patch right now that explores the capacity of 
differentiate between resets. What I'm doing is re-working a quirk 
already sent to the list, in which we need to wait some seconds before 
read the NVME_REG_CSTS register in a specific adapter after fw-activate 
event.

The improved quirk was counting on ctrl->state to differentiate between 
resets; whenever reset_controller was issued from userspace, this state 
was set as NVME_CTRL_LIVE and in any other case, the state was 
NVME_CTRL_RESETTING.

Now, I tested the quirk after adding this patch and, as expected, the 
state is always NVME_CTRL_RESETTING. So, is there any other way to 
differentiate between resets?

Thanks in advance,


Guilherme

>
> Since all resets go through the same state machine, and most of these
> don't want to block for the reset to complete, this patch makes user
> initiated resets asynchronous as well. Making user resets block until
> complete wasn't necessary in the first place.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> ---
> v2 -> v3:
>    Fixed the warning message print on failed controller.
>
> v1 -> v2:
>    Fix export symbol to use GPL.
>
>   drivers/nvme/host/core.c | 26 ++++++++++++++++++++++----
>   drivers/nvme/host/nvme.h |  2 ++
>   drivers/nvme/host/pci.c  | 40 ++++++++++++++++------------------------
>   3 files changed, 40 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6290477..c822977 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -66,6 +66,15 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>
>   	spin_lock_irq(&ctrl->lock);
>   	switch (new_state) {
> +	case NVME_CTRL_SCHED_RESET:
> +		switch (old_state) {
> +		case NVME_CTRL_NEW:
> +		case NVME_CTRL_LIVE:
> +			changed = true;
> +			/* FALLTHRU */
> +		default:
> +			break;
> +		}
>   	case NVME_CTRL_LIVE:
>   		switch (old_state) {
>   		case NVME_CTRL_RESETTING:
> @@ -77,8 +86,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		break;
>   	case NVME_CTRL_RESETTING:
>   		switch (old_state) {
> -		case NVME_CTRL_NEW:
> -		case NVME_CTRL_LIVE:
> +		case NVME_CTRL_SCHED_RESET:
>   			changed = true;
>   			/* FALLTHRU */
>   		default:
> @@ -89,6 +97,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		switch (old_state) {
>   		case NVME_CTRL_LIVE:
>   		case NVME_CTRL_RESETTING:
> +		case NVME_CTRL_SCHED_RESET:
>   			changed = true;
>   			/* FALLTHRU */
>   		default:
> @@ -1209,6 +1218,15 @@ out_unlock:
>   	return ret;
>   }
>
> +int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_SCHED_RESET))
> +		return -EBUSY;
> +
> +	return ctrl->ops->reset_ctrl(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
> +
>   static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>   		unsigned long arg)
>   {
> @@ -1222,7 +1240,7 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>   		return nvme_dev_user_cmd(ctrl, argp);
>   	case NVME_IOCTL_RESET:
>   		dev_warn(ctrl->device, "resetting controller\n");
> -		return ctrl->ops->reset_ctrl(ctrl);
> +		return nvme_reset_ctrl(ctrl);
>   	case NVME_IOCTL_SUBSYS_RESET:
>   		return nvme_reset_subsystem(ctrl);
>   	case NVME_IOCTL_RESCAN:
> @@ -1248,7 +1266,7 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
>   	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>   	int ret;
>
> -	ret = ctrl->ops->reset_ctrl(ctrl);
> +	ret = nvme_reset_ctrl(ctrl);
>   	if (ret < 0)
>   		return ret;
>   	return count;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1daa048..b948f26 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -73,6 +73,7 @@ enum nvme_ctrl_state {
>   	NVME_CTRL_RESETTING,
>   	NVME_CTRL_DELETING,
>   	NVME_CTRL_DEAD,
> +	NVME_CTRL_SCHED_RESET,
>   };
>
>   struct nvme_ctrl {
> @@ -207,6 +208,7 @@ static inline bool nvme_req_needs_retry(struct request *req, u16 status)
>   		(jiffies - req->start_time) < req->timeout;
>   }
>
> +int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
>   bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>   		enum nvme_ctrl_state new_state);
>   int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cd5f445..dfb8f2a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -68,7 +68,6 @@ static struct workqueue_struct *nvme_workq;
>   struct nvme_dev;
>   struct nvme_queue;
>
> -static int nvme_reset(struct nvme_dev *dev);
>   static void nvme_process_cq(struct nvme_queue *nvmeq);
>   static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
>
> @@ -868,7 +867,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>   			 "I/O %d QID %d timeout, reset controller\n",
>   			 req->tag, nvmeq->qid);
>   		nvme_dev_disable(dev, false);
> -		queue_work(nvme_workq, &dev->reset_work);
> +		nvme_reset_ctrl(&dev->ctrl);
>
>   		/*
>   		 * Mark the request as handled, since the inline shutdown
> @@ -1285,7 +1284,7 @@ static void nvme_watchdog_timer(unsigned long data)
>
>   	/* Skip controllers under certain specific conditions. */
>   	if (nvme_should_reset(dev, csts)) {
> -		if (queue_work(nvme_workq, &dev->reset_work))
> +		if (!nvme_reset_ctrl(&dev->ctrl))
>   			dev_warn(dev->dev,
>   				"Failed status: 0x%x, reset controller.\n",
>   				csts);
> @@ -1773,7 +1772,11 @@ static void nvme_reset_work(struct work_struct *work)
>   	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
>   	int result = -ENODEV;
>
> -	if (WARN_ON(dev->ctrl.state == NVME_CTRL_RESETTING))
> +	/*
> +	 * The controller is being removed if its state machine can't
> +	 * transition to reset.
> +	 */
> +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
>   		goto out;
>
>   	/*
> @@ -1783,9 +1786,6 @@ static void nvme_reset_work(struct work_struct *work)
>   	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
>   		nvme_dev_disable(dev, false);
>
> -	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
> -		goto out;
> -
>   	result = nvme_pci_enable(dev);
>   	if (result)
>   		goto out;
> @@ -1855,18 +1855,6 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
>   	nvme_put_ctrl(&dev->ctrl);
>   }
>
> -static int nvme_reset(struct nvme_dev *dev)
> -{
> -	if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
> -		return -ENODEV;
> -
> -	if (!queue_work(nvme_workq, &dev->reset_work))
> -		return -EBUSY;
> -
> -	flush_work(&dev->reset_work);
> -	return 0;
> -}
> -
>   static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
>   {
>   	*val = readl(to_nvme_dev(ctrl)->bar + off);
> @@ -1887,7 +1875,11 @@ static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
>
>   static int nvme_pci_reset_ctrl(struct nvme_ctrl *ctrl)
>   {
> -	return nvme_reset(to_nvme_dev(ctrl));
> +	if (WARN_ON(ctrl->state != NVME_CTRL_SCHED_RESET))
> +		return -EBUSY;
> +	if (!queue_work(nvme_workq, &(to_nvme_dev(ctrl)->reset_work)))
> +		return -EBUSY;
> +	return 0;
>   }
>
>   static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
> @@ -1968,7 +1960,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>
>   	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
>
> -	queue_work(nvme_workq, &dev->reset_work);
> +	nvme_reset_ctrl(&dev->ctrl);
>   	return 0;
>
>    release_pools:
> @@ -1990,7 +1982,7 @@ static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
>   	if (prepare)
>   		nvme_dev_disable(dev, false);
>   	else
> -		queue_work(nvme_workq, &dev->reset_work);
> +		nvme_reset_ctrl(&dev->ctrl);
>   }
>
>   static void nvme_shutdown(struct pci_dev *pdev)
> @@ -2041,7 +2033,7 @@ static int nvme_resume(struct device *dev)
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	struct nvme_dev *ndev = pci_get_drvdata(pdev);
>
> -	queue_work(nvme_workq, &ndev->reset_work);
> +	nvme_reset_ctrl(&ndev->ctrl);
>   	return 0;
>   }
>   #endif
> @@ -2080,7 +2072,7 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
>
>   	dev_info(dev->ctrl.device, "restart after slot reset\n");
>   	pci_restore_state(pdev);
> -	queue_work(nvme_workq, &dev->reset_work);
> +	nvme_reset_ctrl(&dev->ctrl);
>   	return PCI_ERS_RESULT_RECOVERED;
>   }
>
