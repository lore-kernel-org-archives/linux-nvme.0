From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 09:37:41 +0200
Subject: [PATCH-v1 12/22] Fix driver usage of 128B WQEs when WQ_CREATE is
 V1.
In-Reply-To: <20170420044641.10657-13-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
 <20170420044641.10657-13-jsmart2021@gmail.com>
Message-ID: <20170420073740.GM6217@linux-x5ow.site>

On Wed, Apr 19, 2017@09:46:31PM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> There are two versions of a structure for queue creation and setup that the
> driver shares with FW. The driver was only treating as version 0.
> 
> Verify WQ_CREATE with 128B WQEs in V0 and V1.
> 
> Code review of another bug showed the driver passing
> 128B WQEs and 8 pages in WQ CREATE and V0.
> Code inspection/instrumentation showed that the driver
> uses V0 in WQ_CREATE and if the caller passes queue->entry_size
> 128B, the driver sets the hdr_version to V1 so all is good.
> When I tested the V1 WQ_CREATE, the mailbox failed causing
> the driver to unload.
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
