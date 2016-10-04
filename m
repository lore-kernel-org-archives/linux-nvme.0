From: hare@suse.de (Hannes Reinecke)
Date: Tue, 4 Oct 2016 09:45:39 +0200
Subject: [PATCH 6/7] nvme-fabrics: Add target FC transport support
In-Reply-To: <57f34bb6.WaC46AHxpfzWXPWp%james.smart@broadcom.com>
References: <57f34bb6.WaC46AHxpfzWXPWp%james.smart@broadcom.com>
Message-ID: <18c5066f-cca9-f968-2c07-5dac44c1ca54@suse.de>

On 10/04/2016 08:27 AM, James Smart wrote:
> 
> Add nvme-fabrics target FC transport support
> 
> Implements the FC-NVME T11 definition of how nvme fabric capsules are
> performed on an FC fabric. Utilizes a lower-layer API to FC host adapters
> to send/receive FC-4 LS operations and perform the FCP transactions
> necessary to perform and FCP IO request for NVME.
> 
> The T11 definitions for FC-4 Link Services are implemented which create
> NVMeOF connections.  Implements the hooks with nvmet layer to pass NVME
> commands to it for processing and posting of data/response base to the
> host via the different connections.
> 
> The changes made since the prior patch:
> - Remove the todo's around dma_map_page(). No need to use dma_map_page()
> - Fix nvme_fc_register_targetport() comments per review
> - in LS handlers, standardized failure codes and meanings
> - Print NVMET_NR_QUEUES when we dislike its value
> - Fix return code handling in nvmet_fc_handle_ls_rqst() per review
> - Reworked teardown paths with ref counting
> - Teardown now invokes callbacks on completion of unregister functions
> - Removal of fabric name for nport qualifier. Not necessary in T11
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
>  drivers/nvme/target/Kconfig  |   10 +
>  drivers/nvme/target/Makefile |    2 +
>  drivers/nvme/target/fc.c     | 1969 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1981 insertions(+)
>  create mode 100644 drivers/nvme/target/fc.c
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
