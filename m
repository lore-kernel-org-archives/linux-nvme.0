From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 28 Mar 2019 23:19:41 +0800
Subject: [PATCH 2/3] nvme: shorten race window in nvme_ns_remove()
In-Reply-To: <e53b556e-52ab-8be4-5a23-43aa910889af@suse.de>
References: <20190327080929.27918-1-hare@suse.de>
 <20190327080929.27918-3-hare@suse.de>
 <20190327142044.GB8448@localhost.localdomain>
 <7c724e84-519e-e0f9-f82d-31a89ec37680@suse.com>
 <9500d83c-c5da-d87c-c5ef-d67e2c9f8898@broadcom.com>
 <7c112deb-e8c3-eeca-7bda-771c793cb9c6@suse.de>
 <CACVXFVM0SW1CMzJRr2HwSvfbYYwR19eR_whxYjn+GiYgZOQb5g@mail.gmail.com>
 <4fea0599-a4be-6aff-7728-ca49282eb321@suse.com>
 <e53b556e-52ab-8be4-5a23-43aa910889af@suse.de>
Message-ID: <CACVXFVPAtgmDqkfhEz9bxS_Pjz4XVX4gxkvPSF3cen9=adZzsw@mail.gmail.com>

On Thu, Mar 28, 2019@8:11 PM Hannes Reinecke <hare@suse.de> wrote:
>
> On 3/28/19 12:48 PM, Hannes Reinecke wrote:
> > On 3/28/19 12:07 PM, Ming Lei wrote:
> >> On Thu, Mar 28, 2019@5:28 PM Hannes Reinecke <hare@suse.de> wrote:
> >>>
> >>> On 3/27/19 7:50 PM, James Smart wrote:
> [ .. ]
> >>>> But, Keiths statements make me nervous. With Hannes's patches, I could
> >>>> easily see the case where the ns->queue was quiesced when ns_remove is
> >>>> called, which I think causes issues with blk_freeze_queue. We would
> >>>> need
> >>>> to have ns_remove, after unlinking, to release the queue. is this
> >>>> right ?
> >>>>
> >>> Hmm. But maybe it's as simple as this:
> >>>
> >>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> >>> index 4e5ad111b68b..67451e5eec31 100644
> >>> --- a/drivers/nvme/host/core.c
> >>> +++ b/drivers/nvme/host/core.c
> >>> @@ -131,6 +131,7 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
> >>>    {
> >>>           if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> >>>                   return -EBUSY;
> >>> +       flush_work(&ctrl->scan_work);
> >>>           if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
> >>>                   return -EBUSY;
> >>>
> >>
> >> This way might cause deadlock because there is sync IO in scan
> >> work context.
> >>
> > But I sort of hoped that I/O would be aborted when the controller is
> > resetting, which should cause the sync I/O to complete, right?
> >
> But indeed, you're right (of course).
>
> This should be better:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 67451e5eec31..81900735a380 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3452,6 +3452,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>   {
>          nvme_mpath_stop(ctrl);
>          nvme_stop_keep_alive(ctrl);
> +       flush_work(&ctrl->scan_work);
>          flush_work(&ctrl->async_event_work);
>          cancel_work_sync(&ctrl->fw_act_work);
>   }
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index d42bada25b54..ef20935a7202 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1761,8 +1761,8 @@ static void nvme_rdma_reset_ctrl_work(struct
> work_struct *work)
>          int ret;
>          bool changed;
>
> -       nvme_stop_ctrl(&ctrl->ctrl);
>          nvme_rdma_shutdown_ctrl(ctrl, false);
> +       nvme_stop_ctrl(&ctrl->ctrl);

After the controller is shutdown, no any IO can be done at all, then
flush_work(&ctrl->scan_work) will wait for ever.

Thanks,
Ming Lei
