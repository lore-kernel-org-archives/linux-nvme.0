From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Wed, 2 Mar 2016 19:35:56 +0200
Subject: [PATCH 1/5] nvme: also set BLK_MQ_F_SHOULD_MERGE for the admin
 queue
In-Reply-To: <1456938434-20387-2-git-send-email-hch@lst.de>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-2-git-send-email-hch@lst.de>
Message-ID: <56D7247C.4000208@dev.mellanox.co.il>


> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 680f578..19be56a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1289,6 +1289,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
>   		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
>   		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
>   		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
> +		dev->admin_tagset.flags = BLK_MQ_F_SHOULD_MERGE;

I still don't understand what's the point?
