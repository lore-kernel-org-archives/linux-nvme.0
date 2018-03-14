From: hare@suse.de (Hannes Reinecke)
Date: Wed, 14 Mar 2018 12:38:03 +0100
Subject: [PATCH 10/13] qla2xxx: Fix FC-NVMe IO abort during driver reset
In-Reply-To: <20180312181650.20704-11-himanshu.madhani@cavium.com>
References: <20180312181650.20704-1-himanshu.madhani@cavium.com>
 <20180312181650.20704-11-himanshu.madhani@cavium.com>
Message-ID: <c949fceb-5567-ead2-9365-8ca8e3ed349d@suse.de>

On 03/12/2018 07:16 PM, Himanshu Madhani wrote:
> From: Darren Trapp <darren.trapp at cavium.com>
> 
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>  drivers/scsi/qla2xxx/qla_nvme.c | 17 ++++++++++++-----
>  drivers/scsi/qla2xxx/qla_nvme.h |  2 +-
>  drivers/scsi/qla2xxx/qla_os.c   |  2 +-
>  3 files changed, 14 insertions(+), 7 deletions(-)
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
