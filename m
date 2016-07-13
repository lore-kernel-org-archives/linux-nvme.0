From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 13 Jul 2016 16:19:46 -0700
Subject: [PATCH 2/2] nvme-rdma: move admin queue cleanup to
 nvme_rdma_free_ctrl
In-Reply-To: <1468445196-6915-3-git-send-email-mlin@kernel.org>
References: <1468445196-6915-1-git-send-email-mlin@kernel.org>
 <1468445196-6915-3-git-send-email-mlin@kernel.org>
Message-ID: <1468451986.4105.3.camel@linux.intel.com>


>  static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
> @@ -687,6 +684,10 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl
> *nctrl)
>  	list_del(&ctrl->list);
>  	mutex_unlock(&nvme_rdma_ctrl_mutex);
>  
> +	blk_cleanup_queue(ctrl->ctrl.admin_q);
> +	blk_mq_free_tag_set(&ctrl->admin_tag_set);
> +	nvme_rdma_dev_put(ctrl->device);
> +
>  	if (ctrl->ctrl.tagset) {
>  		blk_cleanup_queue(ctrl->ctrl.connect_q);
>  		blk_mq_free_tag_set(&ctrl->tag_set);

This patch does not remove the second

nvme_rdma_dev_put(ctrl->device);

call that happens within the if() statement above if it evaluates to
TRUE.  Should that have been removed or moved elsewhere?
