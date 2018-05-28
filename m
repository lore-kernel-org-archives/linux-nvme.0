From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 28 May 2018 08:53:42 +0200
Subject: [PATCH 08/14] nvmet: implement the changed namespaces log
In-Reply-To: <20180526102735.31404-9-hch@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-9-hch@lst.de>
Message-ID: <20180528065342.hi74ewwbvkoqsj6x@linux-x5ow.site>

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

As a side note, what happens if more than 1024 Namespaces are changed
(apart from setting the 1st element to 0xffffffff and zeroing out the
rest)?

The Spec is pretty silent in this regard.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
