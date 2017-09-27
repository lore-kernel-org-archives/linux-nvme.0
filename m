From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 27 Sep 2017 10:38:13 +0200
Subject: [PATCH] nvmet_fc: Reduce work_q count
In-Reply-To: <20170927040958.5981-1-jsmart2021@gmail.com>
References: <20170927040958.5981-1-jsmart2021@gmail.com>
Message-ID: <20170927083813.qbm5un7m7z2uamxt@linux-x5ow.site>

On Tue, Sep 26, 2017@09:09:58PM -0700, James Smart wrote:
> Instead of a work_q per controller queue, use a global workqueue.

Could you be a bit more specific on why you want to use one global
nvme-fc workqueue?

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
