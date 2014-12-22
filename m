From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 22 Dec 2014 10:15:21 -0500
Subject: [PATCH 3/4] NVMe: Fix double free irq
In-Reply-To: <1419036856-16275-4-git-send-email-keith.busch@intel.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
 <1419036856-16275-4-git-send-email-keith.busch@intel.com>
Message-ID: <20141222151521.GI2220@wil.cx>

On Fri, Dec 19, 2014@05:54:15PM -0700, Keith Busch wrote:
> Sets the vector to an invalid value after it's freed so we don't free
> it twice.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/block/nvme-core.c |   19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index b1d5d87..9642c83 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -106,7 +106,7 @@ struct nvme_queue {
>  	dma_addr_t cq_dma_addr;
>  	u32 __iomem *q_db;
>  	u16 q_depth;
> -	u16 cq_vector;
> +	int cq_vector;

If you're going to change its size, can you move it up one slot so as
to not leave a hole?  The 'pahole' tool can tell you when there are holes
in structures.
