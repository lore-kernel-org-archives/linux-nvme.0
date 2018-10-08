From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Oct 2018 12:04:23 +0200
Subject: [PATCH 1/2] nvme: NUMA locality information for fabrics
In-Reply-To: <20181005092915.126636-2-hare@suse.de>
References: <20181005092915.126636-1-hare@suse.de>
 <20181005092915.126636-2-hare@suse.de>
Message-ID: <20181008100423.GA6686@lst.de>

> @@ -3055,7 +3057,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	struct gendisk *disk;
>  	struct nvme_id_ns *id;
>  	char disk_name[DISK_NAME_LEN];
> -	int node = dev_to_node(ctrl->dev), flags = GENHD_FL_EXT_DEVT;
> +	int node = ctrl->node_id, flags = GENHD_FL_EXT_DEVT;

I think we can just kill the local node variable now.

> @@ -276,7 +276,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  	if (!(ctrl->subsys->cmic & (1 << 1)) || !multipath)
>  		return 0;
>  
> -	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
> +	q = blk_alloc_queue_node(GFP_KERNEL, ctrl->node_id, NULL);

This looks a little odd.  We create the mpath disk here, and just
need to pass in the ctrl to do some initialization.  Why would be
allocate the multipath node on the node of the controller?

If there is a good reason it needs to go into a comment, if not
we should drop this hunk.

> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d668682f91df..b5d37aacf212 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2517,6 +2517,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
>  
> +	dev->ctrl.node_id = node;
>  	nvme_get_ctrl(&dev->ctrl);
>  	async_schedule(nvme_async_probe, dev);

This changes behavior as node might remain NUMA_NO_NODE when the code
above sets the device node to first_memory_node now when
it would otherwise be NUMA_NO_NODE.  Then again that code makes no
sense to me to start with - Matias added it with the blk-mq conversion,
so maybe he remembers why we do it to start with?  If we want to fix
up nodes like that it seems like we should do it in the driver core
or the PCI core.
