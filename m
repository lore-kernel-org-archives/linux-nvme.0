From: hare@suse.de (Hannes Reinecke)
Date: Wed, 14 Mar 2018 12:16:14 +0100
Subject: [PATCH 05/13] qla2xxx: Add FC-NVMe abort processing
In-Reply-To: <20180312181650.20704-6-himanshu.madhani@cavium.com>
References: <20180312181650.20704-1-himanshu.madhani@cavium.com>
 <20180312181650.20704-6-himanshu.madhani@cavium.com>
Message-ID: <42a52c7f-38f1-a5f0-cbea-f4b251cc3aae@suse.de>

On 03/12/2018 07:16 PM, Himanshu Madhani wrote:
> From: Darren Trapp <darren.trapp at cavium.com>
> 
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>  drivers/scsi/qla2xxx/qla_nvme.c | 36 ++++++++++++++++++------------------
>  drivers/scsi/qla2xxx/qla_nvme.h |  1 +
>  2 files changed, 19 insertions(+), 18 deletions(-)
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
