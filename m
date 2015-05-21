From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 21 May 2015 13:45:33 -0700
Subject: [PATCHv1] NVMe: nvme_queue made cache friendly.
In-Reply-To: <1432154627-12336-1-git-send-email-parav.pandit@avagotech.com>
References: <1432154627-12336-1-git-send-email-parav.pandit@avagotech.com>
Message-ID: <1432241133.2454.53.camel@jpfreyen-mobl5.amr.corp.intel.com>

On Wed, 2015-05-20@16:43 -0400, Parav Pandit wrote:
> nvme_queue structure made 64B cache friendly so that majority of the
> data elements of the structure during IO and completion path can be
> found in typical single 64B cache line size which was previously spanning
> beyond single 64B cache line size.
> 
> By aligning most of the fields are found at start of the structure.
> Elements which are not used in frequent IO path are moved at the
> end of structure.

I'll repeat the same question Matthew said last time:

"Have you done any performance measurements on this?"

If the answer is no, then I'm not sure why the patch is even being sent
to apply to the code base if the main reason is performance-related.
>From the comments from the last patch attempt, it did not even sound
like there was a good understanding where the q_lock should go for best
performance.

I think it would be better to have some results to go along with the
patch request.  At least it would be known for sure where the q_lock
should go.  And that would be good knowledge to know for future
programming projects.

> 
> Signed-off-by: Parav Pandit <parav.pandit at avagotech.com>
> ---
>  drivers/block/nvme-core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index b9ba36f..58041c7 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -98,23 +98,23 @@ struct async_cmd_info {
>  struct nvme_queue {
>  	struct device *q_dmadev;
>  	struct nvme_dev *dev;
> -	char irqname[24];	/* nvme4294967295-65535\0 */
> -	spinlock_t q_lock;
>  	struct nvme_command *sq_cmds;
> +	struct blk_mq_hw_ctx *hctx;
>  	volatile struct nvme_completion *cqes;
> -	dma_addr_t sq_dma_addr;
> -	dma_addr_t cq_dma_addr;
>  	u32 __iomem *q_db;
> +	spinlock_t q_lock;
>  	u16 q_depth;
> -	s16 cq_vector;
>  	u16 sq_head;
>  	u16 sq_tail;
>  	u16 cq_head;
>  	u16 qid;
> +	s16 cq_vector;
>  	u8 cq_phase;
>  	u8 cqe_seen;
>  	struct async_cmd_info cmdinfo;
> -	struct blk_mq_hw_ctx *hctx;
> +	char irqname[24];	/* nvme4294967295-65535\0 */
> +	dma_addr_t sq_dma_addr;
> +	dma_addr_t cq_dma_addr;
>  };
>  
>  /*
