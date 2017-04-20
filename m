From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 09:35:35 +0200
Subject: [PATCH-v1 10/22] Fix PRLI ACC rsp for NVME
In-Reply-To: <20170420044641.10657-11-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
 <20170420044641.10657-11-jsmart2021@gmail.com>
Message-ID: <20170420073535.GK6217@linux-x5ow.site>

On Wed, Apr 19, 2017@09:46:29PM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> PRLI ACC from target is FCP oriented.
> 
> Word 0 was wrong. This was noticed by another nvmet-fc vendor that
> was testing the lpfc nvme-fc initiator with their target.
> 
> Verified results with analyzer.
> 
> PRLI
> BC B5 56 56  22 61 04 00  00 61 00 00  01 29 00 00  20 00 00 00
> 00 10 FF FF  00 00 00 00  20 14 00 18  28 00 00 00  00 00 00 00
> 00 00 00 00  00 00 00 20  00 00 00 00  9C D8 DA C9  BC 95 75 75
> 
> ACC
> BC B5 56 56  23 61 00 00  00 61 04 00  01 98 00 00  30 00 00 00
> 00 10 00 18  00 00 00 00  02 14 00 18  28 00 01 00  00 00 00 00
> 00 00 00 00  00 00 00 18  00 00 00 00  B0 6B 07 57  BC B5 75 75
> 
> Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
