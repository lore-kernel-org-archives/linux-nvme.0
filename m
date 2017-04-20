From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 20 Apr 2017 09:33:42 +0200
Subject: [PATCH-v1 05/22] Add debug messages for nvme/fcp resource
 allocation.
In-Reply-To: <20170420044641.10657-6-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
 <20170420044641.10657-6-jsmart2021@gmail.com>
Message-ID: <20170420073341.GF6217@linux-x5ow.site>

On Wed, Apr 19, 2017@09:46:24PM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> The xri resources are split into pools for NVME and FCP IO when NVME is
> enabled. There was not message in the log that identified this allocation.
> 
> Added debug message to log XRI split.
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
