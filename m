From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 30 Aug 2016 18:46:39 +0300
Subject: [PATCH WIP/RFC v2 6/6] nvme-rdma: use ib_client API to detect
 device removal
In-Reply-To: <a78624bcccd2262cf54d8db4aa7da753bd6b499a.1472506505.git.swise@opengridcomputing.com>
References: <cover.1472506505.git.swise@opengridcomputing.com>
 <a78624bcccd2262cf54d8db4aa7da753bd6b499a.1472506505.git.swise@opengridcomputing.com>
Message-ID: <b0f1740f-bcf7-d508-7a64-223202d6c063@grimberg.me>


> +static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
> +{
> +	struct nvme_rdma_ctrl *ctrl, *tmp;
> +
> +	pr_info("Removing resources for device %s\n", ib_device->name);
> +
> +	mutex_lock(&nvme_rdma_ctrl_mutex);
> +	list_for_each_entry_safe(ctrl, tmp, &nvme_rdma_ctrl_list, list) {
> +		int delete_ctrl;
> +
> +		if (ctrl->device->dev != ib_device)
> +			continue;
> +
> +		/*
> +		 * Keep a reference until all work is flushed since
> +		 * __nvme_rdma_del_ctrl can free the ctrl mem
> +		 */
> +		kref_get(&ctrl->ctrl.kref);
> +		delete_ctrl = nvme_change_ctrl_state(&ctrl->ctrl,
> +				NVME_CTRL_DELETING);
> +		mutex_unlock(&nvme_rdma_ctrl_mutex);
> +
> +		dev_info(ctrl->ctrl.device,
> +			"Removing ctrl: NQN \"%s\", addr %pISp\n",
> +			ctrl->ctrl.opts->subsysnqn, &ctrl->addr);
> +
> +		if (delete_ctrl) {
> +
> +			/* Get rid of reconnect work if its running */
> +			cancel_delayed_work_sync(&ctrl->reconnect_work);
> +
> +			/* queue controller deletion */
> +			queue_work(nvme_rdma_wq, &ctrl->delete_work);
> +		}
> +
> +		/* wait for deletion work to complete */
> +		flush_work(&ctrl->delete_work);
> +		nvme_put_ctrl(&ctrl->ctrl);
> +		mutex_lock(&nvme_rdma_ctrl_mutex);
> +	}
> +	mutex_unlock(&nvme_rdma_ctrl_mutex);
> +}

Will this code work?

	mutex_lock(&nvme_rdma_ctrl_mutex);
	list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
		if (ctrl->device->dev != ib_device)
			continue;

		__nvme_rdma_del_ctrl(ctrl);
	}
	mutex_unlock(&nvme_rdma_ctrl_mutex);

	flush_workqueue(nvme_rdma_wq);
