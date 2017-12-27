From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 27 Dec 2017 19:08:21 +0800
Subject: [PATCH v2] nvme-pci: allocate device queues storage space at probe
In-Reply-To: <a0561911-8f7a-5600-9fa1-c9502d082f4b@grimberg.me>
References: <20171225120526.29303-1-sagi@grimberg.me>
 <20171227062048.GA27546@ming.t460p>
 <a0561911-8f7a-5600-9fa1-c9502d082f4b@grimberg.me>
Message-ID: <20171227110820.GB27546@ming.t460p>

On Wed, Dec 27, 2017@10:59:44AM +0200, Sagi Grimberg wrote:
> 
> > Hi Sagi,
> > 
> > This patch introduces a new kernel oops:
> 
> Hi Ming, thanks for testing.
> 
> It looks like pci resets are not serialized which is in general not
> healthy and forcing the driver to handle tough races. I think that not
> serializing it is buggy to begin with.
> 
> I think [1] should solve the issue you are seeing (and I think correct
> on its own regardless).
> 
> Keith, Christoph, any objections?
> 
> [1]:
> --
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c7e7b8e22bdb..98e4c28ebaaa 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -112,7 +112,7 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>  }
>  EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
> 
> -static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
> +int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
>  {
>         int ret;
> 
> @@ -121,6 +121,7 @@ static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
>                 flush_work(&ctrl->reset_work);
>         return ret;
>  }
> +EXPORT_SYMBOL_GPL(nvme_reset_ctrl_sync);
> 
>  static void nvme_delete_ctrl_work(struct work_struct *work)
>  {
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9df2dc063f48..67ab41d71038 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -400,6 +400,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int
> *count);
>  void nvme_start_keep_alive(struct nvme_ctrl *ctrl);
>  void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
>  int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
> +int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
>  int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
>  int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 77200fb89a64..8b116f1ebe66 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2514,7 +2514,7 @@ static void nvme_reset_prepare(struct pci_dev *pdev)
>  static void nvme_reset_done(struct pci_dev *pdev)
>  {
>         struct nvme_dev *dev = pci_get_drvdata(pdev);
> -       nvme_reset_ctrl(&dev->ctrl);
> +       nvme_reset_ctrl_sync(&dev->ctrl);
>  }
> 
>  static void nvme_shutdown(struct pci_dev *pdev)
> --

Yeah, this patch fixes the oops in nvme_suspend_queue().

Thanks,
Ming
