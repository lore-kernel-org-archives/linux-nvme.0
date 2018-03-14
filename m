From: hare@suse.de (Hannes Reinecke)
Date: Wed, 14 Mar 2018 12:34:31 +0100
Subject: [PATCH 07/13] qla2xxx: Return busy if rport going away
In-Reply-To: <20180312181650.20704-8-himanshu.madhani@cavium.com>
References: <20180312181650.20704-1-himanshu.madhani@cavium.com>
 <20180312181650.20704-8-himanshu.madhani@cavium.com>
Message-ID: <e1c9dcce-db91-42e1-24b4-055fd946d7cf@suse.de>

On 03/12/2018 07:16 PM, Himanshu Madhani wrote:
> From: Darren Trapp <darren.trapp at cavium.com>
> 
> This patch adds mechanism to retur EBUSY if rport is going away
> to prevent exhausting FC-NVMe layer's retry counter.
> 
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>  drivers/scsi/qla2xxx/qla_def.h  |  1 +
>  drivers/scsi/qla2xxx/qla_isr.c  |  4 +++-
>  drivers/scsi/qla2xxx/qla_nvme.c | 31 ++++++++++++++++++++-----------
>  3 files changed, 24 insertions(+), 12 deletions(-)
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
