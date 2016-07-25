From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 25 Jul 2016 10:52:21 +0200
Subject: [PATCH] nvme-fabrics: set sqe.command_id in core, not transports
In-Reply-To: <5792b918.ManFlYqqCmUKB4ry%james.smart@broadcom.com>
References: <5792b918.ManFlYqqCmUKB4ry%james.smart@broadcom.com>
Message-ID: <20160725085221.7whke6ggh34lw72g@c203.arch.suse.de>

On Fri, Jul 22, 2016@05:23:52PM -0700, James Smart wrote:
> 
> set sqe.command_id in core, not transports
> 
> Patch is cut against the linux-nvme for-4.8/drivers branch
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
