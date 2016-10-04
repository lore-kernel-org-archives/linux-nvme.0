From: hare@suse.de (Hannes Reinecke)
Date: Tue, 4 Oct 2016 09:33:36 +0200
Subject: [PATCH 2/7] nvme-fabrics: sync FC-NVME header with standard
 updates
In-Reply-To: <57f34bb2.yNdu+Ipyn59s5QRk%james.smart@broadcom.com>
References: <57f34bb2.yNdu+Ipyn59s5QRk%james.smart@broadcom.com>
Message-ID: <6ddab0f9-f73d-cd8c-c39c-1c146c3e54ba@suse.de>

On 10/04/2016 08:26 AM, James Smart wrote:
> 
> Sync FC-NVME header with standard updates
> 
> This patch contains the following 2 mods:
> - Since the prior patch posting, transports were assigned a status
>   code range to use (0xB0-0xBF). Updated codes to be in the range
> - cmd_iu changed in T11. The 2 reserved words, previous at words
>   2 and 3, were moved to after the sqe.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  include/linux/nvme-fc.h | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/nvme-fc.h b/include/linux/nvme-fc.h
> index 99e9200..da877c2 100644
> --- a/include/linux/nvme-fc.h
> +++ b/include/linux/nvme-fc.h
> @@ -38,11 +38,11 @@ struct nvme_fc_cmd_iu {
>  	__be16			iu_len;
>  	__u8			rsvd4[3];
>  	__u8			flags;
> -	__be32			rsvd8[2];
>  	__be64			connection_id;
>  	__be32			csn;
>  	__be32			data_len;
>  	struct nvme_command	sqe;
> +	__be32			rsvd88[2];
>  };
>  
>  #define NVME_FC_SIZEOF_ZEROS_RSP	12
> @@ -265,30 +265,23 @@ struct fcnvme_ls_disconnect_acc {
>  /*
>   * FC Transport-specific error status values for NVME commands
>   *
> - * Need to incorporate into NVME Over Fabrics standard
> - *
> - * A request has been made to include transport-specific status values
> - * into the standard but it is not yet complete/defined.
> - *
> - * For now, we will use a range within the Fabric values.  The range
> - * will be 0xA0-0xBF, which is a reserved area in the fabric spec.
> - * Currently, Only the values below have been defined within that range.
> + * Transport-specific status code values must be in the range 0xB0..0xBF
>   */
>  enum {
>  	/* Generic FC failure - catchall */
> -	NVME_SC_FC_TRANSPORT_ERROR	= 0x00A0,
> +	NVME_SC_FC_TRANSPORT_ERROR	= 0x00B0,
>  
>  	/* I/O failure due to FC ABTS'd */
> -	NVME_SC_FC_TRANSPORT_ABORTED	= 0x00A1,
> +	NVME_SC_FC_TRANSPORT_ABORTED	= 0x00B1,
>  
>  	/* FC Transport Connection in error */
> -	NVME_SC_FC_NO_CONNECTION	= 0x40A2,	/* not retryable */
> +	NVME_SC_FC_NO_CONNECTION	= 0x40B2,	/* not retryable */
>  
>  	/* NVME Completion did not contain original CMDID */
> -	NVME_SC_FC_CMDID_MISMATCH	= 0x00A3,
> +	NVME_SC_FC_CMDID_MISMATCH	= 0x00B3,
>  
>  	/* IU format error */
> -	NVME_SC_FC_FORMAT		= 0x00A4,
> +	NVME_SC_FC_FORMAT		= 0x00B4,
>  };
>  
>  
> 
Any particular reason why this is not merged with the previous patch?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
