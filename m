From: hare@suse.de (Hannes Reinecke)
Date: Wed, 14 Mar 2018 12:33:24 +0100
Subject: [PATCH 06/13] qla2xxx: Fix n2n_ae flag to prevent dev_loss on PDB
 change
In-Reply-To: <20180312181650.20704-7-himanshu.madhani@cavium.com>
References: <20180312181650.20704-1-himanshu.madhani@cavium.com>
 <20180312181650.20704-7-himanshu.madhani@cavium.com>
Message-ID: <4349b739-e622-7373-89cf-dcba3f07cc3d@suse.de>

On 03/12/2018 07:16 PM, Himanshu Madhani wrote:
> From: Darren Trapp <darren.trapp at cavium.com>
> 
Some more text would be nice; not everyone knows what n2n_ae or PDB is ...

> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>  drivers/scsi/qla2xxx/qla_def.h | 2 --
>  drivers/scsi/qla2xxx/qla_isr.c | 3 ---
>  drivers/scsi/qla2xxx/qla_mbx.c | 3 +++
>  3 files changed, 3 insertions(+), 5 deletions(-)
> 
Otherwise:
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
