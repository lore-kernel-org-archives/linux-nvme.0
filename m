From: Himanshu.Madhani@cavium.com (Madhani, Himanshu)
Date: Sun, 24 Sep 2017 07:17:11 +0000
Subject: [PATCH v2] nvme_fc: fix iowait hang
In-Reply-To: <20170923164112.10753-1-jsmart2021@gmail.com>
References: <20170923164112.10753-1-jsmart2021@gmail.com>
Message-ID: <19EBD244-B312-43C1-8204-D4350925B714@cavium.com>


> On Sep 23, 2017,@9:41 AM, James Smart <jsmart2021@gmail.com> wrote:
> 
> Add missing iowait head initialization.
> Fix irqsave vs irq: wait_event_lock_irq() doesn't do irq save/restore
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
> drivers/nvme/host/fc.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index af075e998944..8182b1999f49 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2545,10 +2545,10 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
> 	nvme_fc_abort_aen_ops(ctrl);
> 
> 	/* wait for all io that had to be aborted */
> -	spin_lock_irqsave(&ctrl->lock, flags);
> +	spin_lock_irq(&ctrl->lock);
> 	wait_event_lock_irq(ctrl->ioabort_wait, ctrl->iocnt == 0, ctrl->lock);
> 	ctrl->flags &= ~FCCTRL_TERMIO;
> -	spin_unlock_irqrestore(&ctrl->lock, flags);
> +	spin_unlock_irq(&ctrl->lock);
> 
> 	nvme_fc_term_aen_ops(ctrl);
> 
> @@ -2760,6 +2760,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
> 	ctrl->rport = rport;
> 	ctrl->dev = lport->dev;
> 	ctrl->cnum = idx;
> +	init_waitqueue_head(&ctrl->ioabort_wait);
> 
> 	get_device(ctrl->dev);
> 	kref_init(&ctrl->ref);
> -- 
> 2.13.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Looks good. 

Please add following also to the patch.

Fixes: 36715cf4b366 ("nvme_fc: replace ioabort msleep loop with completion?)
Cc: <stable at vger.kernel.org> # 4.13
Reviewed-By: Himanshu Madhani <himanshu.madhani at cavium.com>
Tested-By: Himanshu Madhani <himanshu.madhani at cavium.com>

Thanks,
- Himanshu
