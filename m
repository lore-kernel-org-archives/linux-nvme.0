From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 19 Oct 2017 09:22:09 +0200
Subject: [PATCH 11/17] nvme: get rid of nvme_ctrl_list
In-Reply-To: <20171018165258.23212-12-hch@lst.de> (Christoph Hellwig's message
 of "Wed, 18 Oct 2017 18:52:52 +0200")
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-12-hch@lst.de>
Message-ID: <mqd60bb7gbi.fsf@linux-x5ow.site>

I'm not sure if the removel of the major number module_param is good
from an ABI POV. This could lead to some unexpected results for those
poor souls that used it.

Apart from that,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
