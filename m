From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 4 Nov 2013 13:26:19 -0500
Subject: [PATCH] NVMe: Add a buffer length parameter to struct
 nvme_user_io. Check buffer length in nvme_submit_io to avoid buffer
 overflow.
In-Reply-To: <1383584556-12121-1-git-send-email-david.darrington@hgst.com>
References: <1383584556-12121-1-git-send-email-david.darrington@hgst.com>
Message-ID: <20131104182618.GD6900@linux.intel.com>

On Mon, Nov 04, 2013@11:02:36AM -0600, David Darrington wrote:
> @@ -441,7 +441,9 @@ struct nvme_user_io {
>  	__u16	nblocks;
>  	__u16	rsvd;
>  	__u64	metadata;
> -	__u64	addr;
> +	__u32	rsvd1;
> +	__u32	dxfer_len;	/* length of data xfer buffer */
> +	__u64	dxferp;		/* pointer to data xfer buffer */
>  	__u64	slba;
>  	__u32	dsmgmt;
>  	__u32	reftag;

You can't just change the size of nvme_user_io; that breaks the ABI.
We'd need a _V2 version of the ioctl or something if we actually need
to change it.
