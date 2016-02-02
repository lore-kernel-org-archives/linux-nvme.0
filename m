From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Tue, 2 Feb 2016 07:15:57 +0000
Subject: [PATCH] NVMe: do not touch sq door bell if nvmeq has been
 suspended
In-Reply-To: <56AF8DB5.70206@fb.com>
References: <1454341324-21273-1-git-send-email-mail_weber_wang@163.com>
 <56AF8DB5.70206@fb.com>
Message-ID: <BJXPR01MB19940BA759DBBADC6BF6BD2E0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>

Jens,

I did the following test to validate the issue.

1. Modify code as below to increase the chance of races.
	Add 10s delay after nvme_dev_unmap() in nvme_dev_disable()
	Add 10s delay before __nvme_submit_cmd()
2. Run dd and at the same time, echo 1 to reset_controller to trigger device reset. Finally kernel crashes due to accessing unmapped door bell register.

Following is the execution order of the two code paths:
__blk_mq_run_hw_queue
  Test BLK_MQ_S_STOPPED
					nvme_dev_disable()
					     nvme_stop_queues()  <-- set BLK_MQ_S_STOPPED
					     nvme_dev_unmap(dev)  <-- unmap door bell
  nvme_queue_rq()
      Touch door bell	<-- panic here

-----Original Message-----
From: Jens Axboe [mailto:axboe@fb.com] 
Sent: Tuesday, February 2, 2016 12:54 AM
To: Wenbo Wang; keith.busch at intel.com
Cc: linux-kernel at vger.kernel.org; Wenbo Wang; linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: do not touch sq door bell if nvmeq has been suspended

On 02/01/2016 08:42 AM, Wenbo Wang wrote:
> If __nvme_submit_cmd races with nvme_dev_disable, nvmeq could have 
> been suspended and dev->bar could have been unmapped. Do not touch sq 
> door bell in this case.
>
> Signed-off-by: Wenbo Wang <wenbo.wang at memblaze.com>
> Reviewed-by: Wenwei Tao <wenwei.tao at memblaze.com>
> CC: linux-nvme at lists.infradead.org
> ---
>   drivers/nvme/host/pci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index 
> 8b1a725..2288712 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -325,7 +325,8 @@ static void __nvme_submit_cmd(struct nvme_queue 
> *nvmeq,
>
>   	if (++tail == nvmeq->q_depth)
>   		tail = 0;
> -	writel(tail, nvmeq->q_db);
> +	if (likely(nvmeq->cq_vector >= 0))
> +		writel(tail, nvmeq->q_db);
>   	nvmeq->sq_tail = tail;

What Keith said (this should not happen), and additionally, this won't work for a polled CQ without a vector.

--
Jens Axboe
