From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 5 Oct 2016 15:26:20 +0200
Subject: [PATCH rfc 2/6] nvme-pci: Add budget to __nvme_process_cq
In-Reply-To: <1475660534-16681-3-git-send-email-sagi@grimberg.me>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <1475660534-16681-3-git-send-email-sagi@grimberg.me>
Message-ID: <20161005132620.jscesmyrkfgj5ffc@linux-x5ow.site>

On Wed, Oct 05, 2016@12:42:10PM +0300, Sagi Grimberg wrote:
> Prepare for irq-poll logic where we budget the completion queue
> processing context.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/pci.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 1d8b35a319d0..85bfd76fbee9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -705,7 +705,7 @@ static inline int nvme_read_cqe(struct nvme_queue *nvmeq,
>  	return 0;
>  }
>  
> -static int __nvme_process_cq(struct nvme_queue *nvmeq, int *tag)
> +static int __nvme_process_cq(struct nvme_queue *nvmeq, int budget, int *tag)
>  {
>  	struct nvme_completion cqe;
>  	int consumed = 0;
> @@ -713,6 +713,9 @@ static int __nvme_process_cq(struct nvme_queue *nvmeq, int *tag)
>  	while (nvme_read_cqe(nvmeq, &cqe)) {
>  		nvme_handle_cqe(nvmeq, &cqe);
>  
> +		if (++consumed == budget)
> +			break;
> +

Ah here it is. Wouldn't it make sense to add a ++consumed dummy statement in
the previous patch (or maybe even a 'if (++consumed == INT_MAX) break;')? Just
a suggestion.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
