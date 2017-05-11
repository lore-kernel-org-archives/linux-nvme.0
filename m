From: hare@suse.de (Hannes Reinecke)
Date: Thu, 11 May 2017 09:45:35 +0200
Subject: [PATCH 11/15] lpfc: Fix debugfs root inode "lpfc" not getting
 deleted on driver unload.
In-Reply-To: <20170510190713.30171-12-jsmart2021@gmail.com>
References: <20170510190713.30171-1-jsmart2021@gmail.com>
 <20170510190713.30171-12-jsmart2021@gmail.com>
Message-ID: <f3381b13-e5f9-9fda-43ce-da47b8dea26a@suse.de>

On 05/10/2017 09:07 PM, James Smart wrote:
> When unloading and reloading the driver, the driver
> fails to recreate the lpfc root inode in the debugfs tree.
> 
> The driver is incorrectly removing the lpfc root inode
> in lpfc_debugfs_terminate in the first driver instance that
> unloads and then sets the lpfc_debugfs_root global parameter
> to NULL.  When the final driver instance unloads, the debugfs
> calls quietly ignore the remove on a NULL pointer.  The bug
> is that the debugfs_remove call returns void so the driver
> doesn't know to correctly set the global parameter to NULL.
> 
> Base the debugfs_remove of the lpfc_debugfs_root parameter
> on lpfc_debugfs_hba_count because this parameter tracks the
> fnX instance tracked per driver instance.
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/lpfc/lpfc_debugfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
> index c7d1c9d37a64..4bcb92c844ca 100644
> --- a/drivers/scsi/lpfc/lpfc_debugfs.c
> +++ b/drivers/scsi/lpfc/lpfc_debugfs.c
> @@ -5866,8 +5866,10 @@ lpfc_debugfs_terminate(struct lpfc_vport *vport)
>  			atomic_dec(&lpfc_debugfs_hba_count);
>  		}
>  
> -		debugfs_remove(lpfc_debugfs_root); /* lpfc */
> -		lpfc_debugfs_root = NULL;
> +		if (atomic_read(&lpfc_debugfs_hba_count) == 0) {
> +			debugfs_remove(lpfc_debugfs_root); /* lpfc */
> +			lpfc_debugfs_root = NULL;
> +		}
>  	}
>  #endif
>  	return;
> 
kref?

But it's uncritical, so:

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
