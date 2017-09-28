From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 28 Sep 2017 16:04:08 +0200
Subject: [PATCH] nvmet_fc: Reduce work_q count
In-Reply-To: <4e34dfe9-ead4-aa61-bd71-0561fba6d14a@gmail.com>
References: <20170927040958.5981-1-jsmart2021@gmail.com>
 <20170927083813.qbm5un7m7z2uamxt@linux-x5ow.site>
 <4e34dfe9-ead4-aa61-bd71-0561fba6d14a@gmail.com>
Message-ID: <20170928140328.jqrqfxlha36p7y3f@linux-x5ow.site>

On Wed, Sep 27, 2017@08:40:54AM -0700, James Smart wrote:
> Based on the recommendation from Christoph:
> http://lists.infradead.org/pipermail/linux-nvme/2017-May/010388.html
> 
> This patch has gone through several itterations with the last recommendation
> being the single work_q.

Ah OK thanks

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
