From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 17 Jul 2019 20:51:45 +0900
Subject: [PATCH v2 2/3] nvme-pci: Add support for variable IO SQ element
 size
In-Reply-To: <20190717004527.30363-2-benh@kernel.crashing.org>
References: <20190717004527.30363-1-benh@kernel.crashing.org>
 <20190717004527.30363-2-benh@kernel.crashing.org>
Message-ID: <20190717115145.GB10495@minwoo-desktop>

On 19-07-17 10:45:26, Benjamin Herrenschmidt wrote:
> The size of a submission queue element should always be 6 (64 bytes)
> by spec.
> 
> However some controllers such as Apple's are not properly implementing
> the standard and require a different size.
> 
> This provides the ground work for the subsequent quirks for these
> controllers.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh at kernel.crashing.org>
> ---
>  drivers/nvme/host/pci.c | 11 ++++++++---
>  include/linux/nvme.h    |  1 +
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8f006638452b..1637677afb78 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -28,7 +28,7 @@
>  #include "trace.h"
>  #include "nvme.h"
>  
> -#define SQ_SIZE(q)	((q)->q_depth * sizeof(struct nvme_command))
> +#define SQ_SIZE(q)	((q)->q_depth << (q)->sqes)
>  #define CQ_SIZE(q)	((q)->q_depth * sizeof(struct nvme_completion))
>  
>  #define SGES_PER_PAGE	(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
> @@ -100,6 +100,7 @@ struct nvme_dev {
>  	unsigned io_queues[HCTX_MAX_TYPES];
>  	unsigned int num_vecs;
>  	int q_depth;
> +	int io_sqes;
>  	u32 db_stride;
>  	void __iomem *bar;
>  	unsigned long bar_mapped_size;
> @@ -162,7 +163,7 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
>  struct nvme_queue {
>  	struct nvme_dev *dev;
>  	spinlock_t sq_lock;
> -	struct nvme_command *sq_cmds;
> +	void *sq_cmds;

It would be great if it can remain the existing data type for the
SQEs...  But I'm fine with this also.

It looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>

Thanks,
