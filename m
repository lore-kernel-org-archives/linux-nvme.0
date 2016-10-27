From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 27 Oct 2016 10:16:07 +0200
Subject: [PATCH 03/12] blk-mq: Introduce blk_mq_queue_stopped()
In-Reply-To: <f68b2997-8b0d-7aea-2859-5fbda4f6bf71@sandisk.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
 <f68b2997-8b0d-7aea-2859-5fbda4f6bf71@sandisk.com>
Message-ID: <20161027081607.4qwdtaxs4k5s5m4p@linux-x5ow.site>

On Wed, Oct 26, 2016@03:52:05PM -0700, Bart Van Assche wrote:
> The function blk_queue_stopped() allows to test whether or not a
> traditional request queue has been stopped. Introduce a helper
> function that allows block drivers to query easily whether or not
> one or more hardware contexts of a blk-mq queue have been stopped.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Reviewed-by: Hannes Reinecke <hare at suse.com>

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
