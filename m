From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 5 Oct 2017 00:52:28 -0700
Subject: [PATCH V5] nvme-pci: add SGL support
In-Reply-To: <1507164918-4749-2-git-send-email-ckulkarnilinux@gmail.com>
References: <1507164918-4749-1-git-send-email-ckulkarnilinux@gmail.com>
 <1507164918-4749-2-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <20171005075228.GA25401@infradead.org>

On Wed, Oct 04, 2017@05:55:18PM -0700, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> 
> This adds SGL support for NVMe PCIe driver, based on an earlier patch
> from Rajiv Shanmugam Madeswaran <smrajiv15 at gmail.com>. This patch
> refactors the original code and adds new module parameter sgl_threshold
> to determine whether to use SGL or PRP for IOs.
> 
> The new enum controller capability constant NVME_SGL_NOT_SUPP
> definition is used to determine whether NVMe Controller supports SGL
> mode for IOs.
> 
> The usage of SGLs is controlled by the sgl_threshold module parameter,
> which allows to conditionally use SGLs if average request segment size
> (avg_seg_size) is greater than sgl_threshold. In the original patch,
> the decision of using SGLs was dependent only on the IO size,
> with the new approach we consider not only IO size but also the
> number of physical segments present in the IO.
> 
> We calculate avg_seg_size based on request payload bytes and number
> of physical segments present in the request.
> 
> For e.g.:-
> 
> 1. blk_rq_nr_phys_segments = 2 blk_rq_payload_bytes = 8k
> avg_seg_size = 4K use sgl if avg_seg_size >= sgl_threshold.
> 
> 2. blk_rq_nr_phys_segments = 2 blk_rq_payload_bytes = 64k
> avg_seg_size = 32K use sgl if avg_seg_size >= sgl_threshold.
> 
> 3. blk_rq_nr_phys_segments = 16 blk_rq_payload_bytes = 64k
> avg_seg_size = 4K use sgl if avg_seg_size
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> ---
>  drivers/nvme/host/pci.c | 223 ++++++++++++++++++++++++++++++++++++++++++------
>  include/linux/nvme.h    |   1 +
>  2 files changed, 199 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index cb73bc8..9f66f75 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -45,6 +45,8 @@
>   */
>  #define NVME_AQ_BLKMQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AERS)
>  
> +#define SGES_PER_PAGE          (PAGE_SIZE / sizeof(struct nvme_sgl_desc))
> +
>  static int use_threaded_interrupts;
>  module_param(use_threaded_interrupts, int, 0);
>  
> @@ -57,6 +59,10 @@
>  MODULE_PARM_DESC(max_host_mem_size_mb,
>  	"Maximum Host Memory Buffer (HMB) size per controller (in MiB)");
>  
> +static unsigned int sgl_threshold = SZ_32K;
> +module_param(sgl_threshold, uint, 0644);
> +MODULE_PARM_DESC(sgl_threshold, "use SGL for I/O larger or equal to this size");
> +
>  static int io_queue_depth_set(const char *val, const struct kernel_param *kp);
>  static const struct kernel_param_ops io_queue_depth_ops = {
>  	.set = io_queue_depth_set,
> @@ -178,6 +184,7 @@ struct nvme_queue {
>  struct nvme_iod {
>  	struct nvme_request req;
>  	struct nvme_queue *nvmeq;
> +	bool use_sgl;
>  	int aborted;
>  	int npages;		/* In the PRP list. 0 means small pool in use */
>  	int nents;		/* Used in scatterlist */
> @@ -331,17 +338,32 @@ static int nvme_npages(unsigned size, struct nvme_dev *dev)
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
> +		nvme_iod_alloc_size(dev, NVME_INT_BYTES(dev), NVME_INT_PAGES, use_sgl);
>  }
>  
>  static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> @@ -425,10 +447,10 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
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
> @@ -438,7 +460,10 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
>  	unsigned int size = blk_rq_payload_bytes(rq);
>  
>  	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
> -		iod->sg = kmalloc(nvme_iod_alloc_size(dev, size, nseg), GFP_ATOMIC);
> +		size_t alloc_size = nvme_iod_alloc_size(dev, size, nseg,
> +				iod->use_sgl);
> +
> +		iod->sg = kmalloc(alloc_size, GFP_ATOMIC);
>  		if (!iod->sg)
>  			return BLK_STS_RESOURCE;
>  	} else {
> @@ -456,18 +481,29 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
>  static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -	const int last_prp = dev->ctrl.page_size / 8 - 1;
> +	const int last_prp = dev->ctrl.page_size / sizeof(__le64) - 1;
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
> @@ -555,7 +591,8 @@ static void nvme_print_sgl(struct scatterlist *sgl, int nents)
>  	}
>  }
>  
> -static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
> +static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req,
> +		struct nvme_rw_command *cmnd)
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  	struct dma_pool *pool;
> @@ -566,14 +603,16 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
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
>  	if (length <= 0) {
>  		iod->first_dma = 0;
> -		return BLK_STS_OK;
> +		goto done;
>  	}
>  
>  	dma_len -= (page_size - offset);
> @@ -587,7 +626,7 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
>  
>  	if (length <= page_size) {
>  		iod->first_dma = dma_addr;
> -		return BLK_STS_OK;
> +		goto done;
>  	}
>  
>  	nprps = DIV_ROUND_UP(length, page_size);
> @@ -634,6 +673,10 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
>  		dma_len = sg_dma_len(sg);
>  	}
>  
> +done:
> +	cmnd->dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
> +	cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
> +
>  	return BLK_STS_OK;
>  
>   bad_sgl:
> @@ -643,6 +686,130 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
>  	return BLK_STS_IOERR;
>  }
>  
> +static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
> +		struct scatterlist *sg)
> +{
> +	sge->addr = cpu_to_le64(sg_dma_address(sg));
> +	sge->length = cpu_to_le32(sg_dma_len(sg));
> +	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
> +}
> +
> +static void nvme_pci_sgl_set_last_seg(struct nvme_sgl_desc *sge,
> +		dma_addr_t dma_addr, int entries)
> +{
> +	sge->addr = cpu_to_le64(dma_addr);
> +	sge->length = cpu_to_le32(entries * sizeof(struct nvme_sgl_desc));
> +	sge->type = NVME_SGL_FMT_LAST_SEG_DESC << 4;
> +}
> +
> +static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
> +		dma_addr_t dma_addr)
> +{
> +	sge->addr = cpu_to_le64(dma_addr);
> +	sge->length = cpu_to_le32(PAGE_SIZE);
> +	sge->type = NVME_SGL_FMT_SEG_DESC << 4;
> +}
> +
> +static blk_status_t nvme_setup_sgls(struct nvme_dev *dev, struct request *req,
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
> +	cmd->flags = NVME_CMD_SGL_METABUF; /* setting the transfer type as SGL */
> +
> +	if (length == sg_dma_len(sg)) {
> +		nvme_pci_sgl_set_data(&cmd->dptr.sgl, sg);
> +		return BLK_STS_OK;
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
> +		return BLK_STS_RESOURCE;
> +	}
> +
> +	iod_list(req)[0] = sg_list;
> +	iod->first_dma = sgl_dma;
> +
> +	if (entries <= SGES_PER_PAGE) {
> +		nvme_pci_sgl_set_last_seg(&cmd->dptr.sgl, sgl_dma, entries);
> +
> +		for (i = 0; i < entries; i++) {
> +			nvme_pci_sgl_set_data(&sg_list[i], sg);
> +			length -= sg_dma_len(sg);
> +			sg = sg_next(sg);
> +		}
> +
> +		WARN_ON(length > 0);
> +		return BLK_STS_OK;
> +	}
> +
> +	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma);
> +
> +	do {
> +		if (i == SGES_PER_PAGE) {
> +			struct nvme_sgl_desc *old_sg_desc = sg_list;
> +			struct nvme_sgl_desc *link = &old_sg_desc[i - 1];
> +
> +			sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
> +			if (!sg_list)
> +				return BLK_STS_RESOURCE;
> +
> +			i = 0;
> +			iod_list(req)[iod->npages++] = sg_list;
> +			sg_list[i++] = *link;
> +
> +			if (entries < SGES_PER_PAGE)
> +				nvme_pci_sgl_set_last_seg(link, sgl_dma, entries);
> +			else
> +				nvme_pci_sgl_set_seg(link, sgl_dma);
> +		}
> +
> +		nvme_pci_sgl_set_data(&sg_list[i], sg);
> +
> +		length -= sg_dma_len(sg);
> +		sg = sg_next(sg);
> +		entries--;
> +	} while (length > 0);
> +
> +	WARN_ON(entries > 0);
> +	return BLK_STS_OK;
> +}
> +
> +static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
> +{
> +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	unsigned int avg_seg_size;
> +
> +	avg_seg_size = DIV_ROUND_UP(blk_rq_payload_bytes(req),
> +			blk_rq_nr_phys_segments(req));
> +
> +	if (dev->ctrl.sgls == NVME_CTRL_SGL_NOT_SUPP)
> +		return false;

I'm alsmost tempted to drop the symbolic NVME_CTRL_SGL_NOT_SUPP name
and just opencode something like:

	if (!(dev->ctrl.sgls & ((1 << 0) | (1 << 1)))
		return false;

We use the raw bit values in various other places, and given how they
appear as such raw bit values in the spec that seems to be easier to
map to me than inventing some artifical name for them.
