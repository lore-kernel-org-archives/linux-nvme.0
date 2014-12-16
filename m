From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 16 Dec 2014 10:55:52 -0500
Subject: [PATCHv2] NVMe: Update SCSI Inquiry VPD 83 translation
In-Reply-To: <1417738406-517-2-git-send-email-keith.busch@intel.com>
References: <1417738406-517-1-git-send-email-keith.busch@intel.com>
 <1417738406-517-2-git-send-email-keith.busch@intel.com>
Message-ID: <20141216155552.GF2220@wil.cx>

On Thu, Dec 04, 2014@05:13:26PM -0700, Keith Busch wrote:
> +		/* 1.1 requires EUI64 */
> +		struct nvme_id_ns *id_ns = mem;
> +		u8 ieee[4];
> +
> +		nvme_sc = nvme_identify(dev, ns->ns_id, 0, dma_addr);
> +		res = nvme_trans_status_code(hdr, nvme_sc);
> +		if (res)
> +			goto out_free;
> +		if (nvme_sc) {
> +			res = nvme_sc;
> +			goto out_free;
> +		}
> +
> +		/* Since SCSI tried to save 4 bits... [SPC-4(r34) Table 591] */
> +		ieee[0] = id_ctrl->ieee[0] << 4;
> +		ieee[1] = id_ctrl->ieee[0] >> 4 | id_ctrl->ieee[1] << 4;
> +		ieee[2] = id_ctrl->ieee[1] >> 4 | id_ctrl->ieee[2] << 4;
> +		ieee[3] = id_ctrl->ieee[2] >> 4;
> +
> +		inq_response[3] = 0x14;    /* Page Length */
> +		/* Designation Descriptor start */
> +		inq_response[4] = 0x01;    /* Proto ID=0h | Code set=1h */
> +		inq_response[5] = 0x03;    /* PIV=0b | Asso=00b | Designator Type=3h */

We have an EUI64, but we're trying to return an NAA descriptor ... why not
just return an EUI64 descriptor instead?  ie:

inq_response[5] = 0x02;
And then we don't need to muck around with the ieee[] array at all,
and can just copy the EUI64 into inq_response ... right?

> +		inq_response[6] = 0x03;    /* Rsvd */

... should be 0 since it's reserved, right?

> +		inq_response[7] = 0x10;    /* Designator Length */
> +
> +		/* Designator start */
> +		inq_response[8] = 0x60 | ieee[3]; /* NAA=6h | IEEE ID MSB, High nibble*/
> +		inq_response[9] = ieee[2];        /* IEEE ID */
> +		inq_response[10] = ieee[1];       /* IEEE ID */
> +		inq_response[11] = ieee[0];       /* IEEE ID| Vendor Specific ID... */
> +		memcpy(&inq_response[12], id_ns->eui64, sizeof(id_ns->eui64));
> +	} else {
> +		u16 vid = dev->pci_dev->vendor;
> +
> +		if (alloc_len < 72) {
> +			res = nvme_trans_completion(hdr,
> +					SAM_STAT_CHECK_CONDITION,
> +					ILLEGAL_REQUEST, SCSI_ASC_INVALID_CDB,
> +					SCSI_ASCQ_CAUSE_NOT_REPORTABLE);
> +			goto out_free;
> +		}
> +
> +		inq_response[3] = 0x48;    /* Page Length */
> +		/* Designation Descriptor start */
> +		inq_response[4] = 0x03;    /* Proto ID=0h | Code set=3h */
> +		inq_response[5] = 0x08;    /* PIV=0b | Asso=00b | Designator Type=8h */
> +		inq_response[6] = 0x00;    /* Rsvd */
> +		inq_response[7] = 0x44;    /* Designator Length */
> +
> +		sprintf(&inq_response[8], "%04x", vid);
> +		memcpy(&inq_response[12], dev->model, sizeof(dev->model));
> +		sprintf(&inq_response[52], "%04x", tmp_id);
> +		memcpy(&inq_response[56], dev->serial, sizeof(dev->serial));
> +	}
> +
> +	xfer_len = alloc_len;
>  	res = nvme_trans_copy_to_user(hdr, inq_response, xfer_len);
>  
>   out_free:
> -	dma_free_coherent(&dev->pci_dev->dev, sizeof(struct nvme_id_ns), mem,
> -			  dma_addr);
> +	dma_free_coherent(&dev->pci_dev->dev, 4096, mem, dma_addr);
>   out_dma:
>  	return res;
>  }
> @@ -2222,7 +2252,7 @@ static int nvme_trans_inquiry(struct nvme_ns *ns, struct sg_io_hdr *hdr,
>  	page_code = GET_INQ_PAGE_CODE(cmd);
>  	alloc_len = GET_INQ_ALLOC_LENGTH(cmd);
>  
> -	inq_response = kmalloc(STANDARD_INQUIRY_LENGTH, GFP_KERNEL);
> +	inq_response = kmalloc(alloc_len, GFP_KERNEL);
>  	if (inq_response == NULL) {
>  		res = -ENOMEM;
>  		goto out_mem;
> diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
> index 26386cf..1f7ef1a 100644
> --- a/include/uapi/linux/nvme.h
> +++ b/include/uapi/linux/nvme.h
> @@ -556,4 +556,6 @@ struct nvme_passthru_cmd {
>  #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
>  #define NVME_IOCTL_IO_CMD	_IOWR('N', 0x43, struct nvme_passthru_cmd)
>  
> +#define NVME_VERSION(major, minor) (((major) << 16) | ((minor) << 8))
> +
>  #endif /* _UAPI_LINUX_NVME_H */
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
