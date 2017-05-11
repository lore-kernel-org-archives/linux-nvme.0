From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 May 2017 09:51:49 +0200
Subject: [PATCH 15/15] lpfc: update version to 11.2.0.14
In-Reply-To: <20170510190713.30171-16-jsmart2021@gmail.com>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-16-jsmart2021@gmail.com>
Message-ID: <6eaf1cf3-5ced-65ad-f265-01b591f24a6a@suse.de>

On 05/10/2017 09:07 PM, James Smart wrote:
> Change driver version to 11.2.0.14
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_version.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
> index 1c26dc67151b..c2653244221c 100644
> --- a/drivers/scsi/lpfc/lpfc_version.h
> +++ b/drivers/scsi/lpfc/lpfc_version.h
> @@ -20,7 +20,7 @@
>   * included with this package.                                     *
>   *******************************************************************/
>  
> -#define LPFC_DRIVER_VERSION "11.2.0.12"
> +#define LPFC_DRIVER_VERSION "11.2.0.14"
>  #define LPFC_DRIVER_NAME		"lpfc"
>  
>  /* Used for SLI 2/3 */
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
