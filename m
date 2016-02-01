From: axboe@fb.com (Jens Axboe)
Date: Mon, 1 Feb 2016 09:54:13 -0700
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
Message-ID: <56AF8DB5.70206@fb.com>

On 02/01/2016 08:42 AM, Wenbo Wang wrote:
> If __nvme_submit_cmd races with nvme_dev_disable, nvmeq
> could have been suspended and dev->bar could have been
> unmapped. Do not touch sq door bell in this case.
>
> Signed-off-by: Wenbo Wang <wenbo.wang at memblaze.com>
> Reviewed-by: Wenwei Tao <wenwei.tao at memblaze.com>
> CC: linux-nvme at lists.infradead.org
> ---
>   drivers/nvme/host/pci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8b1a725..2288712 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -325,7 +325,8 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
>
>   	if (++tail == nvmeq->q_depth)
>   		tail = 0;
> -	writel(tail, nvmeq->q_db);
> +	if (likely(nvmeq->cq_vector >= 0))
> +		writel(tail, nvmeq->q_db);
>   	nvmeq->sq_tail = tail;

What Keith said (this should not happen), and additionally, this won't 
work for a polled CQ without a vector.

-- 
Jens Axboe
