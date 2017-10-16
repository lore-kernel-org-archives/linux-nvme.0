From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 16 Oct 2017 17:31:26 +0200
Subject: [PATCH v2] nvmet: protect sqhd update by a lock
In-Reply-To: <20171016151820.14766-1-jsmart2021@gmail.com>
References: <20171016151820.14766-1-jsmart2021@gmail.com>
Message-ID: <20171016153126.mg6q43nthpp4pjil@linux-x5ow.site>

Still somewhat awkward to read, maybe we can fold in a comment on why the lock
only touches these two lines and isn't used outside of this function anymore.

Anyways,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
