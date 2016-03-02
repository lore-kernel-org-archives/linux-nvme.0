From: axboe@fb.com (Jens Axboe)
Date: Wed, 2 Mar 2016 13:01:08 -0700
Subject: [PATCH 1/5] nvme: also set BLK_MQ_F_SHOULD_MERGE for the admin
 queue
In-Reply-To: <1456938434-20387-2-git-send-email-hch@lst.de>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-2-git-send-email-hch@lst.de>
Message-ID: <56D74684.8040902@fb.com>

On 03/02/2016 10:07 AM, Christoph Hellwig wrote:
> There is no reason to treat the admin queue different in terms of
> request merging.
>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reported-by: Jeff Lien <Jeff.Lien at hgst.com>
> Tested-by: Jeff Lien <Jeff.Lien at hgst.com>
> ---
>   drivers/nvme/host/pci.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 680f578..19be56a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1289,6 +1289,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
>   		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
>   		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
>   		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
> +		dev->admin_tagset.flags = BLK_MQ_F_SHOULD_MERGE;
>   		dev->admin_tagset.driver_data = dev;
>
>   		if (blk_mq_alloc_tag_set(&dev->admin_tagset))

Agree with Keith and others that his doesn't make a lot of sense. It's 
not that it'll break anything, but it won't change anything either.

I've applied 2-5/5 to for-linus. I guess that's one more day or not 
shipping to Linus...

-- 
Jens Axboe
