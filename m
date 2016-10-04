From: hare@suse.de (Hannes Reinecke)
Date: Tue, 4 Oct 2016 09:32:39 +0200
Subject: [PATCH 1/7] nvme-fabrics: Add FC transport FC-NVME definitions
In-Reply-To: <57f34bb1.R7Xz9kkZOAJuQODz%james.smart@broadcom.com>
References: <57f34bb1.R7Xz9kkZOAJuQODz%james.smart@broadcom.com>
Message-ID: <60438ee8-66d4-4730-fed3-470a12bfa9a1@suse.de>

On 10/04/2016 08:26 AM, James Smart wrote:
> 
> nvme-fabrics: Add FC transport FC-NVME definitions:
> - Formats for Cmd, Data, Rsp IUs
> - Formats FC-4 LS definitions
> 
> (Patch unchanged from prior posting)
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Acked-by: Johannes Thumshirn <jth at kernel.org>
> Acked-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> ---
>  include/linux/nvme-fc.h | 296 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 296 insertions(+)
>  create mode 100644 include/linux/nvme-fc.h
> 

I would have loved to use the SCSI FC headers here; eg the definitions
for FC-LS are most definitely duplicated.
But until we've sorted that one out:

Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
