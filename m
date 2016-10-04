From: hare@suse.de (Hannes Reinecke)
Date: Tue, 4 Oct 2016 09:36:44 +0200
Subject: [PATCH 3/7] nvme-fabrics: Add FC transport LLDD api definitions
In-Reply-To: <57f34bb3.U9l0eB8GDwRhZlnY%james.smart@broadcom.com>
References: <57f34bb3.U9l0eB8GDwRhZlnY%james.smart@broadcom.com>
Message-ID: <e05c6248-f01e-34c1-0879-6a706b2bd910@suse.de>

On 10/04/2016 08:26 AM, James Smart wrote:
> 
> nvme-fabrics: Add FC transport LLDD api definitions:
> 
> Host:
> -LLDD registration with the host transport
> -registering host ports (local ports) and target ports seen on
>    fabric (remote ports)
> -Data structures and call points for FC-4 LS's and FCP IO requests
> 
> Target:
> -LLDD registration with the target transport
> -registering nvme subsystem ports (target ports)
> -Data structures and call points for reception of FC-4 LS's and
>    FCP IO requests, and callbacks to perform data and rsp transfers
>    for the io.
> 
> (Patch unchanged from prior posting)
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Acked-by: Johannes Thumshirn <jth at kernel.org>
> Acked-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> ---
>  include/linux/nvme-fc-driver.h | 823 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 823 insertions(+)
>  create mode 100644 include/linux/nvme-fc-driver.h
> 
We really need to work on integration with the SCSI FC code.
But I'd rather see to get this in first.
So:

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
