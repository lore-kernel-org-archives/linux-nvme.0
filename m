From: keith.busch@intel.com (Keith Busch)
Date: Wed, 5 Jul 2017 16:18:20 -0400
Subject: [PATCH v2] nvme: split nvme_uninit_ctrl into stop and uninit
In-Reply-To: <1499284138-595-1-git-send-email-sagi@grimberg.me>
References: <1499284138-595-1-git-send-email-sagi@grimberg.me>
Message-ID: <20170705201819.GA24413@localhost.localdomain>

On Wed, Jul 05, 2017@10:48:58PM +0300, Sagi Grimberg wrote:
> -void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
> +void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>  {
> +	nvme_stop_keep_alive(ctrl);
>  	flush_work(&ctrl->async_event_work);
>  	flush_work(&ctrl->scan_work);
> -	nvme_remove_namespaces(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
> +
> +void nvme_start_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	if (ctrl->kato)
> +		nvme_start_keep_alive(ctrl);
> +
> +	if (ctrl->queue_count > 1) {
> +		nvme_queue_scan(ctrl);
> +		nvme_queue_async_events(ctrl);
> +		nvme_start_queues(ctrl);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(nvme_start_ctrl);
>  
> +void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
> +{
>  	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
>  
>  	spin_lock(&dev_list_lock);

Mostly fine, but I don't think we want to move nvme_unint_ctrl to the
'free_ctrl' path. The 'free_ctrl' is called only when all references are
dropped. 'nvme_unint_ctrl' prevents new references on the device being
removed, so this should be done even if active references exist.
