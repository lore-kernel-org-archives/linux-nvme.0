From: hare@suse.de (Hannes Reinecke)
Date: Thu, 22 Jun 2017 08:32:02 +0200
Subject: [PATCH v2 3/6] qla2xxx: Add FC-NVMe F/W initialization and
 transport registration
In-Reply-To: <20170621204846.21663-4-himanshu.madhani@cavium.com>
References: <20170621204846.21663-1-himanshu.madhani@cavium.com>
 <20170621204846.21663-4-himanshu.madhani@cavium.com>
Message-ID: <7b83922d-7f2b-0938-08ae-52943381ce85@suse.de>

On 06/21/2017 10:48 PM, Madhani, Himanshu wrote:
> From: Duane Grigsby <duane.grigsby at cavium.com>
> 
> This code provides the interfaces to register remote and local ports
> of FC4 type 0x28 with the FC-NVMe transport and transports the
> requests (FC-NVMe FC link services and FC-NVMe commands IUs) to the
> fabric. It also provides the support for allocating h/w queues and
> aborting FC-NVMe FC requests.
> 
> Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
> Signed-off-by: Duane Grigsby <duane.grigsby at cavium.com>
> Signed-off-by: Anil Gurumurthy <anil.gurumurhty at cavium.com>
> Signed-off-by: Giridhar Malavali <giridhar.malavali at cavium.com>
> Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
> ---
>  drivers/scsi/qla2xxx/Makefile   |   2 +-
>  drivers/scsi/qla2xxx/qla_dbg.c  |   2 +-
>  drivers/scsi/qla2xxx/qla_def.h  |   6 +
>  drivers/scsi/qla2xxx/qla_gbl.h  |  11 +
>  drivers/scsi/qla2xxx/qla_init.c |   8 +
>  drivers/scsi/qla2xxx/qla_iocb.c |  36 ++
>  drivers/scsi/qla2xxx/qla_isr.c  |  19 +
>  drivers/scsi/qla2xxx/qla_mbx.c  |  21 ++
>  drivers/scsi/qla2xxx/qla_nvme.c | 756 ++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/qla2xxx/qla_nvme.h | 132 +++++++
>  drivers/scsi/qla2xxx/qla_os.c   |  40 ++-
>  11 files changed, 1024 insertions(+), 9 deletions(-)
>  create mode 100644 drivers/scsi/qla2xxx/qla_nvme.c
>  create mode 100644 drivers/scsi/qla2xxx/qla_nvme.h
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
