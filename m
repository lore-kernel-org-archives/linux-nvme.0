From: hare@suse.de (Hannes Reinecke)
Date: Tue, 4 Oct 2016 09:41:31 +0200
Subject: [PATCH 5/7] nvme-fabrics: Add host FC transport support
In-Reply-To: <57f34bb5.BbLRH5/EeGOE2eLY%james.smart@broadcom.com>
References: <57f34bb5.BbLRH5/EeGOE2eLY%james.smart@broadcom.com>
Message-ID: <0ba7700f-5759-9fdc-ada7-be950907ad3d@suse.de>

On 10/04/2016 08:27 AM, James Smart wrote:
> 
> Add nvme-fabrics host FC transport support
> 
> Implements the FC-NVME T11 definition of how nvme fabric capsules are
> performed on an FC fabric. Utilizes a lower-layer API to FC host adapters
> to send/receive FC-4 LS operations and FCP operations that comprise NVME
> over FC operation.
> 
> The T11 definitions for FC-4 Link Services are implemented which create
> NVMeOF connections.  Implements the hooks with blk-mq to then submit admin
> and io requests to the different connections.
> 
> The changes made since the prior patch:
> - Remove todo on Association LS: pull values from opts struct
> - Slight restructure of nvme_fc_create_io_queues() and
>   nvme_fc_init_io_queues() for their return values
> - Checked and corrected BLK_MQ_xx return values in nvme_fc_start_fcp_op()
> - Remove the todo's around dma_map_page(). No need to use dma_map_page()
> - Reworked teardown paths with ref counting
> - Teardown now invokes callbackes on completion of unregister functions
> - set sqid in fcp request structs
> - Add blk poll support.
> - Remove map_queue from templates
> - Removal of fabric name for nport qualifier. Not necessary in T11.
> - LS's moved to controller linked list rather than remoteport
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/host/Kconfig  |   15 +
>  drivers/nvme/host/Makefile |    3 +
>  drivers/nvme/host/fc.c     | 2286 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2304 insertions(+)
>  create mode 100644 drivers/nvme/host/fc.c
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
