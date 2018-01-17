From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 17 Jan 2018 09:50:50 +0100
Subject: [PATCH v2 2/2] nvme: add tracepoint for nvme_complete_rq
In-Reply-To: <20180116165026.GB9812@lst.de>
References: <20180116142821.11693-1-jthumshirn@suse.de>
 <20180116142821.11693-3-jthumshirn@suse.de>
 <20180116165026.GB9812@lst.de>
Message-ID: <20180117085050.7sq4wseu4qfcxs3n@linux-x5ow.site>

On Tue, Jan 16, 2018@05:50:26PM +0100, Christoph Hellwig wrote:
> Just pass the struct request?

OK

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
