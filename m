From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Sun, 27 Sep 2015 10:19:31 +0300
Subject: [PATCH 2/4] nvme: split pci specifics out of nvme_dev and
 nvme_queue structures
In-Reply-To: <1443318691.4357.36.camel@linux.intel.com>
References: <1443318691.4357.36.camel@linux.intel.com>
Message-ID: <56079883.2070904@dev.mellanox.co.il>


> +struct nvme_dev {
> +	struct list_head node;
> +	void *context;
> +	struct nvme_queue **queues;
> +	struct request_queue *admin_q;
> +	struct blk_mq_tag_set tagset;
> +	struct blk_mq_tag_set admin_tagset;
> +	struct device *dev;
> +	struct dma_pool *prp_page_pool;
> +	struct dma_pool *prp_small_pool;
> +	int instance;
> +	unsigned queue_count;
> +	unsigned online_queues;
> +	unsigned max_qid;
> +	int q_depth;
> +	struct list_head namespaces;
> +	struct kref kref;
> +	struct device *device;
> +	work_func_t reset_workfn;
> +	struct work_struct reset_work;
> +	struct work_struct probe_work;
> +	struct work_struct scan_work;
> +	char name[12];
> +	char serial[20];
> +	char model[40];
> +	char firmware_rev[8];

Are serial, model, firmware_rev applicable for
non-pcie fabrics?
