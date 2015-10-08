From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 8 Oct 2015 18:47:20 +0300
Subject: [PATCH 2/8] NVMe: Namespace removal simplifications
In-Reply-To: <1443879587-23553-3-git-send-email-hch@lst.de>
References: <1443879587-23553-1-git-send-email-hch@lst.de>
 <1443879587-23553-3-git-send-email-hch@lst.de>
Message-ID: <56169008.3000604@dev.mellanox.co.il>

On 10/3/2015 4:39 PM, Christoph Hellwig wrote:
> From: Keith Busch <keith.busch at intel.com>
>
> This liberates namespace removal from the device, allowing gendisk
> references to be closed independent of the nvme controller reference
> count.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/block/nvme-core.c | 42 ++++++++++--------------------------------
>   1 file changed, 10 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index b02ae3d..904b54f 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -1943,6 +1943,7 @@ static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
>   #define nvme_compat_ioctl	NULL
>   #endif
>
> +static void nvme_free_dev(struct kref *kref);
>   static void nvme_free_ns(struct kref *kref)
>   {
>   	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
> @@ -1951,6 +1952,7 @@ static void nvme_free_ns(struct kref *kref)
>   	ns->disk->private_data = NULL;
>   	spin_unlock(&dev_list_lock);
>
> +	kref_put(&ns->dev->kref, nvme_free_dev);
>   	put_disk(ns->disk);
>   	kfree(ns);
>   }
> @@ -1966,22 +1968,14 @@ static int nvme_open(struct block_device *bdev, fmode_t mode)
>   		ret = -ENXIO;
>   	else if (!kref_get_unless_zero(&ns->kref))
>   		ret = -ENXIO;
> -	else if (!kref_get_unless_zero(&ns->dev->kref)) {
> -		kref_put(&ns->kref, nvme_free_ns);
> -		ret = -ENXIO;
> -	}

And this fixes the last patch. I would suggest fixing the former though
for bisect-ability.
