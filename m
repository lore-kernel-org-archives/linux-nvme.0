From: axboe@fb.com (Jens Axboe)
Date: Tue, 8 Mar 2016 10:41:10 -0700
Subject: [PATCH 2/2] NVMe: Remove unused sq_head read in completion path
In-Reply-To: <1457458494-10550-3-git-send-email-jonathan.derrick@intel.com>
References: <1457458494-10550-1-git-send-email-jonathan.derrick@intel.com>
 <1457458494-10550-3-git-send-email-jonathan.derrick@intel.com>
Message-ID: <56DF0EB6.1000901@fb.com>

On 03/08/2016 10:34 AM, Jon Derrick wrote:
> Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
> ---
>   drivers/nvme/host/pci.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 74514c7..e9f18e1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -134,7 +134,6 @@ struct nvme_queue {
>   	u32 __iomem *q_db;
>   	u16 q_depth;
>   	s16 cq_vector;
> -	u16 sq_head;
>   	u16 sq_tail;
>   	u16 cq_head;
>   	u16 qid;
> @@ -719,7 +718,6 @@ static void __nvme_process_cq(struct nvme_queue *nvmeq, unsigned int *tag)
>
>   		if ((status & 1) != phase)
>   			break;
> -		nvmeq->sq_head = le16_to_cpu(cqe.sq_head);
>   		if (++head == nvmeq->q_depth) {
>   			head = 0;
>   			phase = !phase;

This seems like a no-brainer, good spotting.

-- 
Jens Axboe
