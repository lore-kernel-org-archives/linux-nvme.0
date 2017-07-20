From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 20 Jul 2017 12:03:37 +0300
Subject: [PATCH v2 2/2] nvme-pci: add sgl support
In-Reply-To: <20170720002420.26408-3-chaitanya.kulkarni@hgst.com>
References: <20170720002420.26408-1-chaitanya.kulkarni@hgst.com>
 <20170720002420.26408-3-chaitanya.kulkarni@hgst.com>
Message-ID: <ddd20dba-93db-43ef-e31d-b363c5ed186a@mellanox.com>



On 7/20/2017 3:24 AM, Chaitanya Kulkarni wrote:
> This adds SGL support for NVMe PCIe driver, based on an earlier patch
> from Rajiv Shanmugam Madeswaran <smrajiv15 at gmail.com>.  The usage of
> SGLs is controlled by the sgl_threshold module parameter, which allows
> to conditionally use SGLs based on the I/O size. It defaults to 32k
> as that is the size where the test hardware showed clear benefits
> when using SGLs. For SGL enabled PCI controller we clear the
> virt_boundary flag.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at hgst.com>
> ---
>  drivers/nvme/host/pci.c | 226 +++++++++++++++++++++++++++++++++++++++++-------
>  include/linux/nvme.h    |   2 +
>  2 files changed, 199 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index be0d8f5..a6a0716 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -44,6 +44,8 @@
>   */
>  #define NVME_AQ_BLKMQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AERS)
>
> +#define SGES_PER_PAGE		(PAGE_SIZE / sizeof(struct nvme_sgl_desc))
> +
>  static int use_threaded_interrupts;
>  module_param(use_threaded_interrupts, int, 0);
>
> @@ -56,6 +58,10 @@ module_param(max_host_mem_size_mb, uint, 0444);
>  MODULE_PARM_DESC(max_host_mem_size_mb,
>  	"Maximum Host Memory Buffer (HMB) size per controller (in MiB)");
>
> +static unsigned int sgl_threshold = 32 * 1024;

please use SZ_32K

