From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 22 Jan 2018 16:30:41 +0100
Subject: [PATCH v4 2/2] nvme: add tracepoint for nvme_complete_rq
In-Reply-To: <20180122152340.GB5818@lst.de>
References: <20180119141819.11938-1-jthumshirn@suse.de>
 <20180119141819.11938-3-jthumshirn@suse.de>
 <20180122152340.GB5818@lst.de>
Message-ID: <20180122153040.2myfgm7hvjtd5n3d@linux-x5ow.site>

On Mon, Jan 22, 2018@04:23:40PM +0100, Christoph Hellwig wrote:
> Wouldn't some indication on which queue this completion happens
> be useful?

Probably yes. I'll add it in v5.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
