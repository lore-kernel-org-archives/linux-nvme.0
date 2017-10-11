From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 14:01:40 +0300
Subject: [PATCH V6] nvme-pci: add SGL support
In-Reply-To: <1507232903-9532-2-git-send-email-ckulkarnilinux@gmail.com>
References: <1507232903-9532-1-git-send-email-ckulkarnilinux@gmail.com>
 <1507232903-9532-2-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <d06ea87b-1b0c-e581-b6f1-b4b2647eb431@grimberg.me>

Chaitanya,

Sorry for the late reply, was on vacation...

> From: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> 
> This adds SGL support for NVMe PCIe driver, based on an earlier patch
> from Rajiv Shanmugam Madeswaran <smrajiv15 at gmail.com>. This patch
> refactors the original code and adds new module parameter sgl_threshold
> to determine whether to use SGL or PRP for IOs.

One of the more appealing values of SGL support is removing the
virt_boundary constraint from the driver and use SGLs to issue
"gappy" IO. I would be very happy to see this happening, is this
something you plan to address?

This is why I wanted to not have a threshold based sgl/prp selection
as it does not allow us to remove the virt_boundary constraint for
controllers that don't have the "prp-able limitation".

We could have also a threshold to select the optimal selection for
sgl/prp, but it would need to meet the following conditions:
- choose prp if
    1. avg_seg_size is < sgl_threshold
    2. bio_vec is not gappy
(2) would mean traversing the bio_vec until we integrate this into
     the block layer. But given that this is cheap when the bio_vec
     is small and long bio_vecs its probably negligible compared to
     the longer transfer latency.
> +/*
> + * Calculates the number of pages needed for the SGL segments. For example a 4k
> + * page can accommodate 256 SGL descriptors.
> + */
> +static int nvme_npages_sgl(unsigned int num_seg)

Can you place nvme_pci_ prefix on all the new routines you add?

> +{
> +	return DIV_ROUND_UP(num_seg * sizeof(struct nvme_sgl_desc), PAGE_SIZE);
> +}
> +
>   static unsigned int nvme_iod_alloc_size(struct nvme_dev *dev,
> -		unsigned int size, unsigned int nseg)
> +		unsigned int size, unsigned int nseg, bool use_sgl)
>   {

I would suggest that also for functions that you touch their signature
make them nvme_pci_*.

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
>   }
>   
> -static unsigned int nvme_cmd_size(struct nvme_dev *dev)
> +static unsigned int nvme_cmd_size(struct nvme_dev *dev, bool use_sgl)
>   {
>   	return sizeof(struct nvme_iod) +
> -		nvme_iod_alloc_size(dev, NVME_INT_BYTES(dev), NVME_INT_PAGES);
> +		nvme_iod_alloc_size(dev, NVME_INT_BYTES(dev), NVME_INT_PAGES, use_sgl);
>   }
>   
>   static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
> @@ -425,10 +447,10 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
>   	nvmeq->sq_tail = tail;
>   }
>   
> -static __le64 **iod_list(struct request *req)
> +static void **iod_list(struct request *req)
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -	return (__le64 **)(iod->sg + blk_rq_nr_phys_segments(req));
> +	return (void **)(iod->sg + blk_rq_nr_phys_segments(req));
>   }
>   
>   static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
> @@ -438,7 +460,10 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
>   	unsigned int size = blk_rq_payload_bytes(rq);
>   
>   	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
> -		iod->sg = kmalloc(nvme_iod_alloc_size(dev, size, nseg), GFP_ATOMIC);
> +		size_t alloc_size = nvme_iod_alloc_size(dev, size, nseg,
> +				iod->use_sgl);
> +
> +		iod->sg = kmalloc(alloc_size, GFP_ATOMIC);
>   		if (!iod->sg)
>   			return BLK_STS_RESOURCE;
>   	} else {
> @@ -456,18 +481,29 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
>   static void nvme_free_iod(struct nvme_dev *dev, struct request *req)
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> -	const int last_prp = dev->ctrl.page_size / 8 - 1;
> +	const int last_prp = dev->ctrl.page_size / sizeof(__le64) - 1;
> +	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
>   	int i;
> -	__le64 **list = iod_list(req);
> -	dma_addr_t prp_dma = iod->first_dma;
>   
>   	if (iod->npages == 0)
> -		dma_pool_free(dev->prp_small_pool, list[0], prp_dma);
> +		dma_pool_free(dev->prp_small_pool, iod_list(req)[0], dma_addr);
> +
>   	for (i = 0; i < iod->npages; i++) {
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
>   	}
>   
>   	if (iod->sg != iod->inline_sg)
> @@ -555,7 +591,8 @@ static void nvme_print_sgl(struct scatterlist *sgl, int nents)
>   	}
>   }
>   
> -static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
> +static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req,
> +		struct nvme_rw_command *cmnd)
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>   	struct dma_pool *pool;
> @@ -566,14 +603,16 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
>   	u32 page_size = dev->ctrl.page_size;
>   	int offset = dma_addr & (page_size - 1);
>   	__le64 *prp_list;
> -	__le64 **list = iod_list(req);
> +	void **list = iod_list(req);
>   	dma_addr_t prp_dma;
>   	int nprps, i;
>   
> +	iod->use_sgl = false;
> +
>   	length -= (page_size - offset);
>   	if (length <= 0) {
>   		iod->first_dma = 0;
> -		return BLK_STS_OK;
> +		goto done;
>   	}
>   
>   	dma_len -= (page_size - offset);
> @@ -587,7 +626,7 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
>   
>   	if (length <= page_size) {
>   		iod->first_dma = dma_addr;
> -		return BLK_STS_OK;
> +		goto done;
>   	}
>   
>   	nprps = DIV_ROUND_UP(length, page_size);
> @@ -634,6 +673,10 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
>   		dma_len = sg_dma_len(sg);
>   	}
>   
> +done:
> +	cmnd->dptr.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
> +	cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma);
> +
>   	return BLK_STS_OK;
>   
>    bad_sgl:
> @@ -643,6 +686,129 @@ static blk_status_t nvme_setup_prps(struct nvme_dev *dev, struct request *req)
>   	return BLK_STS_IOERR;
>   }
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

nvme_pci_*