> +module_param(sgl_threshold, uint, 0644);
> +MODULE_PARM_DESC(sgl_threshold, "use SGL for I/O larger or equal to this size");
> +
>  static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
>  static const struct kernel_param_ops io_queue_depth_ops = {
>  	.set = io_queue_depth_set,
> @@ -176,6 +182,7 @@ struct nvme_queue {
>  struct nvme_iod {
>  	struct nvme_request req;
>  	struct nvme_queue *nvmeq;
> +	bool use_sgl;
>  	int aborted;
>  	int npages;		/* In the PRP list. 0 means small pool in use */
>  	int nents;		/* Used in scatterlist */
> @@ -329,17 +336,33 @@ static int nvme_npages(unsigned size, struct nvme_dev *dev)
>  	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
>  }
>
> +/*
> + * Calculates the number of pages needed for the SGL segments. For example a 4k
> + * page can accommodate 256 SGL descriptors.
> + */
> +static int nvme_npages_sgl(unsigned int num_seg)
> +{
> +	return DIV_ROUND_UP(num_seg * sizeof(struct nvme_sgl_desc), PAGE_SIZE);
> +}
> +
>  static unsigned int nvme_iod_alloc_size(struct nvme_dev *dev,
> -		unsigned int size, unsigned int nseg)
> +		unsigned int size, unsigned int nseg, bool use_sgl)
>  {
> -	return sizeof(__le64 *) * nvme_npages(size, dev) +
> -			sizeof(struct scatterlist) * nseg;
> +	size_t alloc_size;
> +
> +	if (use_sgl)
> +		alloc_size = sizeof(__le64 *) * nvme_npages_sgl(nseg);
> +	else
> +		alloc_size = sizeof(__le64 *) * nvme_npages(size, dev);
> +
> +	return alloc_size + sizeof(struct scatterlist) * nseg;
>  }
>
> -static unsigned int nvme_cmd_size(struct nvme_dev *dev)
> +static unsigned int nvme_cmd_size(struct nvme_dev *dev, bool use_sgl)
>  {
>  	return sizeof(struct nvme_iod) +
> -		nvme_iod_alloc_size(dev, NVME_INT_BYTES(dev), NVME_INT_PAGES);
> +		nvme_iod_alloc_size(dev, NVME_INT_BYTES(dev), NVME_INT_PAGES,
> +				use_sgl);
>  }
>
>  static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> @@ -423,10 +446,10 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
>  	nvmeq->sq_tail = tail;
>  }
>
> -static __le64 **iod_list(struct request *req)
> +static void **iod_list(struct request *req)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -	return (__le64 **)(iod->sg + blk_rq_nr_phys_segments(req));
> +	return (void **)(iod->sg + blk_rq_nr_phys_segments(req));
>  }
>
>  static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
> @@ -436,9 +459,9 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
>  	unsigned int size = blk_rq_payload_bytes(rq);
>
>  	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
> -		iod->sg = kmalloc(nvme_iod_alloc_size(dev, size, nseg), GFP_ATOMIC);
> -		if (!iod->sg)
> -			return BLK_STS_RESOURCE;
> +		size_t alloc_size =
> +			nvme_iod_alloc_size(dev, size, nseg, iod->use_sgl);
> +		iod->sg = kmalloc(alloc_size, GFP_ATOMIC);
>  	} else {
>  		iod->sg = iod->inline_sg;
>  	}
> @@ -453,19 +476,30 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
>
>  static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
>  {
> +	const int last_prp = dev->ctrl.page_size / sizeof(__le64) - 1;
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -	const int last_prp = dev->ctrl.page_size / 8 - 1;
> +	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
>  	int i;
> -	__le64 **list = iod_list(req);
> -	dma_addr_t prp_dma = iod->first_dma;
>
>  	if (iod->npages == 0)
> -		dma_pool_free(dev->prp_small_pool, list[0], prp_dma);
> +		dma_pool_free(dev->prp_small_pool, iod_list(req)[0], dma_addr);
> +
>  	for (i = 0; i < iod->npages; i++) {
> -		__le64 *prp_list = list[i];
> -		dma_addr_t next_prp_dma = le64_to_cpu(prp_list[last_prp]);
> -		dma_pool_free(dev->prp_page_pool, prp_list, prp_dma);
> -		prp_dma = next_prp_dma;
> +		void *addr = iod_list(req)[i];
> +
> +		if (iod->use_sgl) {
> +			struct nvme_sgl_desc *sg_list = addr;
> +
> +			next_dma_addr =
> +				le64_to_cpu((sg_list[SGES_PER_PAGE - 1]).addr);
> +		} else {
> +			__le64 *prp_list = addr;
> +
> +			next_dma_addr = le64_to_cpu(prp_list[last_prp]);
> +		}
> +
> +		dma_pool_free(dev->prp_page_pool, addr, dma_addr);
> +		dma_addr = next_dma_addr;
>  	}
>
>  	if (iod->sg != iod->inline_sg)
> @@ -539,7 +573,8 @@ static void nvme_dif_complete(u32 p, u32 v, struct t10_pi_tuple *pi)
>  }
>  #endif
>
> -static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
> +static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req,
> +		struct nvme_rw_command *cmnd)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  	struct dma_pool *pool;
> @@ -550,13 +585,15 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
>  	u32 page_size = dev->ctrl.page_size;
>  	int offset = dma_addr & (page_size - 1);
>  	__le64 *prp_list;
> -	__le64 **list = iod_list(req);
> +	void **list = iod_list(req);
>  	dma_addr_t prp_dma;
>  	int nprps, i;
>
> +	iod->use_sgl = false;
> +
>  	length -= (page_size - offset);
>  	if (length <= 0)
> -		return true;
> +		goto done;
>
>  	dma_len -= (page_size - offset);
>  	if (dma_len) {
> @@ -569,7 +606,7 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
>
>  	if (length <= page_size) {
>  		iod->first_dma = dma_addr;
> -		return true;
> +		goto done;
>  	}
>
>  	nprps = DIV_ROUND_UP(length, page_size);
> @@ -615,6 +652,126 @@ static bool nvme_setup_prps(struct nvme_dev *dev, struct request *req)
>  		dma_len = sg_dma_len(sg);
>  	}
>
> +done:
> +	cmnd->dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
> +	cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
> +	return true;
> +}
> +
> +static void nvme_sgl_set_data(struct nvme_sgl_desc *sge, struct scatterlist *sg)
> +{
> +	sge->addr = cpu_to_le64(sg_dma_address(sg));
> +	sge->length = cpu_to_le32(sg_dma_len(sg));
> +	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
> +}
> +
> +static void nvme_sgl_set_last_seg(struct nvme_sgl_desc *sge,
> +		dma_addr_t dma_addr, int entries)
> +{
> +	sge->addr = cpu_to_le64(dma_addr);
> +	sge->length = cpu_to_le32(entries * sizeof(struct nvme_sgl_desc));
> +	sge->type = NVME_SGL_FMT_LAST_SEG_DESC << 4;
> +}
> +
> +static void nvme_sgl_set_seg(struct nvme_sgl_desc *sge, dma_addr_t dma_addr)
> +{
> +	sge->addr = cpu_to_le64(dma_addr);
> +	sge->length = cpu_to_le32(PAGE_SIZE);
> +	sge->type = NVME_SGL_FMT_SEG_DESC << 4;
> +}
> +
> +static bool nvme_setup_sgls(struct nvme_dev *dev, struct request *req,
> +		struct nvme_rw_command *cmd)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	int length = blk_rq_payload_bytes(req);
> +	struct dma_pool *pool;
> +	struct nvme_sgl_desc *sg_list;
> +	struct scatterlist *sg = iod->sg;
> +	int entries = iod->nents, i = 0;
> +	dma_addr_t sgl_dma;
> +
> +	iod->use_sgl = true;
> +
> +	cmd->flags = 1 << 6; /* setting the transfer type as SGL */

