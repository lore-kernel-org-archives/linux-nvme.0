From: hare@suse.de (Hannes Reinecke)
Date: Mon, 7 Nov 2016 07:56:02 +0100
Subject: [PATCH v5 5/7] nvme-fabrics: Add host support for FC transport
In-Reply-To: <58201df4.eHDpXvb36YEr/bgi%jsmart2021@gmail.com>
References: <58201df4.eHDpXvb36YEr/bgi%jsmart2021@gmail.com>
Message-ID: <44c8b248-3495-4354-3673-81547ade3d1a@suse.de>

On 11/07/2016 07:23 AM, James Smart wrote:
> 
> Add nvme-fabrics host support for FC transport
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
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> 
> ---
> v4 mods:
> - added HAS_DMA to Kconfig
> - Changed to support Christophs nvme_request update
> - addressed return code in __nvme_fc_abort_op()
> - fixed possible op->rq NULL reference in nvme_fc_start_fcp_op()
> - FC-NVME v1.11: process transferred length in ersp iu and rsp iu mandates
> - Add comments on teardown flow
> - fix bad cqe reference in fcpio_done
> 
>  MAINTAINERS                |    1 +
>  drivers/nvme/host/Kconfig  |   17 +
>  drivers/nvme/host/Makefile |    3 +
>  drivers/nvme/host/fc.c     | 2441 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 2462 insertions(+)
>  create mode 100644 drivers/nvme/host/fc.c
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
