From: hch@lst.de (Christoph Hellwig)
Date: Wed, 5 Jul 2017 19:41:08 +0200
Subject: [PATCH] nvme-rdma: stop keep_alive before nvme_uninit_ctrl
In-Reply-To: <ccbe95fe-0711-52a6-4fec-22c2c05bc3ef@grimberg.me>
References: <1498746799-34110-1-git-send-email-dmilburn@redhat.com>
 <ccbe95fe-0711-52a6-4fec-22c2c05bc3ef@grimberg.me>
Message-ID: <20170705174108.GE5417@lst.de>

This idea looks fine - please send it out in a separate thread.

A few minor comments below:

> -void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
> +void __nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>  {
> +       nvme_stop_keep_alive(ctrl);
>         flush_work(&ctrl->async_event_work);
>         flush_work(&ctrl->scan_work);
> +}
> +EXPORT_SYMBOL_GPL(__nvme_stop_ctrl);

I don't really like the __nvme_stop_ctrl name for something that
is called all the time.  I think this should be nvme_stop_ctrl.

> +
> +void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
> +{
> +       __nvme_stop_ctrl(ctrl);
>         nvme_remove_namespaces(ctrl);
> +}
> +EXPORT_SYMBOL_GPL(nvme_stop_ctrl);

And then this becomes nvme_remove_ctrl?

> +       nvme_start_ctrl(&ctrl->ctrl);
> +       if (ctrl->ctrl.queue_count > 1)
>                 nvme_start_queues(&ctrl->ctrl);

Maybe add a nvme_restart_ctrl for this always duplicated sequence?
