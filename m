From: hare@suse.de (Hannes Reinecke)
Date: Mon, 7 Nov 2016 07:50:51 +0100
Subject: [PATCH v5 2/7] nvme-fabrics: Add FC transport error codes to
 nvme.h
In-Reply-To: <58201df1.MGZTkAoQfXHuIFTb%jsmart2021@gmail.com>
References: <58201df1.MGZTkAoQfXHuIFTb%jsmart2021@gmail.com>
Message-ID: <a41d8c31-63eb-25e9-bb4c-19d33a2d01a0@suse.de>

On 11/07/2016 07:23 AM, James Smart wrote:
> 
> Add FC transport error codes to nvme.h
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  include/linux/nvme.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index fc3c242..aa3cac4 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -973,6 +973,26 @@ enum {
>  	NVME_SC_UNWRITTEN_BLOCK		= 0x287,
>  
>  	NVME_SC_DNR			= 0x4000,
> +
> +
> +	/*
> +	 * FC Transport-specific error status values for NVME commands
> +	 *
> +	 * Transport-specific status code values must be in the range 0xB0..0xBF
> +	 */
> +
> +	/* Generic FC failure - catchall */
> +	NVME_SC_FC_TRANSPORT_ERROR	= 0x00B0,
> +
> +	/* I/O failure due to FC ABTS'd */
> +	NVME_SC_FC_TRANSPORT_ABORTED	= 0x00B1,
> +
> +	/* IU format error */
> +	NVME_SC_FC_FORMAT		= 0x00B2,
> +
> +	/* NVME Completion did not contain original CMDID */
> +	NVME_SC_FC_CMDID_MISMATCH	= 0x00B3,
> +
>  };
>  
>  struct nvme_completion {
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
