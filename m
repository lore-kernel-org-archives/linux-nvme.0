From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 10:11:16 +0200
Subject: [PATCH-v1 21/22] Fix Express lane queue creation.
In-Reply-To: <20170420044641.10657-22-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
 <20170420044641.10657-22-jsmart2021@gmail.com>
Message-ID: <20170420081114.GU6217@linux-x5ow.site>

On Wed, Apr 19, 2017@09:46:40PM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> The older sli4 adapters only supported the 64 byte WQE entry size.
> The new adapter (fw) support both 64 and 128 byte WQE entry sizies.
> The Express lane WQ was not being created with the 128 byte WQE sizes
> when it was supported.
> 
> Not having the right WQE size created for the express lane work queue
> caused the the firmware to overwrite the lun indentifier in the FCP header.
> 
> This patch correctly creates the express lane work queue with the
> supported size.
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
