From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 30 May 2017 12:23:05 +0200
Subject: [PATCH 7/7] nvme: provide UUID value to userspace
In-Reply-To: <20170530093003.GD16736@lst.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <e850e7d9548348ae46c82230a7077c89073e80f3.1496131397.git.jthumshirn@suse.de>
 <20170530093003.GD16736@lst.de>
Message-ID: <b8730917-f156-501f-b2fc-69a10a1ee6a3@suse.de>

On 05/30/2017 11:30 AM, Christoph Hellwig wrote:
> Eww.  This looks pretty sketchy and at least needs a good comment in
> the source.  Maybe even a printk_ratelimited warning.

Comment sure, but do we really need a warning?


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
