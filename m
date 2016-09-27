From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 27 Sep 2016 09:38:08 +0200
Subject: [PATCH 1/9] blk-mq: Introduce blk_mq_queue_stopped()
In-Reply-To: <b2210943-62b2-959a-569a-a404da03bcae@sandisk.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
 <b2210943-62b2-959a-569a-a404da03bcae@sandisk.com>
Message-ID: <20160927073808.dfza42u2co7t7yi4@linux-x5ow.site>

On Mon, Sep 26, 2016@11:26:26AM -0700, Bart Van Assche wrote:
> The function blk_queue_stopped() allows to test whether or not a
> traditional request queue has been stopped. Introduce a helper
> function that allows block drivers to query easily whether or not
> one or more hardware contexts of a blk-mq queue have been stopped.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> ---

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
