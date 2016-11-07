From: hare@suse.de (Hannes Reinecke)
Date: Mon, 7 Nov 2016 07:53:29 +0100
Subject: [PATCH v5 4/7] nvme-fabrics: Add FC transport LLDD api definitions
In-Reply-To: <58201df3./R4rmMdIaKAuYBto%jsmart2021@gmail.com>
References: <58201df3./R4rmMdIaKAuYBto%jsmart2021@gmail.com>
Message-ID: <cee41571-3200-3941-d852-5e357eb65440@suse.de>

On 11/07/2016 07:23 AM, James Smart wrote:
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
> Add to MAINTAINERS file
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
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
