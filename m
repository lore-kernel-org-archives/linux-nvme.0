From: hare@suse.de (Hannes Reinecke)
Date: Thu, 22 Jun 2017 08:33:01 +0200
Subject: [PATCH v2 4/6] qla2xxx: Send FC4 type NVMe to the management
 server
In-Reply-To: <20170621204846.21663-5-himanshu.madhani@cavium.com>
References: <20170621204846.21663-1-himanshu.madhani@cavium.com>
 <20170621204846.21663-5-himanshu.madhani@cavium.com>
Message-ID: <3599219e-0062-0ee1-5513-5eaf49efd583@suse.de>

On 06/21/2017 10:48 PM, Madhani, Himanshu wrote:
> From: Duane Grigsby <duane.grigsby at cavium.com>
> 
> This patch adds switch command support for FC-4 type of FC-NVMe (0x28)
> for resgistering HBA port to the management server. RFT_ID command is
> used to register FC-4 type of 0x28 and RFF_ID is used to register
> FC-4 features bits for FC-NVMe port.
> 
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Duane Grigsby <duane.grigsby at cavium.com>
> Signed-off-by: Anil Gurumurthy <anil.gurumurhty at cavium.com>
> Signed-off-by: Giridhar Malavali <giridhar.malavali at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> Reviewed-By: James Smart <james.smart at broadcom.com>
> ---
>  drivers/scsi/qla2xxx/qla_def.h  |   1 +
>  drivers/scsi/qla2xxx/qla_gbl.h  |   6 +-
>  drivers/scsi/qla2xxx/qla_gs.c   | 118 +++++++++++++++++++++++++++++++++++++++-
>  drivers/scsi/qla2xxx/qla_init.c |  11 +++-
>  4 files changed, 131 insertions(+), 5 deletions(-)
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
