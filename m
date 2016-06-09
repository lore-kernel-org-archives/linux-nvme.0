From: sagi@lightbits.io (Sagi Grimberg)
Date: Thu, 9 Jun 2016 14:19:55 +0300
Subject: [PATCH 2/2] nvme-rdma: check the number of hw queues mapped
In-Reply-To: <1465415292-9416-3-git-send-email-mlin@kernel.org>
References: <1465415292-9416-1-git-send-email-mlin@kernel.org>
 <1465415292-9416-3-git-send-email-mlin@kernel.org>
Message-ID: <575950DB.6080701@lightbits.io>

This needs documentation in the form of:

/*
  * XXX: blk-mq might not map all our hw contexts but this is a must for
  * us for fabric connects. So until we can fix blk-mq we check that.
  */

> +	hw_queue_mapped = blk_mq_hctx_mapped(ctrl->ctrl.connect_q);
> +	if (hw_queue_mapped < ctrl->ctrl.connect_q->nr_hw_queues) {
> +		dev_err(ctrl->ctrl.device,
> +			"%d hw queues created, but only %d were mapped to sw queues\n",
> +			ctrl->ctrl.connect_q->nr_hw_queues,
> +			hw_queue_mapped);
> +		ret = -EINVAL;
> +		goto out_cleanup_connect_q;
> +	}
> +
>   	ret = nvme_rdma_connect_io_queues(ctrl);
>   	if (ret)
>   		goto out_cleanup_connect_q;
>
