From: hch@lst.de (Christoph Hellwig)
Date: Wed, 3 Oct 2018 14:43:48 +0200
Subject: [PATCH] nvme: take node locality into account when selecting a
 path
In-Reply-To: <a033c3a2-b825-4d9a-e844-adddea2e155f@suse.de>
References: <20180927230557.29444-1-hch@lst.de>
 <8b06c066-3a9a-84e6-2439-159d12ed64a2@grimberg.me>
 <20180930230144.GB20144@lst.de>
 <0a7f50ea-9da7-e9f1-8341-675db3bab396@grimberg.me>
 <4d6336da-9441-fd97-b716-ec219489175a@suse.de>
 <20181002173924.GA19808@lst.de>
 <a033c3a2-b825-4d9a-e844-adddea2e155f@suse.de>
Message-ID: <20181003124348.GA10981@lst.de>

Yes, something like that.  Let me know when this passes some basic
FC and RDMA testing and we can merge it.

On Wed, Oct 03, 2018@10:56:12AM +0200, Hannes Reinecke wrote:
> On 10/2/18 7:39 PM, Christoph Hellwig wrote:
>> On Tue, Oct 02, 2018@07:30:02PM +0200, Hannes Reinecke wrote:
>>>> Fair enough... I can follow up on that.
>>>>
>>> Something like this?
>>
>> As ?aid I'd rather avoid the indirect call if at all possible.
>>
>> Please either add a numa_id field to struct nvme_ctrl, or a
>> locality_dev or something.
>>
> Ah. So that should be more like it.
>
> Cheers,
>
> Hannes
>
>

> >From 478db61eab3f7a178a0c1f2e5c88c742cf5006ab Mon Sep 17 00:00:00 2001
> From: Hannes Reinecke <hare at suse.com>
> Date: Wed, 3 Oct 2018 10:53:05 +0200
> Subject: [PATCH] nvme: NUMA locality information for fabrics
> 
> Add a new field 'node_id' to the nvme_ctrl structure to hold the
> NUMA locality information of the underlying hardware.
> With that we can allocate the memory structures on the same NUMA
> node as the underlying hardware.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/core.c      | 2 +-
>  drivers/nvme/host/fc.c        | 5 +++--
>  drivers/nvme/host/multipath.c | 4 ++--
>  drivers/nvme/host/nvme.h      | 1 +
>  drivers/nvme/host/pci.c       | 1 +
>  drivers/nvme/host/rdma.c      | 6 +++---
>  6 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 2db33a752e2b..0ec56e4916ea 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3055,7 +3055,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	struct gendisk *disk;
>  	struct nvme_id_ns *id;
>  	char disk_name[DISK_NAME_LEN];
> -	int node = dev_to_node(ctrl->dev), flags = GENHD_FL_EXT_DEVT;
> +	int node = ctrl->node_id, flags = GENHD_FL_EXT_DEVT;
>  
>  	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
>  	if (!ns)
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 9d201b35397d..7f246dd04bc5 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2422,7 +2422,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
>  	ctrl->tag_set.ops = &nvme_fc_mq_ops;
>  	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
>  	ctrl->tag_set.reserved_tags = 1; /* fabric connect */
> -	ctrl->tag_set.numa_node = NUMA_NO_NODE;
> +	ctrl->tag_set.numa_node = ctrl->ctrl.node_id;
>  	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
>  	ctrl->tag_set.cmd_size = sizeof(struct nvme_fc_fcp_op) +
>  					(SG_CHUNK_SIZE *
> @@ -2990,6 +2990,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>  
>  	ctrl->ctrl.opts = opts;
>  	ctrl->ctrl.nr_reconnects = 0;
> +	ctrl->ctrl.node_id = dev_to_node(lport->dev);
>  	INIT_LIST_HEAD(&ctrl->ctrl_list);
>  	ctrl->lport = lport;
>  	ctrl->rport = rport;
> @@ -3028,7 +3029,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>  	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
>  	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
>  	ctrl->admin_tag_set.reserved_tags = 2; /* fabric connect + Keep-Alive */
> -	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
> +	ctrl->admin_tag_set.numa_node = ctrl->ctrl.node_id;
>  	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_fc_fcp_op) +
>  					(SG_CHUNK_SIZE *
>  						sizeof(struct scatterlist)) +
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 31f29f97374b..2616251b3236 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -141,7 +141,7 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
>  		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
>  			continue;
>  
> -		distance = node_distance(node, dev_to_node(ns->ctrl->dev));
> +		distance = node_distance(node, ns->ctrl->node_id);
>  
>  		switch (ns->ana_state) {
>  		case NVME_ANA_OPTIMIZED:
> @@ -276,7 +276,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>  	if (!(ctrl->subsys->cmic & (1 << 1)) || !multipath)
>  		return 0;
>  
> -	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
> +	q = blk_alloc_queue_node(GFP_KERNEL, ctrl->node_id, NULL);
>  	if (!q)
>  		goto out;
>  	q->queuedata = head;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 9fefba039d1e..55347a547d84 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -153,6 +153,7 @@ struct nvme_ctrl {
>  	struct request_queue *connect_q;
>  	struct device *dev;
>  	int instance;
> +	int node_id;
>  	struct blk_mq_tag_set *tagset;
>  	struct blk_mq_tag_set *admin_tagset;
>  	struct list_head namespaces;
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
>  
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index dc042017c293..a64b02c13934 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -686,7 +686,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
>  		set->ops = &nvme_rdma_admin_mq_ops;
>  		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
>  		set->reserved_tags = 2; /* connect + keep-alive */
> -		set->numa_node = NUMA_NO_NODE;
> +		set->numa_node = nctrl->node_id;
>  		set->cmd_size = sizeof(struct nvme_rdma_request) +
>  			SG_CHUNK_SIZE * sizeof(struct scatterlist);
>  		set->driver_data = ctrl;
> @@ -699,7 +699,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
>  		set->ops = &nvme_rdma_mq_ops;
>  		set->queue_depth = nctrl->sqsize + 1;
>  		set->reserved_tags = 1; /* fabric connect */
> -		set->numa_node = NUMA_NO_NODE;
> +		set->numa_node = nctrl->node_id;
>  		set->flags = BLK_MQ_F_SHOULD_MERGE;
>  		set->cmd_size = sizeof(struct nvme_rdma_request) +
>  			SG_CHUNK_SIZE * sizeof(struct scatterlist);
> @@ -1975,7 +1975,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>  	ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
>  	ctrl->ctrl.sqsize = opts->queue_size - 1;
>  	ctrl->ctrl.kato = opts->kato;
> -
> +	ctrl->ctrl.node_id = NUMA_NO_NODE;
>  	ret = -ENOMEM;
>  	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
>  				GFP_KERNEL);
> -- 
> 2.13.7
> 

---end quoted text---
