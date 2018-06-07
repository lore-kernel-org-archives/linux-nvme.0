From: hare@suse.de (Hannes Reinecke)
Date: Thu, 7 Jun 2018 09:58:53 +0200
Subject: [PATCH 01/10] nvme.h: add support for the log specific field
In-Reply-To: <20180606143311.23076-2-hch@lst.de>
References: <20180606143311.23076-1-hch@lst.de>
 <20180606143311.23076-2-hch@lst.de>
Message-ID: <20180607095853.179ba761@pentland.suse.de>

On Wed,  6 Jun 2018 16:33:02 +0200
Christoph Hellwig <hch@lst.de> wrote:

> NVMe 1.3 added a new log specific field to the get log page CQ
> defintion, add it to our get_log_page SQ structure.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  include/linux/nvme.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 2950ce957656..32f24f4ca763 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -880,7 +880,7 @@ struct nvme_get_log_page_command {
>  	__u64			rsvd2[2];
>  	union nvme_data_ptr	dptr;
>  	__u8			lid;
> -	__u8			rsvd10;
> +	__u8			lsp; /* upper 4 bits reserved */
>  	__le16			numdl;
>  	__le16			numdu;
>  	__u16			rsvd11;

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
