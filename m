From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 25 Jul 2016 11:12:53 +0200
Subject: [PATCH 2/5] nvme-fabrics: Add FC transport LLDD api definitions
In-Reply-To: <5792b91c.7HwdoM0qFRAjvQId%james.smart@broadcom.com>
References: <5792b91c.7HwdoM0qFRAjvQId%james.smart@broadcom.com>
Message-ID: <20160725091253.cq6lpgultbzleyq5@c203.arch.suse.de>

On Fri, Jul 22, 2016@05:23:56PM -0700, James Smart wrote:
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
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>

Acked-by: Johannes Thumshirn <jth at kernel.org>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
