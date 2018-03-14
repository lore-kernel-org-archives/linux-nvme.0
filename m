From: hare@suse.de (Hannes Reinecke)
Date: Wed, 14 Mar 2018 12:40:37 +0100
Subject: [PATCH 11/13] qla2xxx: Cleanup code to improve FC-NVMe error
 handling
In-Reply-To: <20180312181650.20704-12-himanshu.madhani@cavium.com>
References: <20180312181650.20704-1-himanshu.madhani@cavium.com>
 <20180312181650.20704-12-himanshu.madhani@cavium.com>
Message-ID: <30b05c1d-7460-29bf-daee-5f224f61648b@suse.de>

On 03/12/2018 07:16 PM, Himanshu Madhani wrote:
> From: Darren Trapp <darren.trapp at cavium.com>
> 
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>  drivers/scsi/qla2xxx/qla_isr.c  | 78 +++++++++++++++--------------------------
>  drivers/scsi/qla2xxx/qla_nvme.c |  2 +-
>  2 files changed, 29 insertions(+), 51 deletions(-)
> 
And also here, please add some description what this patch does.

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
