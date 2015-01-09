From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 9 Jan 2015 09:43:24 -0500
Subject: [PATCHv3 for-3.20] NVMe: Update SCSI Inquiry VPD 83h translation
In-Reply-To: <1420757697-14839-1-git-send-email-keith.busch@intel.com>
References: <1420757697-14839-1-git-send-email-keith.busch@intel.com>
Message-ID: <20150109144324.GC5661@wil.cx>

On Thu, Jan 08, 2015@03:54:57PM -0700, Keith Busch wrote:
> @@ -115,7 +115,13 @@ struct nvme_id_ns {
>  	__le16			nawun;
>  	__le16			nawupf;
>  	__le16			nacwu;
> -	__u8			rsvd40[80];
> +	__le16			nabsn;
> +	__le16			nabo;
> +	__le16			nabspf;
> +	__u16			rsvd46;
> +	__le64			nvmcap[2];
> +	__u8			rsvd40[40];

rsvd64[40], surely?

> +	__u8			nguid[16];
>  	__u8			eui64[8];
>  	struct nvme_lbaf	lbaf[16];
>  	__u8			rsvd192[192];
