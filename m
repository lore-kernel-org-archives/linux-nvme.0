From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 25 Jul 2016 10:46:07 +0200
Subject: [PATCH] nvme-fabrics: patch target code in prep for FC transport
 support
In-Reply-To: <5792b917.3oKKdzw3zzjpaClb%james.smart@broadcom.com>
References: <5792b917.3oKKdzw3zzjpaClb%james.smart@broadcom.com>
Message-ID: <20160725084607.zwpnwgedysivtzva@c203.arch.suse.de>

On Fri, Jul 22, 2016@05:23:51PM -0700, James Smart wrote:
> 
> Patch nvme-fabrics target code in prep for FC transport support:
> - Add FC transport type decoding
> - Add FC address family decoding
> 
> Patch is cut against the linux-nvme for-4.8/drivers branch
> 
> Note: this patch had been posted to the prior nvme fabrics repository but
> not merged before being brought over to linux-nvme.
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
