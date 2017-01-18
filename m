From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Jan 2017 09:06:38 +0100
Subject: [PATCH 17/17] lpfc: Update lpfc version to 11.2.0.7
In-Reply-To: <587ec2fc.VRwkzlaMrjIvUNsO%jsmart2021@gmail.com>
References: <587ec2fc.VRwkzlaMrjIvUNsO%jsmart2021@gmail.com>
Message-ID: <cac309aa-2842-2b6a-0ab5-3f9bc30c9921@suse.de>

On 01/18/2017 02:21 AM, James Smart wrote:
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
> index 4e46ce4..9dfdab1 100644
> --- a/drivers/scsi/lpfc/lpfc_version.h
> +++ b/drivers/scsi/lpfc/lpfc_version.h
> @@ -18,7 +18,7 @@
>   * included with this package.                                     *
>   *******************************************************************/
>  
> -#define LPFC_DRIVER_VERSION "11.2.0.4"
> +#define LPFC_DRIVER_VERSION "11.2.0.7"
>  #define LPFC_DRIVER_NAME		"lpfc"
>  #define LPFCMGMT_NAME			"lpfcmgmt"
>  
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
