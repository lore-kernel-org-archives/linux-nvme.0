From: hare@suse.de (Hannes Reinecke)
Date: Wed, 14 Mar 2018 12:36:50 +0100
Subject: [PATCH 09/13] qla2xxx: Fix retry for PRLI RJT with reason of BUSY
In-Reply-To: <20180312181650.20704-10-himanshu.madhani@cavium.com>
References: <20180312181650.20704-1-himanshu.madhani@cavium.com>
 <20180312181650.20704-10-himanshu.madhani@cavium.com>
Message-ID: <e067336f-af00-5d58-0a7d-b0b9750875b6@suse.de>

On 03/12/2018 07:16 PM, Himanshu Madhani wrote:
> From: Darren Trapp <darren.trapp at cavium.com>
> 
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>  drivers/scsi/qla2xxx/qla_dbg.c  |  2 +-
>  drivers/scsi/qla2xxx/qla_init.c | 13 ++++++++++++-
>  drivers/scsi/qla2xxx/qla_mbx.c  |  7 +++++--
>  3 files changed, 18 insertions(+), 4 deletions(-)
> 
Again, some more descriptive text would be nice.

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
