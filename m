From: hare@suse.de (Hannes Reinecke)
Date: Tue, 24 Oct 2017 09:25:06 +0200
Subject: [PATCH 12/17] nvme: check for a live controller in nvme_dev_open
In-Reply-To: <20171023145126.2471-13-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-13-hch@lst.de>
Message-ID: <8939bd97-0127-2f15-d243-c110f0e219cf@suse.de>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> This is a much more sensible check than just the admin queue.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Sagi Grimberg <sagi at rimbeg.me>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a56a1e0432e7..df525ab42fcd 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1891,7 +1891,7 @@ static int nvme_dev_open(struct inode *inode, struct file *file)
>  	struct nvme_ctrl *ctrl =
>  		container_of(inode->i_cdev, struct nvme_ctrl, cdev);
>  
> -	if (!ctrl->admin_q)
> +	if (ctrl->state != NVME_CTRL_LIVE)
>  		return -EWOULDBLOCK;
>  	file->private_data = ctrl;
>  	return 0;
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
