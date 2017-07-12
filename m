From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 12 Jul 2017 14:01:52 +0200
Subject: [PATCH] nvme: add wrapper for nvme ctrl register r/w
In-Reply-To: <20170712115547.GA11085@lst.de>
References: <20170629172624.GA17319@localhost.didichuxing.com>
 <20170712072018.GA5739@lst.de>
 <ad43c2ae-c3af-351d-7a58-0f2f35e79d30@grimberg.me>
 <20170712115547.GA11085@lst.de>
Message-ID: <20170712120152.GD4115@linux-x5ow.site>

On Wed, Jul 12, 2017@01:55:47PM +0200, Christoph Hellwig wrote:
> Mostly because it's a little shorter and we're only going to get
> more and more of these calls.  In the end I don't feel strongly
> and we can just skip the patch for now and reconsider it once
> we have more register read/write calls.

I'm in favour of the patch as well. It hides the transport specific
implementation details quite good.

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
