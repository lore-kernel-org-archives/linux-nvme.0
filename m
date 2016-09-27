From: hare@suse.de (Hannes Reinecke)
Date: Tue, 27 Sep 2016 08:20:57 +0200
Subject: [PATCH 1/9] blk-mq: Introduce blk_mq_queue_stopped()
In-Reply-To: <b2210943-62b2-959a-569a-a404da03bcae@sandisk.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
 <b2210943-62b2-959a-569a-a404da03bcae@sandisk.com>
Message-ID: <5a954988-1b81-5bc2-c2e9-5e0eae927a46@suse.de>

On 09/26/2016 08:26 PM, Bart Van Assche wrote:
> The function blk_queue_stopped() allows to test whether or not a
> traditional request queue has been stopped. Introduce a helper
> function that allows block drivers to query easily whether or not
> one or more hardware contexts of a blk-mq queue have been stopped.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> ---
>  block/blk-mq.c         | 20 ++++++++++++++++++++
>  include/linux/blk-mq.h |  1 +
>  2 files changed, 21 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
