From: hare@suse.de (Hannes Reinecke)
Date: Thu, 22 Jun 2017 08:28:51 +0200
Subject: [PATCH v2 2/6] qla2xxx: Add FC-NVMe command handling
In-Reply-To: <20170621204846.21663-3-himanshu.madhani@cavium.com>
References: <20170621204846.21663-1-himanshu.madhani@cavium.com>
 <20170621204846.21663-3-himanshu.madhani@cavium.com>
Message-ID: <a37ad92e-4a26-9221-973b-b62793a210ee@suse.de>

On 06/21/2017 10:48 PM, Madhani, Himanshu wrote:
> From: Duane Grigsby <duane.grigsby at cavium.com>
> 
> This patch adds logic to  handle the completion of
> FC-NVMe commands and creates a sub-command in the SRB
> command structure to manage NVMe commands.
> 
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Duane Grigsby <duane.grigsby at cavium.com>
> Signed-off-by: Anil Gurumurthy <anil.gurumurhty at cavium.com>
> Signed-off-by: Giridhar Malavali <giridhar.malavali at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/scsi/qla2xxx/qla_def.h | 17 +++++++++
>  drivers/scsi/qla2xxx/qla_fw.h  | 22 ++++++++++--
>  drivers/scsi/qla2xxx/qla_isr.c | 79 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/qla2xxx/qla_os.c  | 18 ++++++++--
>  4 files changed, 131 insertions(+), 5 deletions(-)
> Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
