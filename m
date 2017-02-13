From: hare@suse.de (Hannes Reinecke)
Date: Mon, 13 Feb 2017 10:19:32 +0100
Subject: [PATCH v3 16/16] lpfc: Update lpfc version to 11.2.0.7
In-Reply-To: <58a0d928.Zhz1nZh7kjbELlcG%jsmart2021@gmail.com>
References: <58a0d928.Zhz1nZh7kjbELlcG%jsmart2021@gmail.com>
Message-ID: <d4587f50-e88a-f322-8205-29052953f502@suse.de>

On 02/12/2017 10:52 PM, James Smart wrote:
> 
> Update lpfc version to 11.2.0.7
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_version.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
> index 0d93535..86c6c9b 100644
> --- a/drivers/scsi/lpfc/lpfc_version.h
> +++ b/drivers/scsi/lpfc/lpfc_version.h
> @@ -20,7 +20,7 @@
>   * included with this package.                                     *
>   *******************************************************************/
>  
> -#define LPFC_DRIVER_VERSION "11.2.0.4"
> +#define LPFC_DRIVER_VERSION "11.2.0.7"
>  #define LPFC_DRIVER_NAME		"lpfc"
>  
>  /* Used for SLI 2/3 */
> 
Hmm. One would have thought that a major rework like this would warrant
an increased major number.
But that's probably just me being totally ignorant of any company
policies :-)

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
