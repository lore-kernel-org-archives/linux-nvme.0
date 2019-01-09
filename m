From: hch@lst.de (Christoph Hellwig)
Date: Wed, 9 Jan 2019 19:39:20 +0100
Subject: [PATCH] nvme: fix out of bounds access in nvme_cqe_pending
In-Reply-To: <1546827727-49635-1-git-send-email-yaohongbo@huawei.com>
References: <1546827727-49635-1-git-send-email-yaohongbo@huawei.com>
Message-ID: <20190109183920.GA22070@lst.de>

On Mon, Jan 07, 2019@10:22:07AM +0800, Hongbo Yao wrote:
> There is an out of bounds array access in nvme_cqe_peding().
> 
> When enable irq_thread for nvme interrupt, there is racing between the
> nvmeq->cq_head updating and reading.

Just curious: why did you enable this option?  Do you have a workload
where it matters?

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d668682..68375d4 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -908,9 +908,11 @@ static void nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
>  
>  static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
>  {
> -	if (++nvmeq->cq_head == nvmeq->q_depth) {
> +	if (nvmeq->cq_head == (nvmeq->q_depth - 1)) {
>  		nvmeq->cq_head = 0;
>  		nvmeq->cq_phase = !nvmeq->cq_phase;
> +	} else {
> +		++nvmeq->cq_head;

No need for the braces above, but otherwise this looks fine.  I'll apply
it to nvme-4.21.
