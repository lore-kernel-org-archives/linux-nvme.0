From: keith.busch@intel.com (Busch, Keith)
Date: Mon, 1 Feb 2016 15:59:42 +0000
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93D3D7F52@fmsmsx104.amr.corp.intel.com>

Does this ever happen? The queue should be stopped before the bar is unmapped. If that's insufficient to guard against this, we've another problem this patch does not cover. That command will just timeout since it was accepted by the driver, but not actually submitted to anything. The request needs to be requeued or return BLK_MQ_RQ_QUEUE_BUSY.

> -----Original Message-----
> From: Wenbo Wang [mailto:mail_weber_wang at 163.com]
> Sent: Monday, February 01, 2016 8:42 AM
> To: axboe at fb.com; Busch, Keith
> Cc: linux-kernel at vger.kernel.org; Wenbo Wang; Wenbo Wang; linux-nvme at lists.infradead.org
> Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been suspended
> 
> If __nvme_submit_cmd races with nvme_dev_disable, nvmeq
> could have been suspended and dev->bar could have been
> unmapped. Do not touch sq door bell in this case.
> 
> Signed-off-by: Wenbo Wang <wenbo.wang at memblaze.com>
> Reviewed-by: Wenwei Tao <wenwei.tao at memblaze.com>
> CC: linux-nvme at lists.infradead.org
> ---
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8b1a725..2288712 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -325,7 +325,8 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
> 
>  	if (++tail == nvmeq->q_depth)
>  		tail = 0;
> -	writel(tail, nvmeq->q_db);
> +	if (likely(nvmeq->cq_vector >= 0))
> +		writel(tail, nvmeq->q_db);
>  	nvmeq->sq_tail = tail;
>  }
> 
> --
> 1.8.3.1
