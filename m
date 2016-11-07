From: hare@suse.de (Hannes Reinecke)
Date: Mon, 7 Nov 2016 07:51:47 +0100
Subject: [PATCH v5 3/7] nvme-fabrics: Add FC transport FC-NVME definitions
In-Reply-To: <58201df2.IB/HS7zhIVqlgQnX%jsmart2021@gmail.com>
References: <58201df2.IB/HS7zhIVqlgQnX%jsmart2021@gmail.com>
Message-ID: <8bb83325-21f2-c295-fc13-65e0bba446af@suse.de>

On 11/07/2016 07:23 AM, James Smart wrote:
> 
> nvme-fabrics: Add FC transport FC-NVME definitions:
> - Formats for Cmd, Data, Rsp IUs
> - Formats FC-4 LS definitions
> - cmd_iu changed in T11. The 2 reserved words, previous at words
>   2 and 3, were moved to after the sqe.
> - Add to MAINTAINERS file
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> 
> ---
> v4 mods:
> - Sync with FC-NVME v1.11: add RS definitions
> 
>  MAINTAINERS             |   6 +
>  include/linux/nvme-fc.h | 294 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 300 insertions(+)
>  create mode 100644 include/linux/nvme-fc.h
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
