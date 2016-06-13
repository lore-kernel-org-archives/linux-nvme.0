From: keith.busch@intel.com (Keith Busch)
Date: Mon, 13 Jun 2016 16:46:12 -0400
Subject: [PATCH] NVMe:Support for Host Memory Buffer(HMB)
In-Reply-To: <1465565964-7167-1-git-send-email-a.dawn@samsung.com>
References: <1465565964-7167-1-git-send-email-a.dawn@samsung.com>
Message-ID: <20160613204611.GF12766@localhost.localdomain>

On Fri, Jun 10, 2016@07:09:24PM +0530, Arnav Dawn wrote:
> +
> +struct hmb_descriptor {
> +	__u64   badd;
> +	__u32   bsize;

Based on your usage, these types should be "le64" and "le32"?

> +struct hmb_info {
> +	/* Array of unalligned HMB Discriptor info */
> +	struct hmb_descriptor_info *hmb_desc_info;
> +	/* count of entries in the list */
> +	u32 hmb_desc_info_list_count;
> +
> +	/* HMB descriptor Info list */
> +	struct hmb_descriptor_info hmb_desc_info_list;
> +
> +	/* preferred HMB size set by device */
> +	u64 host_mem_pre;
> +
> +	/* min HMB size set by device */
> +	u64 host_mem_min;
> +
> +	/* HMB flags MR,ENABLE */
> +	u8 flags;
> +};

Please use kernel-doc style if you're going to comment your structure.

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 7d51b29..c29f514 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -119,7 +119,10 @@ struct nvme_id_ctrl {
>  	__u8			apsta;
>  	__le16			wctemp;
>  	__le16			cctemp;
> -	__u8			rsvd270[242];
> +	__u8			rsvd270[2];
> +	__u32			hmpre;
> +	__u32			hmmin;

These should also be le32 types.
