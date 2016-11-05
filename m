From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Sat, 5 Nov 2016 10:16:23 +0100
Subject: [PATCH v4 4/7] nvme-fabrics: Add FC transport LLDD api definitions
In-Reply-To: <581cf3c4.5cFRlrvVLES+ceQL%james.smart@broadcom.com>
References: <581cf3c4.5cFRlrvVLES+ceQL%james.smart@broadcom.com>
Message-ID: <20161105091623.ausaedja6md7vws3@linux-x5ow.site>

On Fri, Nov 04, 2016@01:47:00PM -0700, James Smart wrote:
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

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