Can we use some define here instead of 6 ?

> +
> +	if (length == sg_dma_len(sg)) {
> +		nvme_sgl_set_data(&cmd->dptr.sgl, sg);
> +		return true;
> +	}
> +
> +	if (entries <= 256 / sizeof(struct nvme_sgl_desc)) {
> +		pool = dev->prp_small_pool;
> +		iod->npages = 0;
> +	} else {
> +		pool = dev->prp_page_pool;
> +		iod->npages = 1;
> +	}
> +
> +	sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
> +	if (!sg_list) {
> +		iod->npages = -1;
> +		return false;
> +	}
> +
> +	iod_list(req)[0] = sg_list;
> +	iod->first_dma = sgl_dma;
> +
> +	if (entries <= SGES_PER_PAGE) {
> +		nvme_sgl_set_last_seg(&cmd->dptr.sgl, sgl_dma, entries);
> +
> +		for (i = 0; i < entries; i++) {
> +			nvme_sgl_set_data(&sg_list[i], sg);
> +			length -= sg_dma_len(sg);
> +			sg = sg_next(sg);
> +		}
> +
> +		WARN_ON(length > 0);
> +		return true;
> +	}
> +
> +	nvme_sgl_set_seg(&cmd->dptr.sgl, sgl_dma);
> +
> +	do {
> +		if (i == SGES_PER_PAGE) {
> +			struct nvme_sgl_desc *old_sg_desc = sg_list;
> +			struct nvme_sgl_desc *link = &old_sg_desc[i - 1];
> +
> +			sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
> +			if (!sg_list)
> +				return false;
> +
> +			i = 0;
> +			iod_list(req)[iod->npages++] = sg_list;
> +			sg_list[i++] = *link;
> +
> +			if (entries < SGES_PER_PAGE)
> +				nvme_sgl_set_last_seg(link, sgl_dma, entries);
> +			else
> +				nvme_sgl_set_seg(link, sgl_dma);
> +		}
> +
> +		nvme_sgl_set_data(&sg_list[i], sg);
> +
> +		length -= sg_dma_len(sg);
> +		sg = sg_next(sg);
> +		entries--;
> +	} while (length > 0);
> +
> +	WARN_ON(entries > 0);
> +	return true;
> +}
> +
> +static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +
> +	if (!(dev->ctrl.sgls & NVME_CTRL_SUPP_SGL))
> +		return false;
> +	if (!iod->nvmeq->qid)
> +		return false;
> +	if (!sgl_threshold || blk_rq_payload_bytes(req) < sgl_threshold)
> +		return false;
>  	return true;
>  }
>
> @@ -637,8 +794,13 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  				DMA_ATTR_NO_WARN))
>  		goto out;
>
> -	if (!nvme_setup_prps(dev, req))
> -		goto out_unmap;
> +	if (nvme_pci_use_sgls(dev, req)) {
> +		if (!nvme_setup_sgls(dev, req, &cmnd->rw))
> +			goto out_unmap;
> +	} else {
> +		if (!nvme_setup_prps(dev, req, &cmnd->rw))
> +			goto out_unmap;
> +	}
>
>  	ret = BLK_STS_IOERR;
>  	if (blk_integrity_rq(req)) {
> @@ -656,8 +818,6 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  			goto out_unmap;
>  	}
>
> -	cmnd->rw.dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
> -	cmnd->rw.dptr.prp2 = cpu_to_le64(iod->first_dma);
>  	if (blk_integrity_rq(req))
>  		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(&iod->meta_sg));
>  	return BLK_STS_OK;
> @@ -1354,7 +1514,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
>  		dev->admin_tagset.queue_depth = NVME_AQ_BLKMQ_DEPTH - 1;
>  		dev->admin_tagset.timeout = ADMIN_TIMEOUT;
>  		dev->admin_tagset.numa_node = dev_to_node(dev->dev);
> -		dev->admin_tagset.cmd_size = nvme_cmd_size(dev);
> +		dev->admin_tagset.cmd_size = nvme_cmd_size(dev, false);
>  		dev->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
>  		dev->admin_tagset.driver_data = dev;
>
> @@ -1863,7 +2023,11 @@ static int nvme_dev_add(struct nvme_dev *dev)
>  		dev->tagset.numa_node = dev_to_node(dev->dev);
>  		dev->tagset.queue_depth =
>  				min_t(int, dev->q_depth, BLK_MQ_MAX_DEPTH) - 1;
> -		dev->tagset.cmd_size = nvme_cmd_size(dev);
> +		dev->tagset.cmd_size = nvme_cmd_size(dev, false);
> +		if ((dev->ctrl.sgls & NVME_CTRL_SUPP_SGL) && sgl_threshold) {
> +			dev->tagset.cmd_size = max(dev->tagset.cmd_size,
> +					nvme_cmd_size(dev, true));
> +		}
>  		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
>  		dev->tagset.driver_data = dev;
>
> @@ -2127,7 +2291,11 @@ static void nvme_reset_work(struct work_struct *work)
>  	if (result)
>  		goto out;
>
> -	dev->ctrl.virt_boundary_mask = dev->ctrl.page_size - 1;
> +	/* clear the virt_boundary_mask for SGL enabled controllers */
> +	if (dev->ctrl.sgls & NVME_CTRL_SUPP_SGL)
> +		dev->ctrl.virt_boundary_mask = 0;

I need to go throgh the prp code once again but can you explain how this 
should work for IO < sgl_threshold ? I remember Christoph mentioned that 
this work for 64K pase size systems...


> +	else
> +		dev->ctrl.virt_boundary_mask = dev->ctrl.page_size - 1;
>  	result = nvme_init_identify(&dev->ctrl);
>  	if (result)
>  		goto out;
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 6b8ee9e..d338cb5 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -446,6 +446,8 @@ enum nvme_opcode {
>  	nvme_cmd_resv_release	= 0x15,
>  };
>
> +#define NVME_CTRL_SUPP_SGL	0x1
> +
>  /*
>   * Descriptor subtype - lower 4 bits of nvme_(keyed_)sgl_desc identifier
>   *
>
