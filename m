From: hare@suse.de (Hannes Reinecke)
Date: Wed, 14 Mar 2018 12:15:20 +0100
Subject: [PATCH 03/13] qla2xxx: Add changes for devloss timeout in driver
In-Reply-To: <20180312181650.20704-4-himanshu.madhani@cavium.com>
References: <20180312181650.20704-1-himanshu.madhani@cavium.com>
 <20180312181650.20704-4-himanshu.madhani@cavium.com>
Message-ID: <7f54e614-e46d-bf3b-e921-09638a56e11a@suse.de>

On 03/12/2018 07:16 PM, Himanshu Madhani wrote:
> From: Darren Trapp <darren.trapp at cavium.com>
> 
> Add support for error recovery within devloss timeout, now that
> FC-NVMe transport support devloss timeout.
> 
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>  drivers/scsi/qla2xxx/qla_def.h    |   1 +
>  drivers/scsi/qla2xxx/qla_init.c   |   8 +++
>  drivers/scsi/qla2xxx/qla_isr.c    |   5 +-
>  drivers/scsi/qla2xxx/qla_nvme.c   | 142 +++++++++++++++++---------------------
>  drivers/scsi/qla2xxx/qla_nvme.h   |   6 +-
>  drivers/scsi/qla2xxx/qla_target.c |  13 ++--
>  drivers/scsi/qla2xxx/qla_target.h |   2 +-
>  7 files changed, 87 insertions(+), 90 deletions(-)
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
