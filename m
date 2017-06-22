From: hare@suse.de (Hannes Reinecke)
Date: Thu, 22 Jun 2017 08:33:49 +0200
Subject: [PATCH v2 6/6] qla2xxx: Update Driver version to 10.00.00.00-k
In-Reply-To: <20170621204846.21663-7-himanshu.madhani@cavium.com>
References: <20170621204846.21663-1-himanshu.madhani@cavium.com>
 <20170621204846.21663-7-himanshu.madhani@cavium.com>
Message-ID: <a4dad2ab-9e2f-3104-0694-fda3f8368dee@suse.de>

On 06/21/2017 10:48 PM, Madhani, Himanshu wrote:
> From: Himanshu Madhani <himanshu.madhani at cavium.com>
> 
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/qla2xxx/qla_version.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_version.h b/drivers/scsi/qla2xxx/qla_version.h
> index dcbb9bb05e99..005a378f7fab 100644
> --- a/drivers/scsi/qla2xxx/qla_version.h
> +++ b/drivers/scsi/qla2xxx/qla_version.h
> @@ -7,9 +7,9 @@
>  /*
>   * Driver version
>   */
> -#define QLA2XXX_VERSION      "9.01.00.00-k"
> +#define QLA2XXX_VERSION      "10.00.00.00-k"
>  
> -#define QLA_DRIVER_MAJOR_VER	9
> -#define QLA_DRIVER_MINOR_VER	1
> +#define QLA_DRIVER_MAJOR_VER	10
> +#define QLA_DRIVER_MINOR_VER	0
>  #define QLA_DRIVER_PATCH_VER	0
>  #define QLA_DRIVER_BETA_VER	0
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
