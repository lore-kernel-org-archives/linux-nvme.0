From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 9 Jan 2017 15:58:39 +0100
Subject: [PATCH 1/3] Sync FC-NVME header with standard
In-Reply-To: <585eb47e.DESLR9a+kpWyFOqP%jsmart2021@gmail.com>
References: <585eb47e.DESLR9a+kpWyFOqP%jsmart2021@gmail.com>
Message-ID: <20170109145839.GE3711@linux-x5ow.site>

On Sat, Dec 24, 2016@09:46:38AM -0800, James Smart wrote:
> 
> Update FC-NVME definitions to match FC-NVME r1.14 (16-020vB).
> Includes the following:
> - Addition of "status_code" field to ERSP IU
> - Addition of FC-NVME LS RJT reason_codes and reason_explanations
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---

[...]

> +/* FC-NVME LS RJT reason_code values */
> +enum fcnvme_ls_rjt_reason {

[...]

> +/* FC-NVME LS RJT reason_explanation values */
> +enum fcnvme_ls_rjt_explan {

[...]

>  /* FCNVME_LSDESC_RJT */
>  struct fcnvme_lsdesc_rjt {
> @@ -119,8 +169,8 @@ struct fcnvme_lsdesc_rjt {
>  	 * Reject reason and explanaction codes are generic
>  	 * to ELs's from LS-3.
>  	 */
> -	u8	reason_code;
> -	u8	reason_explanation;
> +	u8	reason_code;		/* fcnvme_ls_rjt_reason */
> +	u8	reason_explanation;	/* fcnvme_ls_rjt_explan */

I don't think the comments improve readability all too much.

Otherwise,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
