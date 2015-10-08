From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 8 Oct 2015 18:43:20 +0300
Subject: [PATCH 1/8] NVMe: Reference count open namespaces
In-Reply-To: <1443879587-23553-2-git-send-email-hch@lst.de>
References: <1443879587-23553-1-git-send-email-hch@lst.de>
 <1443879587-23553-2-git-send-email-hch@lst.de>
Message-ID: <56168F18.5070207@dev.mellanox.co.il>

On 10/3/2015 4:39 PM, Christoph Hellwig wrote:
> From: Keith Busch <keith.busch at intel.com>
>
> Dynamic namespace attachment means the namespace may be removed at any
> time, so the namespace reference count can not be tied to the device
> reference count. This fixes a NULL dereference if an opened namespace
> is detached from a controller.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/block/nvme-core.c | 29 ++++++++++++++++++++---------
>   include/linux/nvme.h      |  1 +
>   2 files changed, 21 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index 6f04771..b02ae3d 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1943,6 +1943,18 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
>   #define nvme_compat_ioctl	NULL
>   #endif
>
> +static void nvme_free_ns(struct kref *kref)
> +{
> +	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
> +
> +	spin_lock(&dev_list_lock);
> +	ns->disk->private_data = NULL;
> +	spin_unlock(&dev_list_lock);
> +
> +	put_disk(ns->disk);
> +	kfree(ns);
> +}
> +
>   static int nvme_open(struct block_device *bdev, fmode_t mode)
>   {
>   	int ret = 0;
> @@ -1952,21 +1964,25 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
>   	ns = bdev->bd_disk->private_data;
>   	if (!ns)
>   		ret = -ENXIO;
> -	else if (!kref_get_unless_zero(&ns->dev->kref))
> +	else if (!kref_get_unless_zero(&ns->kref))
>   		ret = -ENXIO;
> +	else if (!kref_get_unless_zero(&ns->dev->kref)) {
> +		kref_put(&ns->kref, nvme_free_ns);

Is this calling nvme_free_ns with dev_list_lock taken?

> +		ret = -ENXIO;
> +	}
>   	spin_unlock(&dev_list_lock);
