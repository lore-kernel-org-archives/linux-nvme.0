From: hare@suse.de (Hannes Reinecke)
Date: Wed, 14 Mar 2018 12:35:38 +0100
Subject: [PATCH 08/13] qla2xxx: Remove nvme_done_list
In-Reply-To: <20180312181650.20704-9-himanshu.madhani@cavium.com>
References: <20180312181650.20704-1-himanshu.madhani@cavium.com>
 <20180312181650.20704-9-himanshu.madhani@cavium.com>
Message-ID: <dad1d8e6-f5b5-288a-9e65-02ec5880b6d1@suse.de>

On 03/12/2018 07:16 PM, Himanshu Madhani wrote:
> From: Darren Trapp <darren.trapp at cavium.com>
> 
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>  drivers/scsi/qla2xxx/qla_def.h  |  1 -
>  drivers/scsi/qla2xxx/qla_gbl.h  |  2 --
>  drivers/scsi/qla2xxx/qla_init.c |  1 -
>  drivers/scsi/qla2xxx/qla_mid.c  |  6 ------
>  drivers/scsi/qla2xxx/qla_nvme.c | 13 ++-----------
>  drivers/scsi/qla2xxx/qla_os.c   |  1 -
>  6 files changed, 2 insertions(+), 22 deletions(-)
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
