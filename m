From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 4 Jun 2018 14:01:06 +0200
Subject: [PATCH 4/9] nvme: always failover on path or transport errors
In-Reply-To: <20180604062923.GA20662@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-5-hch@lst.de>
 <20180601152711.GA98855@redhat.com> <20180604062923.GA20662@lst.de>
Message-ID: <20180604120106.ij3vkv4evcmf354d@linux-x5ow.site>

On Mon, Jun 04, 2018@08:29:23AM +0200, Christoph Hellwig wrote:
> But we could probably add a BLK_STS_PATH and I'll map it to that.

Sound like a good idea to me.

Anyways,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
