From: hch@lst.de (Christoph Hellwig)
Date: Mon, 13 Feb 2017 14:53:08 +0100
Subject: [PATCH 3/5] nvme/core: Fix race kicking freed request_queue
In-Reply-To: <1486768553-13738-4-git-send-email-keith.busch@intel.com>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-4-git-send-email-keith.busch@intel.com>
Message-ID: <20170213135308.GC23832@lst.de>

On Fri, Feb 10, 2017@06:15:51PM -0500, Keith Busch wrote:
> If a namespace has already been marked dead, we don't want to kick the
> request_queue again since we may have just freed it from another thread.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index de80a84..c302270 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2114,9 +2114,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>  		 * Revalidating a dead namespace sets capacity to 0. This will
>  		 * end buffered writers dirtying pages that can't be synced.
>  		 */
> -		if (ns->disk && !test_and_set_bit(NVME_NS_DEAD, &ns->flags))
> -			revalidate_disk(ns->disk);
> -
> +		if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
> +			continue;

I think the comment above needs to be modified or removed.  Except
for this the patch looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
