From: hare@suse.de (Hannes Reinecke)
Date: Mon, 7 Nov 2016 07:59:43 +0100
Subject: [PATCH v5 6/7] nvme-fabrics: Add target support for FC transport
In-Reply-To: <58201df5.VwHW5e3+1qgK/Why%jsmart2021@gmail.com>
References: <58201df5.VwHW5e3+1qgK/Why%jsmart2021@gmail.com>
Message-ID: <cf10de9e-bbed-8658-0dc6-99d5b8d1fdd8@suse.de>

On 11/07/2016 07:23 AM, James Smart wrote:
> 
> Add nvme-fabrics target support for FC transport
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
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
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
