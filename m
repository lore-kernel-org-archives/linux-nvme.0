From: keith.busch@intel.com (Keith Busch)
Date: Mon, 8 Oct 2018 15:58:43 -0600
Subject: [PATCH 05/16] nvme-pci: Fix nvme_suspend_queue() kernel-doc header
In-Reply-To: <20181008212854.68310-6-bvanassche@acm.org>
References: <20181008212854.68310-1-bvanassche@acm.org>
 <20181008212854.68310-6-bvanassche@acm.org>
Message-ID: <20181008215842.GB5926@localhost.localdomain>

On Mon, Oct 08, 2018@02:28:43PM -0700, Bart Van Assche wrote:
> This patch avoids that the kernel-doc tool complains about the
> nvme_suspend_queue() function header when building with W=1.
> 
> Signed-off-by: Bart Van Assche <bvanassche at acm.org>

Looks fine.

Reviewed-by: Keith Busch <keith.busch at intel.com>

> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d668682f91df..450481c2fd17 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1249,7 +1249,7 @@ static void nvme_free_queues(struct nvme_dev *dev, int lowest)
>  
>  /**
>   * nvme_suspend_queue - put queue into suspended state
> - * @nvmeq - queue to suspend
> + * @nvmeq: queue to suspend
>   */
>  static int nvme_suspend_queue(struct nvme_queue *nvmeq)
>  {
> -- 
> 2.19.0.605.g01d371f741-goog
> 
