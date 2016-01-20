From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Wed, 20 Jan 2016 10:52:43 +0000
Subject: [PATCH] NVMe: init nvme queue before enabling irq
In-Reply-To: <569F4DFA.2090504@dev.mellanox.co.il>
References: <1453265860-31080-1-git-send-email-mail_weber_wang@163.com>
 <569F4DFA.2090504@dev.mellanox.co.il>
Message-ID: <BJXPR01MB1993C068F735F2160C48B09E0C20@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>

> I think that this makes the duplication in nvme_alloc_queue redundant.
> Can you remove it?

Thanks. Patch v2 has been sent out.

-----Original Message-----
From: Sagi Grimberg [mailto:sagig@dev.mellanox.co.il] 
Sent: Wednesday, January 20, 2016 5:06 PM
To: Wenbo Wang; keith.busch at intel.com; axboe at fb.com
Cc: Wenbo Wang; Wenwei.Tao; linux-kernel at vger.kernel.org; linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: init nvme queue before enabling irq


> During reset process, the nvme_dev->bar (ioremapped) may change, so 
> nvmeq->q_db shall be also updated by nvme_init_queue().
>
> Currently nvmeq irq is enabled before queue init, so a spurious 
> interrupt triggered nvme_process_cq may access nvmeq->q_db just before 
> it is updated, this could cause kernel panic.
>
> Signed-off-by: Wenbo Wang <wenbo.wang at memblaze.com>
> Reviewed-by: Wenwei Tao <wenwei.tao at memblaze.com>

This patch makes sense to me.

> ---
>   drivers/nvme/host/pci.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index 
> f5c0e26..df55f28 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1590,11 +1590,17 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
>   	if (result < 0)
>   		goto release_cq;
>
> +	/*
> +	 * Init queue door bell ioremap address before enabling irq, if not,
> +	 * a spurious interrupt triggered nvme_process_cq may access invalid
> +	 * address
> +	 */

Not sure we need an explicit comment on the fix here. But I don't mind keeping it.

> +	nvme_init_queue(nvmeq, qid);
> +

I think that this makes the duplication in nvme_alloc_queue redundant.
Can you remove it?

Other then that, looks good to me,

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
