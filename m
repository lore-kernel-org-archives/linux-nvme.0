From: vishal.l.verma@linux.intel.com (Vishal Verma)
Date: Mon, 29 Apr 2013 10:23:35 -0600
Subject: [PATCH] NVMe: Add scsi unmap to SG_IO
In-Reply-To: <1366839864-32315-1-git-send-email-keith.busch@intel.com>
References: <1366839864-32315-1-git-send-email-keith.busch@intel.com>
Message-ID: <1367252615.21521.9.camel@teamfortress>

Acked-by: Vishal Verma <vishal.l.verma at linux.intel.com>

On Wed, 2013-04-24@15:44 -0600, Keith Busch wrote:
> Translates a scsi unmap request from SG_IO ioctl to NVMe
> data-set-management deallocate.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/block/nvme-scsi.c |   78 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 78 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
> index bbfb288..5b97d43 100644
> --- a/drivers/block/nvme-scsi.c
> +++ b/drivers/block/nvme-scsi.c
> @@ -100,6 +100,7 @@ static int sg_version_num = 30534;	/* 2 digits for each component */
>  #define FORMAT_UNIT_PROT_INT_OFFSET			3
>  #define FORMAT_UNIT_PROT_FIELD_USAGE_OFFSET		0
>  #define FORMAT_UNIT_PROT_FIELD_USAGE_MASK		0x07
> +#define UNMAP_CDB_PARAM_LIST_LENGTH_OFFSET		7
>  
>  /* Misc. defines */
>  #define NIBBLE_SHIFT					4
> @@ -2847,6 +2848,80 @@ static int nvme_trans_write_buffer(struct nvme_ns *ns, struct sg_io_hdr *hdr,
>  	return res;
>  }
>  
> +struct scsi_unmap_blk_desc {
> +	__be64	slba;
> +	__be32	nlb;
> +	u32	resv;
> +};
> +
> +struct scsi_unmap_parm_list {
> +	__be16	unmap_data_len;
> +	__be16	unmap_blk_desc_data_len;
> +	u32	resv;
> +	struct scsi_unmap_blk_desc desc[0];
> +};
> +
> +static int nvme_trans_unmap(struct nvme_ns *ns, struct sg_io_hdr *hdr,
> +							u8 *cmd)
> +{
> +	struct nvme_dev *dev = ns->dev;
> +	struct scsi_unmap_parm_list *plist;
> +	struct nvme_dsm_range *range;
> +	struct nvme_queue *nvmeq;
> +	struct nvme_command c;
> +	int i, nvme_sc, res = -ENOMEM;
> +	u16 ndesc, list_len;
> +	dma_addr_t dma_addr;
> +
> +	list_len = GET_U16_FROM_CDB(cmd, UNMAP_CDB_PARAM_LIST_LENGTH_OFFSET);
> +	if (!list_len)
> +		return -EINVAL;
> +
> +	plist = kmalloc(list_len, GFP_KERNEL);
> +	if (!plist)
> +		return -ENOMEM;
> +
> +	res = nvme_trans_copy_from_user(hdr, plist, list_len);
> +	if (res != SNTI_TRANSLATION_SUCCESS)
> +		goto out;
> +
> +	ndesc = be16_to_cpu(plist->unmap_blk_desc_data_len) >> 4;
> +	if (!ndesc || ndesc > 256) {
> +		res = -EINVAL;
> +		goto out;
> +	}
> +
> +	range = dma_alloc_coherent(&dev->pci_dev->dev, ndesc * sizeof(*range),
> +							&dma_addr, GFP_KERNEL);
> +	if (!range)
> +		goto out;
> +
> +	for (i = 0; i < ndesc; i++) {
> +		range[i].nlb = cpu_to_le32(be32_to_cpu(plist->desc[i].nlb));
> +		range[i].slba = cpu_to_le64(be64_to_cpu(plist->desc[i].slba));
> +		range[i].cattr = 0;
> +	}
> +
> +	memset(&c, 0, sizeof(c));
> +	c.dsm.opcode = nvme_cmd_dsm;
> +	c.dsm.nsid = cpu_to_le32(ns->ns_id);
> +	c.dsm.prp1 = cpu_to_le64(dma_addr);
> +	c.dsm.nr = cpu_to_le32(ndesc - 1);
> +	c.dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
> +
> +	nvmeq = get_nvmeq(dev);
> +	put_nvmeq(nvmeq);
> +
> +	nvme_sc = nvme_submit_sync_cmd(nvmeq, &c, NULL, NVME_IO_TIMEOUT);
> +	res = nvme_trans_status_code(hdr, nvme_sc);
> +
> +	dma_free_coherent(&dev->pci_dev->dev, ndesc * sizeof(*range),
> +							range, dma_addr);
> + out:
> +	kfree(plist);
> +	return res;
> +}
> +
>  static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr *hdr)
>  {
>  	u8 cmd[BLK_MAX_CDB];
> @@ -2921,6 +2996,9 @@ static int nvme_scsi_translate(struct nvme_ns *ns, struct sg_io_hdr *hdr)
>  	case WRITE_BUFFER:
>  		retcode = nvme_trans_write_buffer(ns, hdr, cmd);
>  		break;
> +	case UNMAP:
> +		retcode = nvme_trans_unmap(ns, hdr, cmd);
> +		break;
>  	default:
>   out:
>  		retcode = nvme_trans_completion(hdr, SAM_STAT_CHECK_CONDITION,
