From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 20 Sep 2017 12:30:41 +0200
Subject: [PATCH v3 1/3] nvme_fc: create fc class and transport device
In-Reply-To: <20170918161330.GC310@infradead.org>
References: <20170914173843.3195-1-jsmart2021@gmail.com>
 <20170914173843.3195-2-jsmart2021@gmail.com>
 <20170918161330.GC310@infradead.org>
Message-ID: <20170920103041.idkzk5kerewgv5yk@linux-x5ow.site>

On Mon, Sep 18, 2017@09:13:30AM -0700, Christoph Hellwig wrote:
> Looks ok,
> 
> although I really wish we could come up with some common FC code,
> including making the existing FC drivers use more infrastructure
> from libfc..

the problem with libfc currently is it is made for fcoe, despite being named
libfc. The other hand it is hard-wired to FCP so bringing NVMe into it is a
bit challanging, BTDT.

It's not that it is impossible, it's just not something that can be done in a
day or two of hacking.

Anyways,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
